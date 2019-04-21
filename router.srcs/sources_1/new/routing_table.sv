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
    input reset,

    input [`IPV4_WIDTH-1:0] lookup_dest_ip,
    output [`IPV4_WIDTH-1:0] lookup_via_ip,
    input lookup_valid,
    output lookup_ready

    );

    // A array table with BUCKET_INDEX_WIDTH buckets
    // Each item consists of (DST_IP,PREFIX_LEN,VIA_IP) tuple.
    // Represents DST_IP/PREFIX_LEN via VIA_IP
    logic data [`IPV4_WIDTH+`PREFIX_WIDTH+`IPV4_WIDTH-1:0][`BUCKET_INDEX_WIDTH-1:0];
endmodule
