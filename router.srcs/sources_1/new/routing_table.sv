`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2019 12:24:31 AM
// Design Name: 
// Module Name: routing_table
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

module routing_table(
    input clk,
    input rst,

    input [`IPV4_WIDTH-1:0] lookup_dest_ip,
    output logic [`IPV4_WIDTH-1:0] lookup_via_ip,
    output logic [`PORT_WIDTH-1:0] lookup_via_port,
    input lookup_valid,
    output logic lookup_ready,
    output logic lookup_output_valid,
    output logic lookup_not_found

    );

    // Each item consists of (PORT,DST_IP,PREFIX_MASK,VIA_IP) tuple.
    // Represents DST_IP/PREFIX_LEN via VIA_IP if PORT
    // a for write, b for read
    logic [`PORT_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH-1:0] data_dina;
    logic [`PORT_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH-1:0] data_doutb;
    logic [`BUCKET_INDEX_WIDTH-1:0] data_addra;
    logic data_wea = 0;

    logic [`BUCKET_INDEX_WIDTH-1:0] lookup_index;
    logic [`IPV4_WIDTH-1:0] saved_dest_ip;

    xpm_memory_sdpram #(
        .ADDR_WIDTH_A(`BUCKET_INDEX_WIDTH),
        .ADDR_WIDTH_B(`BUCKET_INDEX_WIDTH),
        .BYTE_WRITE_WIDTH_A(`PORT_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH),
        .MEMORY_SIZE(`BUCKET_INDEX_COUNT * (`PORT_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH)),
        .READ_DATA_WIDTH_B(`PORT_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH),
        .READ_LATENCY_B(0),
        .WRITE_DATA_WIDTH_A(`PORT_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH),
        // 10.0.0.0/24 via 10.0.0.2 port 0
        // 10.0.1.0/24 via 10.0.1.2 port 1
        .MEMORY_INIT_PARAM("00a000000ffffff000a000002, 10a000100ffffff000a000102, 0000000000000000000000000")
    ) xpm_memory_sdpram_data (
        .dina(data_dina),
        .addra(data_addra),
        .addrb(lookup_index),
        .doutb(data_doutb),
        .clka(clk),
        .clkb(clk),
        .rstb(rst),
        .ena(1'b1),
        .enb(1'b1),
        .wea(data_wea)
    );

    always_ff @ (posedge clk) begin
        if (rst) begin
            lookup_via_ip <= 0;
            lookup_via_port <= 0;
            lookup_ready <= 1;
            lookup_output_valid <= 0;
            lookup_not_found <= 0;
            lookup_index <= 0;
            saved_dest_ip <= 0;
        end else begin
            if (lookup_ready) begin
                if (lookup_valid) begin
                    lookup_ready <= 0;
                    saved_dest_ip <= lookup_dest_ip;
                end
                lookup_index <= 0;
                lookup_via_ip <= 0;
                lookup_via_port <= 0;
                lookup_not_found <= 0;
                lookup_output_valid <= 0;
            end else if (!lookup_ready) begin
                if (lookup_output_valid) begin
                    lookup_ready <= 1;
                    lookup_output_valid <= 0;
                    lookup_index <= 0;
                end else if (data_doutb == 0) begin
                    lookup_ready <= 1;
                    lookup_not_found <= 1;
                end else if (data_doutb[`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH-1:`IPV4_WIDTH+`IPV4_WIDTH] == (saved_dest_ip & data_doutb[`IPV4_WIDTH+`IPV4_WIDTH-1:`IPV4_WIDTH])) begin
                    lookup_output_valid <= 1;
                    lookup_not_found <= 0;
                    lookup_via_ip <= data_doutb[`IPV4_WIDTH-1:0];
                    lookup_via_port <= data_doutb[`PORT_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH-1:`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH];
                end else begin
                    lookup_index <= lookup_index + 1;
                end
            end
        end
    end
endmodule
