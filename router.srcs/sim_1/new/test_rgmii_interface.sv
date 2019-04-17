`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:02:31 PM
// Design Name: 
// Module Name: test_rgmii_interface
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

`include "constants.vh"


module test_rgmii_interface(

    );

    logic clk;
    logic clk_data;
    logic rx_clk;
    logic rx_clk_90deg;
    logic packet_clk;
    logic rx_dv;
    logic [3:0] count = 0;
    logic [3:0] data1;
    logic [3:0] data2;
    logic [3:0] rd;
    logic rx_ctl_oddr;
    logic reset;
    
    initial begin
        clk = 0;
        rx_clk = 0;
        packet_clk = 0;
        rx_clk_90deg = 0;
        clk_data = 0;

        reset = 1;
        #200;
        reset = 0;
    end
    initial begin
        #2;
        forever rx_clk_90deg = #4 ~rx_clk; // 125MHz, 90 deg shift
    end
    
    always clk = #10 ~clk; // 50MHz
    always rx_clk = #4 ~rx_clk; // 125MHz
    always packet_clk = #100 ~packet_clk; // 5MHz
    always clk_data = #2.5 ~clk_data; // 20MHz
    
    
    always_ff @ (posedge rx_clk) begin
        if (reset == 1) begin
            count <= 0;
            rx_dv <= 0;
            data1 <= 0;
            data2 <= 0;
        end else begin
            count <= count + 1;
            rx_dv <= packet_clk;
            data1 <= packet_clk ? count : 4'b0000;
            data2 <= packet_clk ? ~count : 4'b0000;
        end
    end
    
    genvar i;
    for (i = 0;i < 4;i++) begin
        ODDR #(
            .DDR_CLK_EDGE("SAME_EDGE")
        ) oddr_inst (
            .D1(data1[i]),
            .D2(data2[i]),
            .C(rx_clk),
            .CE(1'b1),
            .Q(rd[i]),
            .R(reset)
        );
    end
    
    ODDR #(
        .DDR_CLK_EDGE("SAME_EDGE")
    ) oddr_inst_ctl (
        .D1(rx_dv),
        .D2(1'b0),
        .C(rx_clk),
        .CE(1'b1),
        .Q(rx_ctl_oddr),
        .R(reset)
    );

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

    always @ (posedge clk_data) begin
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
        .clk(clk_data),
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

        .rgmii_rd(rd),
        .rgmii_rx_ctl(rx_ctl_oddr),
        .rgmii_rxc(rx_clk_90deg)
    );

endmodule
