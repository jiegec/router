// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
// Date        : Mon Jun 17 01:38:39 2019
// Host        : oslab-Ubuntu16 running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/oslab/router/router.srcs/sources_1/bd/design_1/ip/design_1_xlslice_2_0/design_1_xlslice_2_0_stub.v
// Design      : design_1_xlslice_2_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlslice_v1_0_1_xlslice,Vivado 2018.3" *)
module design_1_xlslice_2_0(Din, Dout)
/* synthesis syn_black_box black_box_pad_pin="Din[255:0],Dout[31:0]" */;
  input [255:0]Din;
  output [31:0]Dout;
endmodule
