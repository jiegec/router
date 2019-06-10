// (c) Copyright 1995-2019 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: me.jiegec:ip:router:1.4
// IP Revision: 10

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_router_0_0 (
  clk,
  clk_125M,
  clk_200M,
  reset_n,
  axis_clk,
  axis_rxd_tdata,
  axis_rxd_tlast,
  axis_rxd_tready,
  axis_rxd_tvalid,
  axis_txd_tdata,
  axis_txd_tlast,
  axis_txd_tready,
  axis_txd_tvalid,
  rgmii1_rd,
  rgmii1_rx_ctl,
  rgmii1_rxc,
  rgmii1_td,
  rgmii1_tx_ctl,
  rgmii1_txc,
  rgmii2_rd,
  rgmii2_rx_ctl,
  rgmii2_rxc,
  rgmii2_td,
  rgmii2_tx_ctl,
  rgmii2_txc,
  rgmii3_rd,
  rgmii3_rx_ctl,
  rgmii3_rxc,
  rgmii3_td,
  rgmii3_tx_ctl,
  rgmii3_txc,
  rgmii4_rd,
  rgmii4_rx_ctl,
  rgmii4_rxc,
  rgmii4_td,
  rgmii4_tx_ctl,
  rgmii4_txc,
  stats_rx_packets,
  stats_rx_bytes,
  stats_tx_packets,
  stats_tx_bytes,
  os_clk,
  os_addr,
  os_din,
  os_dout,
  os_we,
  os_rst,
  os_en
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 200000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK3" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk_125M, FREQ_HZ 125000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK2" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk_125M CLK" *)
input wire clk_125M;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk_200M, FREQ_HZ 200000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK3" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk_200M CLK" *)
input wire clk_200M;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_n RST" *)
input wire reset_n;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axis_clk, ASSOCIATED_BUSIF axis_rxd:axis_txd, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 axis_clk CLK" *)
input wire axis_clk;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis_rxd TDATA" *)
input wire [7 : 0] axis_rxd_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis_rxd TLAST" *)
input wire axis_rxd_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis_rxd TREADY" *)
output wire axis_rxd_tready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axis_rxd, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis_rxd TVALID" *)
input wire axis_rxd_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis_txd TDATA" *)
output wire [7 : 0] axis_txd_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis_txd TLAST" *)
output wire axis_txd_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis_txd TREADY" *)
input wire axis_txd_tready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axis_txd, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis_txd TVALID" *)
output wire axis_txd_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii1 RD" *)
input wire [3 : 0] rgmii1_rd;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii1 RX_CTL" *)
input wire rgmii1_rx_ctl;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii1 RXC" *)
input wire rgmii1_rxc;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii1 TD" *)
output wire [3 : 0] rgmii1_td;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii1 TX_CTL" *)
output wire rgmii1_tx_ctl;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii1 TXC" *)
output wire rgmii1_txc;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii2 RD" *)
input wire [3 : 0] rgmii2_rd;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii2 RX_CTL" *)
input wire rgmii2_rx_ctl;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii2 RXC" *)
input wire rgmii2_rxc;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii2 TD" *)
output wire [3 : 0] rgmii2_td;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii2 TX_CTL" *)
output wire rgmii2_tx_ctl;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii2 TXC" *)
output wire rgmii2_txc;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii3 RD" *)
input wire [3 : 0] rgmii3_rd;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii3 RX_CTL" *)
input wire rgmii3_rx_ctl;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii3 RXC" *)
input wire rgmii3_rxc;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii3 TD" *)
output wire [3 : 0] rgmii3_td;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii3 TX_CTL" *)
output wire rgmii3_tx_ctl;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii3 TXC" *)
output wire rgmii3_txc;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii4 RD" *)
input wire [3 : 0] rgmii4_rd;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii4 RX_CTL" *)
input wire rgmii4_rx_ctl;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii4 RXC" *)
input wire rgmii4_rxc;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii4 TD" *)
output wire [3 : 0] rgmii4_td;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii4 TX_CTL" *)
output wire rgmii4_tx_ctl;
(* X_INTERFACE_INFO = "xilinx.com:interface:rgmii:1.0 rgmii4 TXC" *)
output wire rgmii4_txc;
output wire [255 : 0] stats_rx_packets;
output wire [255 : 0] stats_rx_bytes;
output wire [255 : 0] stats_tx_packets;
output wire [255 : 0] stats_tx_bytes;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME os_clk, ASSOCIATED_RESET os_rst, ASSOCIATED_BUSIF routing_table, FREQ_HZ 100000000, PHASE 0.000" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 os_clk CLK, xilinx.com:interface:bram:1.0 routing_table CLK" *)
input wire os_clk;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 routing_table ADDR" *)
input wire [15 : 0] os_addr;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 routing_table DIN" *)
input wire [127 : 0] os_din;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 routing_table DOUT" *)
output wire [127 : 0] os_dout;
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 routing_table WE" *)
input wire [15 : 0] os_we;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME os_rst, POLARITY ACTIVE_LOW" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 os_rst RST, xilinx.com:interface:bram:1.0 routing_table RST" *)
input wire os_rst;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME routing_table, MEM_SIZE 16384, MEM_WIDTH 128, MEM_ECC NONE, MASTER_TYPE OTHER" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 routing_table EN" *)
input wire os_en;

  router_top inst (
    .clk(clk),
    .clk_125M(clk_125M),
    .clk_200M(clk_200M),
    .reset_n(reset_n),
    .axis_clk(axis_clk),
    .axis_rxd_tdata(axis_rxd_tdata),
    .axis_rxd_tlast(axis_rxd_tlast),
    .axis_rxd_tready(axis_rxd_tready),
    .axis_rxd_tvalid(axis_rxd_tvalid),
    .axis_txd_tdata(axis_txd_tdata),
    .axis_txd_tlast(axis_txd_tlast),
    .axis_txd_tready(axis_txd_tready),
    .axis_txd_tvalid(axis_txd_tvalid),
    .rgmii1_rd(rgmii1_rd),
    .rgmii1_rx_ctl(rgmii1_rx_ctl),
    .rgmii1_rxc(rgmii1_rxc),
    .rgmii1_td(rgmii1_td),
    .rgmii1_tx_ctl(rgmii1_tx_ctl),
    .rgmii1_txc(rgmii1_txc),
    .rgmii2_rd(rgmii2_rd),
    .rgmii2_rx_ctl(rgmii2_rx_ctl),
    .rgmii2_rxc(rgmii2_rxc),
    .rgmii2_td(rgmii2_td),
    .rgmii2_tx_ctl(rgmii2_tx_ctl),
    .rgmii2_txc(rgmii2_txc),
    .rgmii3_rd(rgmii3_rd),
    .rgmii3_rx_ctl(rgmii3_rx_ctl),
    .rgmii3_rxc(rgmii3_rxc),
    .rgmii3_td(rgmii3_td),
    .rgmii3_tx_ctl(rgmii3_tx_ctl),
    .rgmii3_txc(rgmii3_txc),
    .rgmii4_rd(rgmii4_rd),
    .rgmii4_rx_ctl(rgmii4_rx_ctl),
    .rgmii4_rxc(rgmii4_rxc),
    .rgmii4_td(rgmii4_td),
    .rgmii4_tx_ctl(rgmii4_tx_ctl),
    .rgmii4_txc(rgmii4_txc),
    .stats_rx_packets(stats_rx_packets),
    .stats_rx_bytes(stats_rx_bytes),
    .stats_tx_packets(stats_tx_packets),
    .stats_tx_bytes(stats_tx_bytes),
    .os_clk(os_clk),
    .os_addr(os_addr),
    .os_din(os_din),
    .os_dout(os_dout),
    .os_we(os_we),
    .os_rst(os_rst),
    .os_en(os_en)
  );
endmodule
