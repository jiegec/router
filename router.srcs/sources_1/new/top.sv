`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2019 12:57:52 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
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


module top(
    input logic clk,
    input logic reset,
    
    input logic [3:0] rgmii1_rd,
    input logic rgmii1_rx_ctl,
    input logic rgmii1_rxc,
    output logic [3:0] rgmii1_td,
    output logic rgmii1_tx_ctl,
    output logic rgmii1_txc
    );
    
    logic reset_n;
    assign reset_n = ~reset;
    
    logic rgmii_tx_clk; // 125MHz
    
    clk_wiz_0 mmcm_inst(
        .clk_in1(clk),
        .clk_out1(rgmii_tx_clk),
        .reset(reset)
    );
    
    assign rgmii1_txc = rgmii_tx_clk;
    
    (*mark_debug = "true"*) reg [7:0]rx_data;
    (*mark_debug = "true"*) reg trans;
    
    always_ff @ (posedge rgmii1_rxc) begin
        if (rgmii1_rx_ctl == 1'b1) begin
            trans <= 1;
        end else begin
            trans <= 0;
        end
    end
    
    genvar i;
    for (i = 0;i < 4;i++) begin
        IDDR #(
            .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
        ) iddr_inst (
            .Q1(rx_data[i+4]),
            .Q2(rx_data[i]),
            .C(rgmii1_rxc),
            .CE(1'b1),
            .D(rgmii1_rd[i]),
            .R(1'b0)
        );
    end
    
    assign rgmii1_td = rgmii1_rd;
    assign rgmii1_tx_ctl = rgmii1_rx_ctl;
    assign rgmii1_txc = rgmii1_rxc;
    
endmodule
