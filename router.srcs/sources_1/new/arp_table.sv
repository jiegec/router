`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2019 09:25:43 PM
// Design Name: 
// Module Name: arp_table
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

module arp_table(
    input clk,
    input rst,

    input [`IPV4_WIDTH-1:0] lookup_ip,
    output logic [`MAC_WIDTH-1:0] lookup_mac,
    output logic [`PORT_WIDTH-1:0] lookup_port,
    input lookup_ip_valid,
    output logic lookup_mac_valid,
    output logic lookup_mac_not_found,

    input [`IPV4_WIDTH-1:0] insert_ip,
    input [`MAC_WIDTH-1:0] insert_mac,
    input [`PORT_WIDTH-1:0] insert_port,
    input insert_valid,
    output logic insert_ready
    );

    logic [`BUCKET_INDEX_WIDTH-1:0] lookup_bucket_index;
    assign lookup_bucket_index = {lookup_ip[31], lookup_ip[30], lookup_ip[29]};

    logic [`BUCKET_DEPTH_WIDTH-1:0] lookup_current_bucket_depth;

    // A hash table with BUCKET_INDEX_WIDTH buckets, each bucket can have at most BUCKET_DEPTH_WIDTH items
    // Each item consists of (IP, MAC, PORT) tuple.
    logic [`BUCKET_INDEX_COUNT-1:0][`BUCKET_DEPTH_COUNT-1:0][`IPV4_WIDTH+`MAC_WIDTH+`PORT_WIDTH-1:0] data;

    logic searching = 0;

    always_ff @ (posedge clk) begin
        if (rst) begin
            searching <= 0;
            lookup_mac_valid <= 0;
            lookup_mac <= 0;
            lookup_port <= 0;
            lookup_current_bucket_depth <= 0;
            lookup_mac_not_found <= 0;
        end else begin
            if (!searching && lookup_ip_valid) begin
                searching <= 1;
                lookup_mac <= 0;
                lookup_current_bucket_depth <= 0;
                lookup_mac_not_found <= 0;
            end else if (searching && !lookup_ip_valid) begin
                searching <= 0;
                lookup_mac_valid <= 0;
                lookup_mac_not_found <= 0;
                lookup_mac <= 0;
                lookup_port <= 0;
            end

            if (searching && !lookup_mac_valid && !lookup_mac_not_found) begin
                if (data[lookup_bucket_index][lookup_current_bucket_depth][`IPV4_WIDTH+`MAC_WIDTH+`PORT_WIDTH-1:`MAC_WIDTH+`PORT_WIDTH] == lookup_ip) begin
                    lookup_mac_valid <= 1;
                    lookup_mac <= data[lookup_bucket_index][lookup_current_bucket_depth][`MAC_WIDTH+`PORT_WIDTH-1:`PORT_WIDTH];
                    lookup_port <= data[lookup_bucket_index][lookup_current_bucket_depth][`PORT_WIDTH-1:0];
                end else if (lookup_current_bucket_depth < `BUCKET_DEPTH_COUNT - 1) begin
                    lookup_current_bucket_depth <= lookup_current_bucket_depth + 1;
                end else begin
                    lookup_mac_not_found <= 1;
                end
            end
        end
    end

    logic [`BUCKET_INDEX_WIDTH-1:0] insert_bucket_index;
    assign insert_bucket_index = {insert_ip[31], insert_ip[30], insert_ip[29], insert_ip[28]};

    logic [`IPV4_WIDTH-1:0] saved_insert_ip;
    logic [`MAC_WIDTH-1:0] saved_insert_mac;
    logic [`PORT_WIDTH-1:0] saved_insert_port;
    logic [`BUCKET_DEPTH_WIDTH-1:0] insert_current_bucket_depth;
    logic first_pass;
    logic second_pass;
    logic [`IPV4_WIDTH+`MAC_WIDTH+`PORT_WIDTH-1:0] temp_data;

    integer i, j;
    always_ff @ (posedge clk) begin
        if (rst) begin
            saved_insert_ip <= 0;
            saved_insert_mac <= 0;
            insert_ready <= 1;
            saved_insert_ip <= 0;
            saved_insert_mac <= 0;
            saved_insert_port <= 0;
            insert_current_bucket_depth <= 0;
            first_pass <= 0;
            second_pass <= 0;
            for (i = 0;i < `BUCKET_INDEX_COUNT;i++) begin
                for (j = 0;j < `BUCKET_DEPTH_COUNT;j++) begin
                    data[i][j] <= `IPV4_WIDTH+`MAC_WIDTH+`PORT_WIDTH'b0;
                end
            end
        end else if (insert_valid && insert_ready) begin
            insert_ready <= 0;
            saved_insert_ip <= insert_ip;
            saved_insert_mac <= insert_mac;
            saved_insert_port <= insert_port;
            insert_current_bucket_depth <= 0;
            first_pass <= 1;
            second_pass <= 0;
        end else if (!insert_ready) begin
            if (first_pass) begin
                if (data[insert_bucket_index][insert_current_bucket_depth][`IPV4_WIDTH+`MAC_WIDTH+`PORT_WIDTH-1:`MAC_WIDTH+`PORT_WIDTH] == saved_insert_ip) begin
                    first_pass <= 0;
                    second_pass <= 0;
                    data[insert_bucket_index][insert_current_bucket_depth] = {saved_insert_ip, saved_insert_mac, saved_insert_port};
                    insert_ready <= 1;
                end else if (insert_current_bucket_depth < `BUCKET_DEPTH_COUNT - 1) begin
                    insert_current_bucket_depth <= insert_current_bucket_depth + 1;
                end else begin
                    first_pass <= 0;
                    second_pass <= 1;
                    insert_current_bucket_depth <= 0;
                    temp_data <= {saved_insert_ip, saved_insert_mac, saved_insert_port};
                end
            end else if (second_pass) begin
                if (insert_current_bucket_depth < `BUCKET_DEPTH_COUNT - 1) begin
                    temp_data <= data[insert_bucket_index][insert_current_bucket_depth];
                    data[insert_bucket_index][insert_current_bucket_depth] <= temp_data;
                    insert_current_bucket_depth <= insert_current_bucket_depth + 1;
                end else begin
                    data[insert_bucket_index][insert_current_bucket_depth] <= temp_data;
                    second_pass <= 0;
                    insert_ready <= 1;
                end
            end
        end
    end
endmodule
