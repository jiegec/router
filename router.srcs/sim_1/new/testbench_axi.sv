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
    logic [7:0] count = 0;
    logic trans_1;
    logic [3:0] data1_1;
    logic [3:0] data2_1;
    logic [3:0] rd_1;
    logic rx_ctl_oddr_1;
    logic trans_2;
    logic [3:0] data1_2;
    logic [3:0] data2_2;
    logic [3:0] rd_2;
    logic rx_ctl_oddr_2;
    logic [7:0] example1 [71:0];
    logic [7:0] example2 [71:0];
    logic [7:0] example3 [109:0];
    logic selector = 0;
    
    initial begin
        clk = 0;
        rx_clk = 0;
        packet_clk = 0;
        rx_clk_90deg = 0;
        $readmemh("example_frame.mem", example1);
        $readmemh("example_frame2.mem", example2);
        $readmemh("example_frame3.mem", example3);
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
        if (count == 16'h70) begin
            selector <= ~selector;
        end
        if (selector) begin
            trans_1 <= packet_clk && count < 8'd72;
            data1_1 <= packet_clk ? example1[count][3:0] : 4'b0000;
            data2_1 <= packet_clk ? example1[count][7:4] : 4'b0000;
        end else begin
            trans_1 <= packet_clk && count < 8'd110;
            data1_1 <= packet_clk ? example3[count][3:0] : 4'b0000;
            data2_1 <= packet_clk ? example3[count][7:4] : 4'b0000;
        end

        trans_2 <= packet_clk && count < 8'd72;
        data1_2 <= packet_clk ? example2[count][3:0] : 4'b0000;
        data2_2 <= packet_clk ? example2[count][7:4] : 4'b0000;
    end
    
    genvar i;
    for (i = 0;i < 4;i++) begin
        ODDR #(
            .DDR_CLK_EDGE("SAME_EDGE")
        ) oddr_inst (
            .D1(data1_1[i]),
            .D2(data2_1[i]),
            .C(rx_clk),
            .CE(1'b1),
            .Q(rd_1[i]),
            .R(1'b0)
        );
    end

    ODDR #(
        .DDR_CLK_EDGE("SAME_EDGE")
    ) oddr_inst_ctl_1 (
        .D1(trans_1),
        .D2(trans_1),
        .C(rx_clk),
        .CE(1'b1),
        .Q(rx_ctl_oddr_1),
        .R(1'b0)
    );

    for (i = 0;i < 4;i++) begin
        ODDR #(
            .DDR_CLK_EDGE("SAME_EDGE")
        ) oddr_inst (
            .D1(data1_2[i]),
            .D2(data2_2[i]),
            .C(rx_clk),
            .CE(1'b1),
            .Q(rd_2[i]),
            .R(1'b0)
        );
    end

    ODDR #(
        .DDR_CLK_EDGE("SAME_EDGE")
    ) oddr_inst_ctl_2 (
        .D1(trans_2),
        .D2(trans_2),
        .C(rx_clk),
        .CE(1'b1),
        .Q(rx_ctl_oddr_2),
        .R(1'b0)
    );

`ifndef HARDWARE_CONTROL_PLANE
    logic axi_clk = 0; // 25MHz
    always axi_clk = #20 ~axi_clk;

    logic s_axis_tvalid;
    logic s_axis_tready;
    logic [7:0]s_axis_tdata;
    logic s_axis_tlast;
    logic m_axis_aclk;
    logic m_axis_tvalid;
    logic m_axis_tready;
    logic [7:0]m_axis_tdata;
    logic m_axis_tlast;

    // loopback
    axis_data_fifo_0 axis_data_fifo_0_inst (
        .s_axis_aresetn(1'b1),
        .m_axis_aresetn(1'b1),
        .s_axis_aclk(axi_clk),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tlast(s_axis_tlast),
        .m_axis_aclk(axi_clk),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tlast(m_axis_tlast)
    );
`endif
    

    top_axi top_axi (
        .clk(clk),
        .reset_n_in(1'b1),

`ifndef HARDWARE_CONTROL_PLANE
        .axis_clk(axi_clk),
        .axis_rxd_tdata(s_axis_tdata),
        .axis_rxd_tlast(s_axis_tlast),
        .axis_rxd_tready(s_axis_tready),
        .axis_rxd_tvalid(s_axis_tvalid),

        .axis_txd_tdata(m_axis_tdata),
        .axis_txd_tlast(m_axis_tlast),
        .axis_txd_tready(m_axis_tready),
        .axis_txd_tvalid(m_axis_tvalid),
`endif

        .rgmii1_rd(rd_1),
        .rgmii1_rx_ctl(rx_ctl_oddr_1),
        .rgmii1_rxc(rx_clk_90deg),

        .rgmii2_rd(rd_2),
        .rgmii2_rx_ctl(rx_ctl_oddr_2),
        .rgmii2_rxc(rx_clk_90deg)
    );
endmodule
