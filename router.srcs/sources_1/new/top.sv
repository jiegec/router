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
    
    (*mark_debug = "true"*) reg [3:0]rx_data1;
    (*mark_debug = "true"*) reg [3:0]rx_data2;
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
        IDDR2 #(
            .DDR_ALIGNMENT("C0")
        )iddr_inst (
            .Q0(rx_data1[i]),
            .Q1(rx_data2[i]),
            .C0(rgmii1_rxc),
            .C1(~rgmii1_rxc),
            .CE(1'b1),
            .D(rgmii1_rd[i]),
            .R(1'b0),
            .S(1'b0)
        );
    end
    
endmodule
