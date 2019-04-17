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
    output logic rgmii1_txc
    );
    
    logic reset;
    logic reset_n;
    assign reset = ~reset_n;
    
    logic internal_clk; // 10MHz
    logic gtx_clk; // 125MHz
    logic gtx_clk90; // 125MHz, 90 deg shift
    logic refclk; // 200MHz
    
    clk_wiz_0 mmcm_inst(
        .clk_in1(clk),
        .clk_out1(gtx_clk),
        .clk_out2(gtx_clk90),
        .clk_out3(internal_clk),
        .clk_out4(refclk),
        .reset(~reset_n_in),
        .locked(reset_n)
    );

    logic rx_enable;

    logic [27:0] rx_statistics_vector;
    logic rx_statistics_valid;

    (*mark_debug = "true"*) logic rx_mac_aclk;
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

    assign led = link_status;
    
    tri_mode_ethernet_mac_0 tri_mode_ethernet_mac_0_inst (
        .gtx_clk(gtx_clk),
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

        .tx_ifg_delay(8'b11111111),
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

        .rgmii_txd(rgmii1_td),
        .rgmii_tx_ctl(rgmii1_tx_ctl),
        .rgmii_txc(rgmii1_txc),
        .rgmii_rxd(rgmii1_rd),
        .rgmii_rx_ctl(rgmii1_rx_ctl),
        .rgmii_rxc(rgmii1_rxc),
        .inband_link_status(link_status),
        .inband_clock_speed(clock_speed),
        .inband_duplex_status(duplex_status),

        .rx_configuration_vector(80'b0),
        .tx_configuration_vector(80'b0)
   );
endmodule
