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
    input logic reset_n,
    output logic led,
    
    input logic [3:0] rgmii1_rd,
    input logic rgmii1_rx_ctl,
    input logic rgmii1_rxc,
    output logic [3:0] rgmii1_td,
    output logic rgmii1_tx_ctl,
    output logic rgmii1_txc
    );

    logic locked;
    
    logic reset;
    assign reset = ~reset_n;
    
    (*mark_debug = "true"*) logic rgmii_tx_clk; // 125MHz
    (*mark_debug = "true"*) logic rgmii_tx_clk_90deg; // 125MHz, 90 deg shift
    (*mark_debug = "true"*) logic rgmii_tx_clk_90deg_oddr; // 125MHz, 90 deg shift, oddr
    
    clk_wiz_0 mmcm_inst(
        .clk_in1(clk),
        .clk_out1(rgmii_tx_clk),
        .clk_out2(rgmii_tx_clk_90deg),
        .reset(reset),
        .locked(locked)
    );

    assign led = locked;
    
    
    (*mark_debug = "true"*) reg [7:0]rx_data;
    (*mark_debug = "true"*) reg [7:0]tx_data;
    (*mark_debug = "true"*) reg trans;
    (*mark_debug = "true"*) reg trans_1;

    
    always_ff @ (posedge rgmii1_rxc) begin
        if (rgmii1_rx_ctl == 1'b1 && locked == 1'b1) begin
            trans <= 1;
        end else begin
            trans <= 0;
        end
        trans_1 <= trans;
    end
    
    genvar i;
    for (i = 0;i < 4;i++) begin
        IDDR #(
            .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
        ) iddr_inst (
            .Q1(rx_data[i]),
            .Q2(rx_data[i+4]),
            .C(rgmii1_rxc),
            .CE(1'b1),
            .D(rgmii1_rd[i]),
            .R(1'b0)
        );
    end

    ODDR #(
        .DDR_CLK_EDGE("OPPOSITE_EDGE")
    ) oddr_inst_clk (
        .D1(1'b1),
        .D2(1'b0),
        .C(rgmii_tx_clk_90deg),
        .CE(1'b1),
        .Q(rgmii_tx_clk_90deg_oddr),
        .R(1'b0)
    );

    always_ff @ (posedge rgmii_tx_clk) begin
        if (trans_1 == 1'b1) begin
            tx_data = rx_data;
        end else begin
            tx_data = 8'h55;
        end
    end

    for (i = 0;i < 4;i++) begin
        ODDR #(
            .DDR_CLK_EDGE("OPPOSITE_EDGE")
        ) oddr_inst (
            .D1(tx_data[i]),
            .D2(tx_data[i+4]),
            .C(rgmii_tx_clk),
            .CE(1'b1),
            .Q(rgmii1_td[i]),
            .R(1'b0)
        );
    end
    
    assign rgmii1_tx_ctl = trans_1;
    assign rgmii1_txc = rgmii_tx_clk_90deg_oddr;
    
endmodule
