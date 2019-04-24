`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 12:20:21 PM
// Design Name: 
// Module Name: arp_table_bus
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


module arp_table_bus(
    input clk,
    input reset,
    input [`PORT_COUNT-1:0] arp_arbiter_req,
    output logic [`PORT_COUNT-1:0] arp_arbiter_grant,

    input [`PORT_COUNT-1:0][`IPV4_WIDTH-1:0] port_arp_insert_ip,
    input [`PORT_COUNT-1:0][`MAC_WIDTH-1:0] port_arp_insert_mac,
    input [`PORT_COUNT-1:0][`PORT_WIDTH-1:0] port_arp_insert_port,
    input [`PORT_COUNT-1:0] port_arp_insert_valid,
    output logic [`PORT_COUNT-1:0] port_arp_insert_ready
    );

    logic [`IPV4_WIDTH-1:0] arp_lookup_ip;
    logic [`MAC_WIDTH-1:0] arp_lookup_mac;
    logic [1:0] arp_lookup_port;
    logic arp_lookup_ip_valid;
    logic arp_lookup_mac_valid;
    logic arp_lookup_mac_not_found;

    (*mark_debug = "true"*) logic [`IPV4_WIDTH-1:0] arp_insert_ip;
    (*mark_debug = "true"*) logic [`MAC_WIDTH-1:0] arp_insert_mac;
    (*mark_debug = "true"*) logic [`PORT_WIDTH-1:0] arp_insert_port;
    (*mark_debug = "true"*) logic arp_insert_valid;
    (*mark_debug = "true"*) logic arp_insert_ready;


    arp_table arp_table_inst(
        .clk(clk),
        .rst(reset),

        .lookup_ip(arp_lookup_ip),
        .lookup_mac(arp_lookup_mac),
        .lookup_port(arp_lookup_port),
        .lookup_ip_valid(arp_lookup_ip_valid),
        .lookup_mac_valid(arp_lookup_mac_valid),
        .lookup_mac_not_found(arp_lookup_mac_not_found),

        .insert_ip(arp_insert_ip),
        .insert_mac(arp_insert_mac),
        .insert_port(arp_insert_port),
        .insert_valid(arp_insert_valid),
        .insert_ready(arp_insert_ready)
    );


    always_comb begin
        unique casez (arp_arbiter_grant)
            4'b???1: begin
                port_arp_insert_ready[0] = arp_insert_ready;
                port_arp_insert_ready[1] = 0;
                port_arp_insert_ready[2] = 0;
                port_arp_insert_ready[3] = 0;
                arp_insert_valid = port_arp_insert_valid[0];
                arp_insert_ip = port_arp_insert_ip[0];
                arp_insert_mac = port_arp_insert_mac[0];
                arp_insert_port = port_arp_insert_port[0];
            end
            4'b??1?: begin
                port_arp_insert_ready[0] = 0;
                port_arp_insert_ready[1] = arp_insert_ready;
                port_arp_insert_ready[2] = 0;
                port_arp_insert_ready[3] = 0;
                arp_insert_valid = port_arp_insert_valid[1];
                arp_insert_ip = port_arp_insert_ip[1];
                arp_insert_mac = port_arp_insert_mac[1];
                arp_insert_port = port_arp_insert_port[1];
            end
            4'b?1??: begin
                port_arp_insert_ready[0] = 0;
                port_arp_insert_ready[1] = 0;
                port_arp_insert_ready[2] = arp_insert_ready;
                port_arp_insert_ready[3] = 0;
                arp_insert_valid = port_arp_insert_valid[2];
                arp_insert_ip = port_arp_insert_ip[2];
                arp_insert_mac = port_arp_insert_mac[2];
                arp_insert_port = port_arp_insert_port[2];
            end
            4'b1???: begin
                port_arp_insert_ready[0] = 0;
                port_arp_insert_ready[1] = 0;
                port_arp_insert_ready[2] = 0;
                port_arp_insert_ready[3] = arp_insert_ready;
                arp_insert_valid = port_arp_insert_valid[3];
                arp_insert_ip = port_arp_insert_ip[3];
                arp_insert_mac = port_arp_insert_mac[3];
                arp_insert_port = port_arp_insert_port[3];
            end
            4'b0000: begin
                port_arp_insert_ready[0] = 0;
                port_arp_insert_ready[1] = 0;
                port_arp_insert_ready[2] = 0;
                port_arp_insert_ready[3] = 0;
                arp_insert_valid = 0;
                arp_insert_ip = 0;
                arp_insert_mac = 0;
                arp_insert_port = 0;
            end
        endcase
    end

    arbiter arbiter_inst_arp(
        .clk(clk),
        .rst(reset),

        .req(arp_arbiter_req),
        .grant(arp_arbiter_grant)
    );

endmodule
