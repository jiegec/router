`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2019 04:03:15 PM
// Design Name: 
// Module Name: port
// Project Name: 
// Target Devices: xc7z020clg484-2
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "constants.vh"

module port #(
    parameter shared = 1
) (
    input clk,
    input gtx_clk, // 125MHz
    input reset_n,

    input [`PORT_WIDTH-1:0] port_id,
    input [`IPV4_WIDTH-1:0] port_ip,
    input [`MAC_WIDTH-1:0] port_mac,

    // ARP table
    output logic arp_arbiter_req,
    input arp_arbiter_granted,
    output logic [`IPV4_WIDTH-1:0] arp_insert_ip,
    output logic [`MAC_WIDTH-1:0] arp_insert_mac,
    output logic [`PORT_WIDTH-1:0] arp_insert_port,
    output logic arp_insert_valid,
    input logic arp_insert_ready,

    // fifo matrix
    // tx
    input  [`PORT_COUNT-1:0][`BYTE_WIDTH-1:0] fifo_matrix_tx_wdata,
    input [`PORT_COUNT-1:0]fifo_matrix_tx_wlast ,
    input [`PORT_COUNT-1:0]fifo_matrix_tx_wvalid,
    output [`PORT_COUNT-1:0]fifo_matrix_tx_wready,
    // rx
    output [`PORT_COUNT-1:0][`BYTE_WIDTH-1:0] fifo_matrix_rx_wdata,
    output [`PORT_COUNT-1:0]fifo_matrix_rx_wlast,
    output [`PORT_COUNT-1:0]fifo_matrix_rx_wvalid,
    input [`PORT_COUNT-1:0]fifo_matrix_rx_wready,

    // shared=1
    input gtx_clk90, // 125MHz, 90 deg shift
    // shared=0
    output gtx_clk_out, // 125MHz
    output gtx_clk90_out, // 125MHz, 90 deg shift
    input refclk, // 200MHz

    input logic [3:0] rgmii_rd,
    input logic rgmii_rx_ctl,
    input logic rgmii_rxc,
    output logic [3:0] rgmii_td,
    output logic rgmii_tx_ctl,
    output logic rgmii_txc
    );

    logic reset;
    assign reset = ~reset_n;

    logic rx_enable;

    logic [27:0] rx_statistics_vector;
    logic rx_statistics_valid;

    logic rx_mac_aclk;
    (*mark_debug = "true"*) logic rx_reset;
    (*mark_debug = "true"*) logic [7:0] rx_axis_mac_tdata;
    (*mark_debug = "true"*) logic rx_axis_mac_tvalid;
    (*mark_debug = "true"*) logic rx_axis_mac_tlast;
    (*mark_debug = "true"*) logic rx_axis_mac_tuser;

    logic tx_enable;

    logic [31:0] tx_statistics_vector;
    logic tx_statistics_valid;
    logic tx_mac_aclk;
    logic tx_reset;
    logic [7:0] tx_axis_mac_tdata = 0;
    logic tx_axis_mac_tvalid = 0;
    logic tx_axis_mac_tlast = 0;
    logic tx_axis_mac_tuser = 0;
    logic tx_axis_mac_tready;

    logic speedis100;
    logic speedis10100;

    logic link_status;
    logic [1:0] clock_speed;
    logic duplex_status;

    logic [15:0] counter = 0;

    always @ (posedge tx_mac_aclk) begin
        if (!reset_n) begin
            counter <= 0;
        end else begin
            if (counter == 0) begin
                counter <= 16'hffffff;
                tx_axis_mac_tdata <= 0;
                tx_axis_mac_tvalid <= 0;
                tx_axis_mac_tlast = 0;
            end else begin
                counter <= counter - 1;
                if (counter < 16) begin
                    tx_axis_mac_tdata <= 8'hff;
                    tx_axis_mac_tvalid <= 1;
                    tx_axis_mac_tlast = counter == 1;
                end else begin
                    tx_axis_mac_tdata <= 0;
                    tx_axis_mac_tvalid <= 0;
                    tx_axis_mac_tlast = 0;
                end
            end
        end
    end

    logic [`BYTE_WIDTH-1:0] rx_data_out;
    (*mark_debug = "true"*) logic rx_data_ren = 0;

    (*mark_debug = "true"*) logic rx_data_full;
    (*mark_debug = "true"*) logic [`BYTE_WIDTH-1:0] rx_data_in;
    (*mark_debug = "true"*) logic rx_data_busy;
    (*mark_debug = "true"*) logic rx_data_wen;
    (*mark_debug = "true"*) logic rx_axis_mac_tvalid_last;

    // stores ethernet frame data
    xpm_fifo_async #(
        .READ_DATA_WIDTH(`BYTE_WIDTH),
        .WRITE_DATA_WIDTH(`BYTE_WIDTH),
        .FIFO_WRITE_DEPTH(`MAX_FIFO_SIZE),
        .PROG_FULL_THRESH(`MAX_FIFO_SIZE - `MAX_ETHERNET_FRAME_BYTES)
    ) xpm_fifo_zsync_inst_rx_data (
        .dout(rx_data_out),
        .rd_en(rx_data_ren),
        .rd_clk(clk),

        .prog_full(rx_data_full),
        .din(rx_data_in),
        .rst(reset),
        .wr_clk(rx_mac_aclk),
        .wr_en(rx_data_wen),
        .wr_rst_busy(rx_data_busy)
    );

    logic [`LENGTH_WIDTH-1:0] rx_len_out;
    logic rx_len_ren = 0;
    logic rx_len_empty;

    logic rx_len_full;
    logic [`LENGTH_WIDTH-1:0] rx_len_in;
    logic rx_len_busy;
    logic rx_len_wen;

    logic [`LENGTH_WIDTH-1:0] rx_length;

    // stores ethernet frame length
    xpm_fifo_async #(
        .READ_DATA_WIDTH(`LENGTH_WIDTH),
        .WRITE_DATA_WIDTH(`LENGTH_WIDTH),
        .FIFO_WRITE_DEPTH(`MAX_FIFO_SIZE),
        .PROG_FULL_THRESH(`MAX_FIFO_SIZE - 16)
    ) xpm_fifo_zsync_inst_rx_len (
        .dout(rx_len_out),
        .rd_en(rx_len_ren),
        .rd_clk(clk),
        .empty(rx_len_empty),

        .prog_full(rx_len_full),
        .din(rx_len_in),
        .rst(reset),
        .wr_clk(rx_mac_aclk),
        .wr_en(rx_len_wen),
        .wr_rst_busy(rx_len_busy)
    );

    // store received ethernet frame into fifo, data first, then len
    always_ff @ (posedge rx_mac_aclk) begin
        if (reset) begin
            rx_data_wen <= 0;
            rx_axis_mac_tvalid_last <= 0;
            rx_length <= 0;
            rx_len_wen <= 0;
            rx_len_in <= 0;
        end else begin
            rx_axis_mac_tvalid_last <= rx_axis_mac_tvalid;
            if (rx_axis_mac_tvalid && !rx_axis_mac_tvalid_last && !rx_data_busy && !rx_data_full && !rx_len_busy && !rx_len_full) begin
                // begin
                rx_data_wen <= 1;
                rx_length <= 1;
                rx_data_in <= rx_axis_mac_tdata;
                rx_len_wen <= 0;
                rx_len_in <= 0;
            end else if (!rx_axis_mac_tvalid && rx_axis_mac_tvalid_last) begin
                // end
                rx_data_wen <= 0;
                rx_data_in <= 0;
                rx_len_wen <= 1;
                rx_len_in <= rx_length;
            end else begin
                // progress
                if (rx_data_wen) begin
                    rx_length <= rx_length + 1;
                    rx_data_in <= rx_axis_mac_tdata;
                end else begin
                    rx_data_in <= 0;
                    rx_length <= 0;
                end
                rx_len_wen <= 0;
                rx_len_in <= 0;
            end
        end
    end

    logic rx_read;
    logic [`LENGTH_WIDTH-1:0] rx_read_length;
    logic [`BYTE_WIDTH-1:0] rx_read_data;
    logic [`LENGTH_WIDTH-1:0] rx_read_counter;
    logic [`MAC_WIDTH-1:0] rx_saved_src_mac_addr;
    logic [`ETHERTYPE_WIDTH-1:0] rx_saved_ethertype;
    logic [`IPV4_WIDTH-1:0] rx_saved_arp_src_ipv4_addr;

    logic arp_write;
    logic arp_written;

    always_ff @ (posedge clk) begin
        if (reset) begin
            rx_len_ren <= 0;
            rx_data_ren <= 0;
            rx_read <= 0;
            rx_saved_src_mac_addr <= 0;
            rx_saved_ethertype <= 0;
            rx_saved_arp_src_ipv4_addr <= 0;
            arp_write <= 0;
            arp_insert_valid <= 0;
            arp_written <= 0;
        end else begin
            if (!rx_len_empty && !rx_read && !arp_write) begin 
                rx_read <= 1;
                rx_len_ren <= 1;
                rx_data_ren <= 1;
                rx_read_counter <= -2;
                rx_saved_src_mac_addr <= 0;
                rx_saved_ethertype <= 0;
                rx_saved_arp_src_ipv4_addr <= 0;
                arp_written <= 0;
            end else begin
                rx_len_ren <= 0;
                if (rx_read) begin
                    if (!rx_len_ren && rx_read) begin
                        rx_read_length <= rx_len_out;
                    end
                    rx_read_counter <= rx_read_counter + 1;
                    rx_read_data <= rx_data_out;
                    if (rx_read_counter >= `SOURCE_MAC_BEGIN && rx_read_counter < `SOURCE_MAC_END) begin
                        rx_saved_src_mac_addr <= {rx_saved_src_mac_addr[`MAC_WIDTH-`BYTE_WIDTH-1:0], rx_read_data};
                    end
                    if (rx_read_counter >= `ETHERTYPE_BEGIN && rx_read_counter < `ETHERTYPE_END) begin
                        rx_saved_ethertype <= {rx_saved_ethertype[`ETHERTYPE_WIDTH-`BYTE_WIDTH-1:0], rx_read_data};
                    end
                    if (rx_read_counter >= `ARP_SRC_IPV4_BEGIN && rx_read_counter < `ARP_SRC_IPV4_END) begin
                        rx_saved_arp_src_ipv4_addr <= {rx_saved_arp_src_ipv4_addr[`IPV4_WIDTH-`BYTE_WIDTH-1:0], rx_read_data};
                    end

                    if (rx_read_counter == rx_read_length - 2) begin
                        rx_read <= 0;
                        rx_data_ren <= 0;
                    end

                    if (rx_saved_ethertype == `ARP_ETHERTYPE && rx_read_counter > `ARP_SRC_IPV4_END && !arp_write && !arp_written) begin
                        arp_written <= 1;
                        arp_write <= 1;
                        arp_arbiter_req <= 1;
                        arp_insert_valid <= 0;
                        arp_insert_ip <= rx_saved_arp_src_ipv4_addr;
                        arp_insert_mac <= rx_saved_src_mac_addr;
                        arp_insert_port <= port_id;
                    end
                end
                if (arp_write) begin
                    if (arp_arbiter_granted && arp_insert_ready) begin
                        arp_insert_valid <= 1;
                        arp_write <= 0;
                        arp_arbiter_req <= 0;
                    end
                end
            end
        end
    end

    generate
        if (!shared) begin
            tri_mode_ethernet_mac_0 tri_mode_ethernet_mac_0_inst (
                .gtx_clk(gtx_clk),
                .gtx_clk_out(gtx_clk_out),
                .gtx_clk90_out(gtx_clk90_out),
                .refclk(refclk),

                .glbl_rstn(reset_n),
                .rx_axi_rstn(reset_n),
                .tx_axi_rstn(reset_n),

                .rx_enable(rx_enable),

                .rx_statistics_vector(rx_statistics_vector),
                .rx_statistics_valid(rx_statistics_valid),

                .rx_mac_aclk(rx_mac_aclk),
                .rx_reset(rx_reset),
                .rx_axis_mac_tdata(rx_axis_mac_tdata),
                .rx_axis_mac_tvalid(rx_axis_mac_tvalid),
                .rx_axis_mac_tlast(rx_axis_mac_tlast),
                .rx_axis_mac_tuser(rx_axis_mac_tuser),

                .tx_enable(tx_enable),

                .tx_ifg_delay(8'b00000000),
                .tx_statistics_vector(tx_statistics_vector),
                .tx_statistics_valid(tx_statistics_valid),

                .tx_mac_aclk(tx_mac_aclk),
                .tx_reset(tx_reset),
                .tx_axis_mac_tdata(tx_axis_mac_tdata),
                .tx_axis_mac_tvalid(tx_axis_mac_tvalid),
                .tx_axis_mac_tlast(tx_axis_mac_tlast),
                .tx_axis_mac_tuser(tx_axis_mac_tuser),
                .tx_axis_mac_tready(tx_axis_mac_tready),

                .pause_req(1'b0),
                .pause_val(16'b0),

                .speedis100(speedis100),
                .speedis10100(speedis10100),

                .rgmii_txd(rgmii_td),
                .rgmii_tx_ctl(rgmii_tx_ctl),
                .rgmii_txc(rgmii_txc),
                .rgmii_rxd(rgmii_rd),
                .rgmii_rx_ctl(rgmii_rx_ctl),
                .rgmii_rxc(rgmii_rxc),
                .inband_link_status(link_status),
                .inband_clock_speed(clock_speed),
                .inband_duplex_status(duplex_status),

                // receive 1Gb/s | promiscuous | flow control | fcs | enable
                .rx_configuration_vector(80'b10100000101010),
                // transmit 1Gb/s | enable
                .tx_configuration_vector(80'b10000000000010)
            );
        end else begin
            assign gtx_clk_out = 0;
            assign gtx_clk90_out = 0;
            tri_mode_ethernet_mac_0_shared tri_mode_ethernet_mac_0_shared_inst (
                .gtx_clk(gtx_clk),
                .gtx_clk90(gtx_clk90),

                .glbl_rstn(reset_n),
                .rx_axi_rstn(reset_n),
                .tx_axi_rstn(reset_n),

                .rx_enable(rx_enable),

                .rx_statistics_vector(rx_statistics_vector),
                .rx_statistics_valid(rx_statistics_valid),

                .rx_mac_aclk(rx_mac_aclk),
                .rx_reset(rx_reset),
                .rx_axis_mac_tdata(rx_axis_mac_tdata),
                .rx_axis_mac_tvalid(rx_axis_mac_tvalid),
                .rx_axis_mac_tlast(rx_axis_mac_tlast),
                .rx_axis_mac_tuser(rx_axis_mac_tuser),

                .tx_enable(tx_enable),

                .tx_ifg_delay(8'b00000000),
                .tx_statistics_vector(tx_statistics_vector),
                .tx_statistics_valid(tx_statistics_valid),

                .tx_mac_aclk(tx_mac_aclk),
                .tx_reset(tx_reset),
                .tx_axis_mac_tdata(tx_axis_mac_tdata),
                .tx_axis_mac_tvalid(tx_axis_mac_tvalid),
                .tx_axis_mac_tlast(tx_axis_mac_tlast),
                .tx_axis_mac_tuser(tx_axis_mac_tuser),
                .tx_axis_mac_tready(tx_axis_mac_tready),

                .pause_req(1'b0),
                .pause_val(16'b0),

                .speedis100(speedis100),
                .speedis10100(speedis10100),

                .rgmii_txd(rgmii_td),
                .rgmii_tx_ctl(rgmii_tx_ctl),
                .rgmii_txc(rgmii_txc),
                .rgmii_rxd(rgmii_rd),
                .rgmii_rx_ctl(rgmii_rx_ctl),
                .rgmii_rxc(rgmii_rxc),
                .inband_link_status(link_status),
                .inband_clock_speed(clock_speed),
                .inband_duplex_status(duplex_status),

                // receive 1Gb/s | promiscuous | flow control | fcs | enable
                .rx_configuration_vector(80'b10100000101010),
                // transmit 1Gb/s | enable
                .tx_configuration_vector(80'b10000000000010)
            );
        end
    endgenerate
    
endmodule
