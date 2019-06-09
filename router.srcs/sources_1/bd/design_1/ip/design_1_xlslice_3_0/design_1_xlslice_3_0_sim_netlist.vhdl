-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
-- Date        : Mon Jun 10 01:02:59 2019
-- Host        : oslab-Ubuntu16 running 64-bit Ubuntu 18.04.2 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/oslab/router/router.srcs/sources_1/bd/design_1/ip/design_1_xlslice_3_0/design_1_xlslice_3_0_sim_netlist.vhdl
-- Design      : design_1_xlslice_3_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_xlslice_3_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 255 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_xlslice_3_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_xlslice_3_0 : entity is "design_1_xlslice_3_0,xlslice_v1_0_1_xlslice,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_xlslice_3_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_xlslice_3_0 : entity is "xlslice_v1_0_1_xlslice,Vivado 2018.1";
end design_1_xlslice_3_0;

architecture STRUCTURE of design_1_xlslice_3_0 is
  signal \^din\ : STD_LOGIC_VECTOR ( 255 downto 0 );
begin
  Dout(31 downto 0) <= \^din\(95 downto 64);
  \^din\(95 downto 64) <= Din(95 downto 64);
end STRUCTURE;
