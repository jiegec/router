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
    
    logic rgmii_tx_clk; // 125MHz
    logic rgmii_tx_clk_90deg; // 125MHz, 90 deg shift
    
    clk_wiz_0 mmcm_inst(
        .clk_in1(clk),
        .clk_out1(rgmii_tx_clk),
        .clk_out2(rgmii_tx_clk_90deg),
        .reset(~reset_n_in),
        .locked(reset_n)
    );

    assign led = reset_n;
    
    logic rx_data_en;
    logic [`BYTE_WIDTH-1:0] rx_data_out;
    logic rx_len_en;
    logic [`LENGTH_WIDTH-1:0] rx_len_out;
    logic rx_len_dv;
    logic rx_avail;

    logic tx_data_en;
    logic [`BYTE_WIDTH-1:0] tx_data_in;
    logic tx_len_en;
    logic [`LENGTH_WIDTH-1:0] tx_len_in;
    logic tx_avail;

    logic [`LENGTH_WIDTH-1:0] rx_length = 0;
    logic [`LENGTH_WIDTH-1:0] tx_length = 0;

    assign rx_len_en = rx_avail && tx_avail && rx_length == 0 && tx_length == 0 && tx_data_en == 0 && tx_len_en == 0 && rx_len_dv == 0;

    always @ (posedge clk) begin
        if (reset == 1) begin
            rx_data_en <= 0;
            rx_length <= 0;
            tx_data_en <= 0;
            tx_len_en <= 0;
        end else begin
            rx_len_dv <= rx_len_en;
            if (rx_length == 0 && rx_len_out != 0 && rx_len_dv == 1) begin
                rx_length <= rx_len_out + 2;
                tx_length <= 0;
                tx_data_in <= rx_data_out;
            end else if (rx_length > 1) begin
                tx_length <= tx_length + 1;
                rx_length <= rx_length - 1;
                tx_data_in <= rx_data_out;
            end else if (rx_length == 1) begin
                tx_len_in <= tx_length - 1;
                tx_len_en <= 1;
                rx_length <= 0;
                tx_data_in <= rx_data_out;
            end else if (rx_length == 0 && tx_length != 0) begin
                tx_len_en <= 0;
                tx_len_in <= 0;
                tx_length <= 0;
                tx_data_in <= rx_data_out;
            end
            rx_data_en <= rx_length > 2;
            tx_data_en <= tx_length > 1 && rx_length > 0;
        end
    end


    rgmii_interface rgmii_interface_inst(
        .clk(clk),
        .clk_125m(rgmii_tx_clk),
        .clk_125m_90deg(rgmii_tx_clk_90deg),
        .reset(reset),
        
        .rx_data_en(rx_data_en),
        .rx_data_out(rx_data_out),
        .rx_len_en(rx_len_en),
        .rx_len_out(rx_len_out),
        .rx_avail(rx_avail),

        .tx_data_en(tx_data_en),
        .tx_data_in(tx_data_in),
        .tx_len_en(tx_len_en),
        .tx_len_in(tx_len_in),
        .tx_avail(tx_avail),

        .rgmii_rd(rgmii1_rd),
        .rgmii_rx_ctl(rgmii1_rx_ctl),
        .rgmii_rxc(rgmii1_rxc),
        .rgmii_td(rgmii1_td),
        .rgmii_tx_ctl(rgmii1_tx_ctl),
        .rgmii_txc(rgmii1_txc)
    );
    
endmodule
