`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 09:31:17 PM
// Design Name: 
// Module Name: rgmii_interface
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

// write to fifo: data first, then len
// read from fifo: len frist, then data

module rgmii_interface(
    input logic clk,
    input logic reset,
    
    // rx fifos
    input logic rx_data_en,
    output logic rx_data_dv,
    output logic [7:0] rx_data_out,
    input logic rx_len_en,
    output logic rx_len_dv,
    output logic [`LENGTH_WIDTH-1:0] rx_len_out,
    output logic rx_avail,
    
    // rgmii pins
    input logic [3:0] rgmii_rd,
    input logic rgmii_rx_ctl,
    input logic rgmii_rxc,
    output logic [3:0] rgmii_td,
    output logic rgmii_tx_ctl,
    output logic rgmii_txc
    );

    assign rgmii_txc = rgmii_rxc;

    logic [7:0] rx_data_in;
    logic rx_data_full;
    logic rx_data_wen;

    logic [7:0] rx_len_in;
    logic rx_len_full;
    logic rx_len_wen;
    logic rx_len_empty;

    assign rx_avail = ~rx_len_empty;

    // stores ethernet frame data
    xpm_fifo_async #(
        .READ_DATA_WIDTH(8),
        .WRITE_DATA_WIDTH(8),
        .FIFO_WRITE_DEPTH(`MAX_FIFO_SIZE),
        .PROG_FULL_THRESH(`MAX_FIFO_SIZE - `MAX_ETHERNET_FRAME_BYTES)
    ) xpm_fifo_zsync_inst_rx_data (
        .data_valid(rx_data_dv),
        .dout(rx_data_out),
        .rd_en(rx_data_en),

        .prog_full(rx_data_full),
        .din(rx_data_in),
        .rd_clk(rgmii_rxc),
        .rst(reset),
        .wr_clk(clk),
        .wr_en(rx_data_wen)
    );

    // stores ethernet frame length
    xpm_fifo_async #(
        .READ_DATA_WIDTH(`LENGTH_WIDTH),
        .WRITE_DATA_WIDTH(`LENGTH_WIDTH),
        .FIFO_WRITE_DEPTH(`MAX_FIFO_SIZE),
        .RD_DATA_COUNT_WIDTH(16),
        .WR_DATA_COUNT_WIDTH(16),
        .PROG_FULL_THRESH(`MAX_FIFO_SIZE - 1)
    ) xpm_fifo_zsync_inst_rx_len (
        .data_valid(rx_len_dv),
        .dout(rx_len_out),
        .rd_en(rx_len_en),

        .empty(rx_len_empty),
        .prog_full(rx_len_full),
        .din(rx_len_in),
        .rd_clk(rgmii_rxc),
        .rst(reset),
        .wr_clk(clk),
        .wr_en(rx_len_wen)
    );

    reg [7:0] rgmii_rx_data;
    reg rgmii_rx_dv;
    reg rgmii_rx_err;
    reg trans;
    reg [`LENGTH_WIDTH-1:0] length;

    IDDR #(
        .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
    ) iddr_inst_rx (
        .Q1(rgmii_rx_dv),
        .Q2(rgmii_rx_err),
        .C(rgmii_rxc),
        .CE(1'b1),
        .D(rgmii_rx_ctl),
        .R(reset)
    );
    
    genvar i;
    for (i = 0;i < 4;i++) begin
        IDDR #(
            .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
        ) iddr_inst (
            .Q1(rgmii_rx_data[i]),
            .Q2(rgmii_rx_data[i+4]),
            .C(rgmii_rxc),
            .CE(1'b1),
            .D(rgmii_rd[i]),
            .R(reset)
        );
    end


    always_ff @ (posedge rgmii_rxc) begin
        if (reset == 1'b1) begin
            trans <= 0;
            rgmii_rx_data <= 8'b0;
            rx_data_wen <= 0;
            rx_data_in <= 8'b0;
            length <= 0;
            rx_len_wen <= 1;
            rx_len_in <= `LENGTH_WIDTH'b0;
        end else begin
            // new data in, and both fifos have enough space
            if (rgmii_rx_ctl == 1'b1 && rx_data_full == 1'b0 && rx_len_full == 1'b0) begin
                trans <= 1;
            end else begin
                trans <= 0;
            end
            if (trans == 1'b0 && rgmii_rx_ctl == 1'b1) begin
                length <= 0;
            end else if (trans == 1'b1) begin
                length <= length + 1;
            end else if (trans == 1'b0 && rgmii_rx_ctl == 1'b0) begin
                length <= 0;
                // write length
                if (length != 0) begin
                    rx_len_wen <= 1;
                    rx_len_in <= length;
                end else begin
                    rx_len_wen <= 0;
                    rx_len_in <= `LENGTH_WIDTH'b0;
                end
            end 

            // write data
            if (length >= 1) begin
                rx_data_in <= rgmii_rx_data;
                rx_data_wen <= 1;
            end else begin
                rx_data_in <= 8'b0;
                rx_data_wen <= 0;
            end
        end
    end
endmodule
