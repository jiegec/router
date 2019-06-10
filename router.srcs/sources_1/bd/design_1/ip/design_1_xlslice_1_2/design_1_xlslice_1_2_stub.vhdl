-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
-- Date        : Mon Jun 10 01:02:58 2019
-- Host        : oslab-Ubuntu16 running 64-bit Ubuntu 18.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top design_1_xlslice_1_2 -prefix
--               design_1_xlslice_1_2_ design_1_xlslice_1_1_stub.vhdl
-- Design      : design_1_xlslice_1_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_xlslice_1_2 is
  Port ( 
    Din : in STD_LOGIC_VECTOR ( 255 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end design_1_xlslice_1_2;

architecture stub of design_1_xlslice_1_2 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "Din[255:0],Dout[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "xlslice_v1_0_1_xlslice,Vivado 2018.1";
begin
end;
