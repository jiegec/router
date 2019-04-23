`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 09:12:32 PM
// Design Name: 
// Module Name: top_axi
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

module top_axi(
    input logic clk,
    input logic reset_n_in,
    output logic led,
    
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
    output logic rgmii2_txc
    );
    
    logic reset;
    logic reset_n;
    assign reset = ~reset_n;
    
    logic internal_clk; // 10MHz
    logic gtx_clk_in; // 125MHz
    logic refclk; // 200MHz
    
    clk_wiz_0 mmcm_inst(
        .clk_in1(clk),
        .clk_out1(gtx_clk_in),
        .clk_out3(internal_clk),
        .clk_out4(refclk),
        .reset(~reset_n_in),
        .locked(reset_n)
    );

    logic gtx_clk; // 125MHz
    logic gtx_clk90; // 125MHz, 90 deg shift

    logic [`IPV4_WIDTH-1:0] arp_lookup_ip;
    logic [`MAC_WIDTH-1:0] arp_lookup_mac;
    logic [1:0] arp_lookup_port;
    logic arp_lookup_ip_valid;
    logic arp_lookup_mac_valid;
    logic arp_lookup_mac_not_found;

    (*mark_debug = "true"*) logic [`IPV4_WIDTH-1:0] arp_insert_ip;
    (*mark_debug = "true"*) logic [`MAC_WIDTH-1:0] arp_insert_mac;
    (*mark_debug = "true"*) logic [`PORT_WIDTH-1:0] arp_insert_port;
    (*mark_debug = "true"*) logic arp_insert_valid;
    (*mark_debug = "true"*) logic arp_insert_ready;

    logic [`PORT_COUNT-1:0][`IPV4_WIDTH-1:0] port_arp_insert_ip;
    logic [`PORT_COUNT-1:0][`MAC_WIDTH-1:0] port_arp_insert_mac;
    logic [`PORT_COUNT-1:0][`PORT_WIDTH-1:0] port_arp_insert_port;
    logic [`PORT_COUNT-1:0] port_arp_insert_valid;
    logic [`PORT_COUNT-1:0] port_arp_insert_ready;

    arp_table arp_table_inst(
        .clk(internal_clk),
        .rst(reset),

        .lookup_ip(arp_lookup_ip),
        .lookup_mac(arp_lookup_mac),
        .lookup_port(arp_lookup_port),
        .lookup_ip_valid(arp_lookup_ip_valid),
        .lookup_mac_valid(arp_lookup_mac_valid),
        .lookup_mac_not_found(arp_lookup_mac_not_found),

        .insert_ip(arp_insert_ip),
        .insert_mac(arp_insert_mac),
        .insert_port(arp_insert_port),
        .insert_valid(arp_insert_valid),
        .insert_ready(arp_insert_ready)
    );

    logic [`PORT_COUNT-1:0] arbiter_req;
    logic [`PORT_COUNT-1:0] arbiter_grant;

    always_comb begin
        unique casez (arbiter_grant)
            4'b???1: begin
                port_arp_insert_ready[0] = arp_insert_ready;
                port_arp_insert_ready[1] = 0;
                port_arp_insert_ready[2] = 0;
                port_arp_insert_ready[3] = 0;
                arp_insert_valid = port_arp_insert_valid[0];
                arp_insert_ip = port_arp_insert_ip[0];
                arp_insert_mac = port_arp_insert_mac[0];
                arp_insert_port = port_arp_insert_port[0];
            end
            4'b??1?: begin
                port_arp_insert_ready[0] = 0;
                port_arp_insert_ready[1] = arp_insert_ready;
                port_arp_insert_ready[2] = 0;
                port_arp_insert_ready[3] = 0;
                arp_insert_valid = port_arp_insert_valid[1];
                arp_insert_ip = port_arp_insert_ip[1];
                arp_insert_mac = port_arp_insert_mac[1];
                arp_insert_port = port_arp_insert_port[1];
            end
            4'b?1??: begin
                port_arp_insert_ready[0] = 0;
                port_arp_insert_ready[1] = 0;
                port_arp_insert_ready[2] = arp_insert_ready;
                port_arp_insert_ready[3] = 0;
                arp_insert_valid = port_arp_insert_valid[2];
                arp_insert_ip = port_arp_insert_ip[2];
                arp_insert_mac = port_arp_insert_mac[2];
                arp_insert_port = port_arp_insert_port[2];
            end
            4'b1???: begin
                port_arp_insert_ready[0] = 0;
                port_arp_insert_ready[1] = 0;
                port_arp_insert_ready[2] = 0;
                port_arp_insert_ready[3] = arp_insert_ready;
                arp_insert_valid = port_arp_insert_valid[3];
                arp_insert_ip = port_arp_insert_ip[3];
                arp_insert_mac = port_arp_insert_mac[3];
                arp_insert_port = port_arp_insert_port[3];
            end
            4'b0000: begin
                port_arp_insert_ready[0] = 0;
                port_arp_insert_ready[1] = 0;
                port_arp_insert_ready[2] = 0;
                port_arp_insert_ready[3] = 0;
                arp_insert_valid = 0;
                arp_insert_ip = 0;
                arp_insert_mac = 0;
                arp_insert_port = 0;
            end
        endcase
    end

    arbiter arbiter_inst(
        .clk(internal_clk),
        .rst(rst),

        .req(arbiter_req),
        .grant(arbiter_grant)
    );

    port #(
        .shared(0)
    ) port_inst_0 (
        .clk(internal_clk),
        .reset_n(reset_n),
        .port_id(2'b00),

        .arbiter_req(arbiter_req[0]),
        .arbiter_granted(arbiter_grant[0]),
        .arp_insert_ip(port_arp_insert_ip[0]),
        .arp_insert_mac(port_arp_insert_mac[0]),
        .arp_insert_port(port_arp_insert_port[0]),
        .arp_insert_valid(port_arp_insert_valid[0]),
        .arp_insert_ready(port_arp_insert_ready[0]),

        .gtx_clk(gtx_clk_in),
        .gtx_clk_out(gtx_clk),
        .gtx_clk90_out(gtx_clk90),
        .refclk(refclk),

        .rgmii_td(rgmii1_td),
        .rgmii_tx_ctl(rgmii1_tx_ctl),
        .rgmii_txc(rgmii1_txc),
        .rgmii_rd(rgmii1_rd),
        .rgmii_rx_ctl(rgmii1_rx_ctl),
        .rgmii_rxc(rgmii1_rxc)
    );

    port #(
        .shared(1)
    ) port_inst_1 (
        .clk(internal_clk),
        .reset_n(reset_n),
        .port_id(2'b01),

        .arbiter_req(arbiter_req[1]),
        .arbiter_granted(arbiter_grant[1]),
        .arp_insert_ip(port_arp_insert_ip[1]),
        .arp_insert_mac(port_arp_insert_mac[1]),
        .arp_insert_port(port_arp_insert_port[1]),
        .arp_insert_valid(port_arp_insert_valid[1]),
        .arp_insert_ready(port_arp_insert_ready[1]),

        .gtx_clk(gtx_clk),
        .gtx_clk90(gtx_clk90),

        .rgmii_td(rgmii2_td),
        .rgmii_tx_ctl(rgmii2_tx_ctl),
        .rgmii_txc(rgmii2_txc),
        .rgmii_rd(rgmii2_rd),
        .rgmii_rx_ctl(rgmii2_rx_ctl),
        .rgmii_rxc(rgmii2_rxc)
    );

endmodule
