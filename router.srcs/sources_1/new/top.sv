`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2019 12:57:52 AM
// Design Name: 
// Module Name: top
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

module top(
    input logic clk, // 50MHz
    input logic reset_n_in,
    output logic led,

    // DDR & FIXEDIO for PS
    inout [14:0]DDR_addr,
    inout [2:0]DDR_ba,
    inout DDR_cas_n,
    inout DDR_ck_n,
    inout DDR_ck_p,
    inout DDR_cke,
    inout DDR_cs_n,
    inout [3:0]DDR_dm,
    inout [31:0]DDR_dq,
    inout [3:0]DDR_dqs_n,
    inout [3:0]DDR_dqs_p,
    inout DDR_odt,
    inout DDR_ras_n,
    inout DDR_reset_n,
    inout DDR_we_n,

    inout FIXED_IO_ddr_vrn,
    inout FIXED_IO_ddr_vrp,
    inout [53:0]FIXED_IO_mio,
    inout FIXED_IO_ps_clk,
    inout FIXED_IO_ps_porb,
    inout FIXED_IO_ps_srstb,

    // rgmii
    input logic [3:0] rgmii1_rd,
    input logic rgmii1_rx_ctl,
    input logic rgmii1_rxc,
    output logic [3:0] rgmii1_td,
    output logic rgmii1_tx_ctl,
    output logic rgmii1_txc,

    input logic [3:0] rgmii2_rd,
    input logic rgmii2_rx_ctl,
    input logic rgmii2_rxc,
    output logic [3:0] rgmii2_td,
    output logic rgmii2_tx_ctl,
    output logic rgmii2_txc,

    // HDMI
    inout hdmi_i2c_scl_io,
    inout hdmi_i2c_sda_io,
    output hdmi_out_clk,
    output [23:0]hdmi_out_data,
    output hdmi_out_de,
    output hdmi_out_hs,
    output hdmi_out_vs,
    output [0:0]hdmi_rstn_tri_o
    );

    logic axis_clk;
    // from router to os
    logic [`BYTE_WIDTH-1:0] axis_rxd_tdata;
    logic axis_rxd_tlast;
    logic axis_rxd_tready;
    logic axis_rxd_tvalid;

    // from os to router
    logic [`BYTE_WIDTH-1:0] axis_txd_tdata;
    logic axis_txd_tlast;
    logic axis_txd_tready;
    logic axis_txd_tvalid;

    logic [`PORT_OS_COUNT-1:0][`STATS_WIDTH-1:0] stats_rx_packets;
    logic [`PORT_OS_COUNT-1:0][`STATS_WIDTH-1:0] stats_rx_bytes;
    logic [`PORT_OS_COUNT-1:0][`STATS_WIDTH-1:0] stats_tx_packets;
    logic [`PORT_OS_COUNT-1:0][`STATS_WIDTH-1:0] stats_tx_bytes;

    logic [`STATS_WIDTH-1:0] stats_total_rx_packets;
    logic [`STATS_WIDTH-1:0] stats_total_rx_bytes;
    logic [`STATS_WIDTH-1:0] stats_total_tx_packets;
    logic [`STATS_WIDTH-1:0] stats_total_tx_bytes;

    assign stats_total_rx_packets = stats_rx_packets[0] + stats_rx_packets[1];
    assign stats_total_rx_bytes = stats_rx_bytes[0] + stats_rx_bytes[1];
    assign stats_total_tx_packets = stats_tx_packets[0] + stats_tx_packets[1];
    assign stats_total_tx_bytes = stats_tx_bytes[0] + stats_tx_bytes[1];

    // accessing routing table
    logic os_clk;
    logic [16-1:0] os_addr;
    logic [`ROUTING_TABLE_ENTRY_WIDTH-1:0] os_din;
    logic [`ROUTING_TABLE_ENTRY_WIDTH-1:0] os_dout;
    logic [(`ROUTING_TABLE_ENTRY_WIDTH)/`BYTE_WIDTH-1:0] os_wea;
    logic os_rst;
    logic os_en;

    top_axi top_axi_inst(
        .clk(clk),
        .reset_n_in(reset_n_in),

        .axis_clk(axis_clk),
        .axis_rxd_tdata(axis_rxd_tdata),
        .axis_rxd_tlast(axis_rxd_tlast),
        .axis_rxd_tready(axis_rxd_tready),
        .axis_rxd_tvalid(axis_rxd_tvalid),
        .axis_txd_tdata(axis_txd_tdata),
        .axis_txd_tlast(axis_txd_tlast),
        .axis_txd_tready(axis_txd_tready),
        .axis_txd_tvalid(axis_txd_tvalid),

        .rgmii1_rd(rgmii1_rd),
        .rgmii1_rx_ctl(rgmii1_rx_ctl),
        .rgmii1_rxc(rgmii1_rxc),
        .rgmii1_td(rgmii1_td),
        .rgmii1_tx_ctl(rgmii1_tx_ctl),
        .rgmii1_txc(rgmii1_txc),

        .rgmii2_rd(rgmii2_rd),
        .rgmii2_rx_ctl(rgmii2_rx_ctl),
        .rgmii2_rxc(rgmii2_rxc),
        .rgmii2_td(rgmii2_td),
        .rgmii2_tx_ctl(rgmii2_tx_ctl),
        .rgmii2_txc(rgmii2_txc),

        .stats_rx_bytes(stats_rx_bytes),
        .stats_rx_packets(stats_rx_packets),
        .stats_tx_bytes(stats_tx_bytes),
        .stats_tx_packets(stats_tx_packets),

        .os_clk(os_clk),
        .os_addr(os_addr),
        .os_din(os_din),
        .os_dout(os_dout),
        .os_wea(os_wea),
        .os_rst(os_rst),
        .os_en(os_en)
    );

    design_1_wrapper design_1_inst(
        .AXI_STR_RXD_0_tdata(axis_rxd_tdata),
        .AXI_STR_RXD_0_tlast(axis_rxd_tlast),
        .AXI_STR_RXD_0_tready(axis_rxd_tready),
        .AXI_STR_RXD_0_tvalid(axis_rxd_tvalid),
        .AXI_STR_TXD_0_tdata(axis_txd_tdata),
        .AXI_STR_TXD_0_tlast(axis_txd_tlast),
        .AXI_STR_TXD_0_tready(axis_txd_tready),
        .AXI_STR_TXD_0_tvalid(axis_txd_tvalid),

        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),

        .FCLK_CLK0(axis_clk),

        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),

        .rx_bytes_tri_i(stats_total_rx_bytes),
        .rx_packets_tri_i(stats_total_rx_packets),

        .tx_bytes_tri_i(stats_total_tx_bytes),
        .tx_packets_tri_i(stats_total_tx_packets),

        .routing_table_addr(os_addr),
        .routing_table_clk(os_clk),
        .routing_table_din(os_din),
        .routing_table_dout(os_dout),
        .routing_table_en(os_en),
        .routing_table_rst(os_rst),
        .routing_table_we(os_wea),

        // HDMI
        .hdmi_i2c_scl_io(hdmi_i2c_scl_io),
        .hdmi_i2c_sda_io(hdmi_i2c_sda_io),
        .hdmi_out_clk(hdmi_out_clk),
        .hdmi_out_data(hdmi_out_data),
        .hdmi_out_de(hdmi_out_de),
        .hdmi_out_hs(hdmi_out_hs),
        .hdmi_out_vs(hdmi_out_vs),
        .hdmi_rstn_tri_o(hdmi_rstn_tri_o)
    );
endmodule
