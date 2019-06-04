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
    input logic clk, // 50MHz
    input logic reset_n_in,

    input axis_clk,
    // from router to os
    output logic [`BYTE_WIDTH-1:0] axis_rxd_tdata,
    output logic axis_rxd_tlast,
    input axis_rxd_tready,
    output logic axis_rxd_tvalid,

    // from os to router
    input [`BYTE_WIDTH-1:0] axis_txd_tdata,
    input axis_txd_tlast,
    output logic axis_txd_tready,
    input axis_txd_tvalid,
    
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

    output logic [`PORT_OS_COUNT-1:0][`STATS_WIDTH-1:0] stats_rx_packets,
    output logic [`PORT_OS_COUNT-1:0][`STATS_WIDTH-1:0] stats_rx_bytes,
    output logic [`PORT_OS_COUNT-1:0][`STATS_WIDTH-1:0] stats_tx_packets,
    output logic [`PORT_OS_COUNT-1:0][`STATS_WIDTH-1:0] stats_tx_bytes,

    input os_clk,
    input [15:0] os_addr,
    input [`ROUTING_TABLE_ENTRY_WIDTH-1:0] os_din,
    output [`ROUTING_TABLE_ENTRY_WIDTH-1:0] os_dout,
    input [(`ROUTING_TABLE_ENTRY_WIDTH)/`BYTE_WIDTH-1:0] os_wea,
    input os_rst,
    input os_en
    );
    
    logic reset;
    logic reset_n_0;
    logic reset_n_1;
    logic reset_n;
    assign reset_n = reset_n_0 & reset_n_1;
    assign reset = ~reset_n;
    
    logic internal_clk;
    logic clk125M; // 125MHz
    logic clk200M; // 200MHz
    
    clk_wiz_0 mmcm_inst_0(
        .clk_in1(clk),
        .clk_out1(clk125M),
        .clk_out3(clk200M),
        .reset(~reset_n_in),
        .locked(reset_n_0)
    );

    clk_wiz_1 mmcm_inst_1(
        .clk_in1(clk200M),
        .clk_out1(internal_clk),
        .reset(~reset_n_in),
        .locked(reset_n_1)
    );

    router router_inst(
        .clk(internal_clk),
        .clk125M(clk125M),
        .clk200M(clk200M),
        .reset_n(reset_n),

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

        .stats_rx_packets(stats_rx_packets),
        .stats_rx_bytes(stats_rx_bytes),
        .stats_tx_packets(stats_tx_packets),
        .stats_tx_bytes(stats_tx_bytes),

        .os_clk(os_clk),
        .os_addr(os_addr),
        .os_din(os_din),
        .os_dout(os_dout),
        .os_wea(os_wea),
        .os_rst(os_rst),
        .os_en(os_en)
    );

endmodule
