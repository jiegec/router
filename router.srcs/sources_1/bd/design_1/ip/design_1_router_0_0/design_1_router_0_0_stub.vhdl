-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
-- Date        : Sun Jun  9 19:40:45 2019
-- Host        : oslab-Ubuntu16 running 64-bit Ubuntu 18.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/oslab/router/router.srcs/sources_1/bd/design_1/ip/design_1_router_0_0/design_1_router_0_0_stub.vhdl
-- Design      : design_1_router_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_router_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    clk_125M : in STD_LOGIC;
    clk_200M : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    axis_clk : in STD_LOGIC;
    axis_rxd_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axis_rxd_tlast : in STD_LOGIC;
    axis_rxd_tready : out STD_LOGIC;
    axis_rxd_tvalid : in STD_LOGIC;
    axis_txd_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    axis_txd_tlast : out STD_LOGIC;
    axis_txd_tready : in STD_LOGIC;
    axis_txd_tvalid : out STD_LOGIC;
    rgmii1_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii1_rx_ctl : in STD_LOGIC;
    rgmii1_rxc : in STD_LOGIC;
    rgmii1_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii1_tx_ctl : out STD_LOGIC;
    rgmii1_txc : out STD_LOGIC;
    rgmii2_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii2_rx_ctl : in STD_LOGIC;
    rgmii2_rxc : in STD_LOGIC;
    rgmii2_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii2_tx_ctl : out STD_LOGIC;
    rgmii2_txc : out STD_LOGIC;
    rgmii3_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii3_rx_ctl : in STD_LOGIC;
    rgmii3_rxc : in STD_LOGIC;
    rgmii3_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii3_tx_ctl : out STD_LOGIC;
    rgmii3_txc : out STD_LOGIC;
    rgmii4_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii4_rx_ctl : in STD_LOGIC;
    rgmii4_rxc : in STD_LOGIC;
    rgmii4_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii4_tx_ctl : out STD_LOGIC;
    rgmii4_txc : out STD_LOGIC;
    stats_rx_packets : out STD_LOGIC_VECTOR ( 255 downto 0 );
    stats_rx_bytes : out STD_LOGIC_VECTOR ( 255 downto 0 );
    stats_tx_packets : out STD_LOGIC_VECTOR ( 255 downto 0 );
    stats_tx_bytes : out STD_LOGIC_VECTOR ( 255 downto 0 );
    os_clk : in STD_LOGIC;
    os_addr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    os_din : in STD_LOGIC_VECTOR ( 127 downto 0 );
    os_dout : out STD_LOGIC_VECTOR ( 127 downto 0 );
    os_we : in STD_LOGIC_VECTOR ( 15 downto 0 );
    os_rst : in STD_LOGIC;
    os_en : in STD_LOGIC
  );

end design_1_router_0_0;

architecture stub of design_1_router_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,clk_125M,clk_200M,reset_n,axis_clk,axis_rxd_tdata[7:0],axis_rxd_tlast,axis_rxd_tready,axis_rxd_tvalid,axis_txd_tdata[7:0],axis_txd_tlast,axis_txd_tready,axis_txd_tvalid,rgmii1_rd[3:0],rgmii1_rx_ctl,rgmii1_rxc,rgmii1_td[3:0],rgmii1_tx_ctl,rgmii1_txc,rgmii2_rd[3:0],rgmii2_rx_ctl,rgmii2_rxc,rgmii2_td[3:0],rgmii2_tx_ctl,rgmii2_txc,rgmii3_rd[3:0],rgmii3_rx_ctl,rgmii3_rxc,rgmii3_td[3:0],rgmii3_tx_ctl,rgmii3_txc,rgmii4_rd[3:0],rgmii4_rx_ctl,rgmii4_rxc,rgmii4_td[3:0],rgmii4_tx_ctl,rgmii4_txc,stats_rx_packets[255:0],stats_rx_bytes[255:0],stats_tx_packets[255:0],stats_tx_bytes[255:0],os_clk,os_addr[15:0],os_din[127:0],os_dout[127:0],os_we[15:0],os_rst,os_en";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "router_top,Vivado 2018.1";
begin
end;
