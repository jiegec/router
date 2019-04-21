// 7 preamble + 1 sfd + 12 mac + 2 ethertype + 1500 payload + 4 fcs
`define MAX_ETHERNET_FRAME_BYTES 1526

`define MAX_FIFO_SIZE 32768

`define BYTE_WIDTH 8
`define LENGTH_WIDTH 16

`define BUCKET_INDEX_WIDTH 6
`define BUCKET_DEPTH_WIDTH 4
`define MAX_BUCKET_DEPTH 2'b11

`define IPV4_WIDTH 32
`define PREFIX_WIDTH 6
`define MAC_WIDTH 48
`define PORT_WIDTH 2