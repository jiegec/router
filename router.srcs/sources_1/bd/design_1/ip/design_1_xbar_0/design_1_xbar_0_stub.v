// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
// Date        : Fri Dec  6 13:24:39 2019
// Host        : oslab-Ubuntu16 running 64-bit Ubuntu 18.04.3 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top design_1_xbar_0 -prefix
//               design_1_xbar_0_ design_1_xbar_0_stub.v
// Design      : design_1_xbar_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axi_crossbar_v2_1_19_axi_crossbar,Vivado 2018.3" *)
module design_1_xbar_0(aclk, aresetn, s_axi_awaddr, s_axi_awlen, 
  s_axi_awsize, s_axi_awburst, s_axi_awlock, s_axi_awcache, s_axi_awprot, s_axi_awqos, 
  s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wlast, s_axi_wvalid, 
  s_axi_wready, s_axi_bresp, s_axi_bvalid, s_axi_bready, s_axi_araddr, s_axi_arlen, 
  s_axi_arsize, s_axi_arburst, s_axi_arlock, s_axi_arcache, s_axi_arprot, s_axi_arqos, 
  s_axi_arvalid, s_axi_arready, s_axi_rdata, s_axi_rresp, s_axi_rlast, s_axi_rvalid, 
  s_axi_rready, m_axi_awaddr, m_axi_awlen, m_axi_awsize, m_axi_awburst, m_axi_awlock, 
  m_axi_awcache, m_axi_awprot, m_axi_awregion, m_axi_awqos, m_axi_awvalid, m_axi_awready, 
  m_axi_wdata, m_axi_wstrb, m_axi_wlast, m_axi_wvalid, m_axi_wready, m_axi_bresp, m_axi_bvalid, 
  m_axi_bready, m_axi_araddr, m_axi_arlen, m_axi_arsize, m_axi_arburst, m_axi_arlock, 
  m_axi_arcache, m_axi_arprot, m_axi_arregion, m_axi_arqos, m_axi_arvalid, m_axi_arready, 
  m_axi_rdata, m_axi_rresp, m_axi_rlast, m_axi_rvalid, m_axi_rready)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axi_awaddr[31:0],s_axi_awlen[7:0],s_axi_awsize[2:0],s_axi_awburst[1:0],s_axi_awlock[0:0],s_axi_awcache[3:0],s_axi_awprot[2:0],s_axi_awqos[3:0],s_axi_awvalid[0:0],s_axi_awready[0:0],s_axi_wdata[127:0],s_axi_wstrb[15:0],s_axi_wlast[0:0],s_axi_wvalid[0:0],s_axi_wready[0:0],s_axi_bresp[1:0],s_axi_bvalid[0:0],s_axi_bready[0:0],s_axi_araddr[31:0],s_axi_arlen[7:0],s_axi_arsize[2:0],s_axi_arburst[1:0],s_axi_arlock[0:0],s_axi_arcache[3:0],s_axi_arprot[2:0],s_axi_arqos[3:0],s_axi_arvalid[0:0],s_axi_arready[0:0],s_axi_rdata[127:0],s_axi_rresp[1:0],s_axi_rlast[0:0],s_axi_rvalid[0:0],s_axi_rready[0:0],m_axi_awaddr[447:0],m_axi_awlen[111:0],m_axi_awsize[41:0],m_axi_awburst[27:0],m_axi_awlock[13:0],m_axi_awcache[55:0],m_axi_awprot[41:0],m_axi_awregion[55:0],m_axi_awqos[55:0],m_axi_awvalid[13:0],m_axi_awready[13:0],m_axi_wdata[1791:0],m_axi_wstrb[223:0],m_axi_wlast[13:0],m_axi_wvalid[13:0],m_axi_wready[13:0],m_axi_bresp[27:0],m_axi_bvalid[13:0],m_axi_bready[13:0],m_axi_araddr[447:0],m_axi_arlen[111:0],m_axi_arsize[41:0],m_axi_arburst[27:0],m_axi_arlock[13:0],m_axi_arcache[55:0],m_axi_arprot[41:0],m_axi_arregion[55:0],m_axi_arqos[55:0],m_axi_arvalid[13:0],m_axi_arready[13:0],m_axi_rdata[1791:0],m_axi_rresp[27:0],m_axi_rlast[13:0],m_axi_rvalid[13:0],m_axi_rready[13:0]" */;
  input aclk;
  input aresetn;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [0:0]s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input [3:0]s_axi_awqos;
  input [0:0]s_axi_awvalid;
  output [0:0]s_axi_awready;
  input [127:0]s_axi_wdata;
  input [15:0]s_axi_wstrb;
  input [0:0]s_axi_wlast;
  input [0:0]s_axi_wvalid;
  output [0:0]s_axi_wready;
  output [1:0]s_axi_bresp;
  output [0:0]s_axi_bvalid;
  input [0:0]s_axi_bready;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input [0:0]s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input [3:0]s_axi_arqos;
  input [0:0]s_axi_arvalid;
  output [0:0]s_axi_arready;
  output [127:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output [0:0]s_axi_rlast;
  output [0:0]s_axi_rvalid;
  input [0:0]s_axi_rready;
  output [447:0]m_axi_awaddr;
  output [111:0]m_axi_awlen;
  output [41:0]m_axi_awsize;
  output [27:0]m_axi_awburst;
  output [13:0]m_axi_awlock;
  output [55:0]m_axi_awcache;
  output [41:0]m_axi_awprot;
  output [55:0]m_axi_awregion;
  output [55:0]m_axi_awqos;
  output [13:0]m_axi_awvalid;
  input [13:0]m_axi_awready;
  output [1791:0]m_axi_wdata;
  output [223:0]m_axi_wstrb;
  output [13:0]m_axi_wlast;
  output [13:0]m_axi_wvalid;
  input [13:0]m_axi_wready;
  input [27:0]m_axi_bresp;
  input [13:0]m_axi_bvalid;
  output [13:0]m_axi_bready;
  output [447:0]m_axi_araddr;
  output [111:0]m_axi_arlen;
  output [41:0]m_axi_arsize;
  output [27:0]m_axi_arburst;
  output [13:0]m_axi_arlock;
  output [55:0]m_axi_arcache;
  output [41:0]m_axi_arprot;
  output [55:0]m_axi_arregion;
  output [55:0]m_axi_arqos;
  output [13:0]m_axi_arvalid;
  input [13:0]m_axi_arready;
  input [1791:0]m_axi_rdata;
  input [27:0]m_axi_rresp;
  input [13:0]m_axi_rlast;
  input [13:0]m_axi_rvalid;
  output [13:0]m_axi_rready;
endmodule
