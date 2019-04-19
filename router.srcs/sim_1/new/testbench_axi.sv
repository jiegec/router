`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 09:20:05 PM
// Design Name: 
// Module Name: testbench_axi
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


module testbench_axi(

    );
    logic clk;
    logic rx_clk;
    logic rx_clk_90deg;
    logic packet_clk;
    logic trans;
    logic [7:0] count = 0;
    logic [3:0] data1;
    logic [3:0] data2;
    logic [3:0] rd;
    logic rx_ctl;
    logic rx_ctl_oddr;
    logic [7:0] example [71:0];
    
    initial begin
        clk = 0;
        rx_clk = 0;
        packet_clk = 0;
        rx_clk_90deg = 0;
        $readmemh("example_frame.mem", example);
        #2;
        forever rx_clk_90deg = #4 ~rx_clk; // 125MHz, 90 deg shift
    end
    
    always clk = #10 ~clk; // 50MHz
    always rx_clk = #4 ~rx_clk; // 125MHz
    always packet_clk = #1000 ~packet_clk; // 500KHz
    
    
    always_ff @ (posedge rx_clk) begin
        if (packet_clk) begin
            count <= count + 1;
        end else begin
            count <= 0;
        end
        trans <= packet_clk && count <= 8'd71;
        rx_ctl <= trans;
        data1 <= packet_clk ? example[count][3:0] : 4'b0000;
        data2 <= packet_clk ? example[count][7:4] : 4'b0000;
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
            .R(1'b0)
        );
    end
    
    ODDR #(
        .DDR_CLK_EDGE("SAME_EDGE")
    ) oddr_inst_ctl (
        .D1(trans),
        .D2(trans),
        .C(rx_clk),
        .CE(1'b1),
        .Q(rx_ctl_oddr),
        .R(1'b0)
    );

    top_axi top_axi (
        .clk(clk),
        .reset_n_in(1'b1),
        .rgmii1_rd(rd),
        .rgmii1_rx_ctl(rx_ctl_oddr),
        .rgmii1_rxc(rx_clk_90deg)
    );
endmodule
