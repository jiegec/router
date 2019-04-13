`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2019 01:09:13 AM
// Design Name: 
// Module Name: testbench
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


module testbench(

    );
    
    logic clk;
    logic count = 0;
    logic [3:0] data1;
    logic [3:0] data2;
    logic [3:0] rd;
    
    initial begin
        clk = 0;
    end
    
    always clk = #2 ~clk; // 50MHz
    
    always_ff @ (posedge clk) begin
        count <= ~count;
    end
    
    always_ff @ (posedge clk) begin
        data1 <= count ? 4'b0001 : 4'b0000;
    end
    
    always_ff @ (negedge clk) begin
        data2 <= count ? 4'b0101 : 4'b0100;
    end
    
    genvar i;
    for (i = 0;i < 4;i++) begin
	ODDR #(
	    .DDR_CLK_EDGE("OPPOSITE_EDGE")
	) oddr_inst (
	    .D1(data1[i]),
	    .D2(data2[i]),
	    .C(clk),
	    .CE(1'b1),
	    .Q(rd[i]),
	    .R(1'b0)
	);
    end
    

    top top(
        .clk(clk),
        .rgmii1_rd(rd),
        .rgmii1_rx_ctl(1'b1),
        .rgmii1_rxc(clk)
    );
    
endmodule
