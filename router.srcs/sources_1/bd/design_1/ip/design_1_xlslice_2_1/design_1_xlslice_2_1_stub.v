// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
// Date        : Mon Jun 10 01:02:58 2019
// Host        : oslab-Ubuntu16 running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top design_1_xlslice_2_1 -prefix
//               design_1_xlslice_2_1_ design_1_xlslice_3_0_stub.v
// Design      : design_1_xlslice_3_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlslice_v1_0_1_xlslice,Vivado 2018.1" *)
module design_1_xlslice_2_1(Din, Dout)
/* synthesis syn_black_box black_box_pad_pin="Din[255:0],Dout[31:0]" */;
  input [255:0]Din;
  output [31:0]Dout;
endmodule
