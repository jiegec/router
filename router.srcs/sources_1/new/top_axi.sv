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

    port #(
        .shared(0)
    ) port_inst_1 (
        .clk(clk),
        .gtx_clk(gtx_clk_in),
        .gtx_clk_out(gtx_clk),
        .gtx_clk90_out(gtx_clk90),
        .refclk(refclk),
        .reset_n(reset_n),
        .rgmii_td(rgmii1_td),
        .rgmii_tx_ctl(rgmii1_tx_ctl),
        .rgmii_txc(rgmii1_txc),
        .rgmii_rd(rgmii1_rd),
        .rgmii_rx_ctl(rgmii1_rx_ctl),
        .rgmii_rxc(rgmii1_rxc)
    );

    port #(
        .shared(1)
    ) port_inst_2 (
        .clk(clk),
        .gtx_clk(gtx_clk),
        .gtx_clk90(gtx_clk90),
        .reset_n(reset_n),
        .rgmii_td(rgmii2_td),
        .rgmii_tx_ctl(rgmii2_tx_ctl),
        .rgmii_txc(rgmii2_txc),
        .rgmii_rd(rgmii2_rd),
        .rgmii_rx_ctl(rgmii2_rx_ctl),
        .rgmii_rxc(rgmii2_rxc)
    );

endmodule
