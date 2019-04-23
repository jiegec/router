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
    input lookup_valid,
    output logic lookup_ready,
    output logic lookup_output_valid,
    output logic lookup_not_found

    );

    // A array table with BUCKET_INDEX_WIDTH buckets
    // Each item consists of (DST_IP,PREFIX_MASK,VIA_IP) tuple.
    // Represents DST_IP/PREFIX_LEN via VIA_IP
    logic [`BUCKET_INDEX_COUNT-1:0][`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH-1:0] data = 0;

    initial begin
        // 10.0.0.0/24 via 10.0.0.2
        data[0] = 96'h0a000000ffffff000a000002;
        // 10.0.1.0/24 via 10.0.1.2
        data[1] = 96'h0a000100ffffff000a000002;
    end

    logic [`BUCKET_INDEX_WIDTH-1:0] lookup_index;
    logic [`IPV4_WIDTH-1:0] saved_dest_ip;

    always_ff @ (posedge clk) begin
        if (rst) begin
            lookup_via_ip <= 0;
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
                lookup_not_found <= 0;
                lookup_output_valid <= 0;
            end else if (!lookup_ready) begin
                if (data[lookup_index] == 0) begin
                    lookup_ready <= 1;
                    lookup_not_found <= 1;
                end else if (data[lookup_index][`IPV4_WIDTH+`IPV4_WIDTH+`IPV4_WIDTH-1:`IPV4_WIDTH+`IPV4_WIDTH] == (saved_dest_ip & data[lookup_index][`IPV4_WIDTH+`IPV4_WIDTH-1:`IPV4_WIDTH])) begin
                    lookup_ready <= 1;
                    lookup_output_valid <= 1;
                    lookup_not_found <= 0;
                    lookup_via_ip <= data[lookup_index][`IPV4_WIDTH-1:0];
                end else begin
                    lookup_index <= lookup_index + 1;
                end
            end
        end
    end
endmodule
