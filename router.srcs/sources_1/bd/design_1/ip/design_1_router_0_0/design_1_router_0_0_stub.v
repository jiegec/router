// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
// Date        : Mon Jun 10 17:07:27 2019
// Host        : oslab-Ubuntu16 running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/oslab/router/router.srcs/sources_1/bd/design_1/ip/design_1_router_0_0/design_1_router_0_0_stub.v
// Design      : design_1_router_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "router_top,Vivado 2018.1" *)
module design_1_router_0_0(clk, clk_125M, clk_200M, reset_n, axis_clk, 
  axis_rxd_tdata, axis_rxd_tlast, axis_rxd_tready, axis_rxd_tvalid, axis_txd_tdata, 
  axis_txd_tlast, axis_txd_tready, axis_txd_tvalid, rgmii1_rd, rgmii1_rx_ctl, rgmii1_rxc, 
  rgmii1_td, rgmii1_tx_ctl, rgmii1_txc, rgmii2_rd, rgmii2_rx_ctl, rgmii2_rxc, rgmii2_td, 
  rgmii2_tx_ctl, rgmii2_txc, rgmii3_rd, rgmii3_rx_ctl, rgmii3_rxc, rgmii3_td, rgmii3_tx_ctl, 
  rgmii3_txc, rgmii4_rd, rgmii4_rx_ctl, rgmii4_rxc, rgmii4_td, rgmii4_tx_ctl, rgmii4_txc, 
  stats_rx_packets, stats_rx_bytes, stats_tx_packets, stats_tx_bytes, os_clk, os_addr, os_din, 
  os_dout, os_we, os_rst, os_en)
/* synthesis syn_black_box black_box_pad_pin="clk,clk_125M,clk_200M,reset_n,axis_clk,axis_rxd_tdata[7:0],axis_rxd_tlast,axis_rxd_tready,axis_rxd_tvalid,axis_txd_tdata[7:0],axis_txd_tlast,axis_txd_tready,axis_txd_tvalid,rgmii1_rd[3:0],rgmii1_rx_ctl,rgmii1_rxc,rgmii1_td[3:0],rgmii1_tx_ctl,rgmii1_txc,rgmii2_rd[3:0],rgmii2_rx_ctl,rgmii2_rxc,rgmii2_td[3:0],rgmii2_tx_ctl,rgmii2_txc,rgmii3_rd[3:0],rgmii3_rx_ctl,rgmii3_rxc,rgmii3_td[3:0],rgmii3_tx_ctl,rgmii3_txc,rgmii4_rd[3:0],rgmii4_rx_ctl,rgmii4_rxc,rgmii4_td[3:0],rgmii4_tx_ctl,rgmii4_txc,stats_rx_packets[255:0],stats_rx_bytes[255:0],stats_tx_packets[255:0],stats_tx_bytes[255:0],os_clk,os_addr[15:0],os_din[127:0],os_dout[127:0],os_we[15:0],os_rst,os_en" */;
  input clk;
  input clk_125M;
  input clk_200M;
  input reset_n;
  input axis_clk;
  input [7:0]axis_rxd_tdata;
  input axis_rxd_tlast;
  output axis_rxd_tready;
  input axis_rxd_tvalid;
  output [7:0]axis_txd_tdata;
  output axis_txd_tlast;
  input axis_txd_tready;
  output axis_txd_tvalid;
  input [3:0]rgmii1_rd;
  input rgmii1_rx_ctl;
  input rgmii1_rxc;
  output [3:0]rgmii1_td;
  output rgmii1_tx_ctl;
  output rgmii1_txc;
  input [3:0]rgmii2_rd;
  input rgmii2_rx_ctl;
  input rgmii2_rxc;
  output [3:0]rgmii2_td;
  output rgmii2_tx_ctl;
  output rgmii2_txc;
  input [3:0]rgmii3_rd;
  input rgmii3_rx_ctl;
  input rgmii3_rxc;
  output [3:0]rgmii3_td;
  output rgmii3_tx_ctl;
  output rgmii3_txc;
  input [3:0]rgmii4_rd;
  input rgmii4_rx_ctl;
  input rgmii4_rxc;
  output [3:0]rgmii4_td;
  output rgmii4_tx_ctl;
  output rgmii4_txc;
  output [255:0]stats_rx_packets;
  output [255:0]stats_rx_bytes;
  output [255:0]stats_tx_packets;
  output [255:0]stats_tx_bytes;
  input os_clk;
  input [15:0]os_addr;
  input [127:0]os_din;
  output [127:0]os_dout;
  input [15:0]os_we;
  input os_rst;
  input os_en;
endmodule
