set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]

set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

set_property PACKAGE_PIN A17 [get_ports reset]
set_property PACKAGE_PIN J18 [get_ports {rgmii1_rd[0]}]
set_property PACKAGE_PIN K18 [get_ports {rgmii1_rd[1]}]
set_property PACKAGE_PIN J15 [get_ports {rgmii1_rd[2]}]
set_property PACKAGE_PIN K15 [get_ports {rgmii1_rd[3]}]
set_property PACKAGE_PIN K20 [get_ports rgmii1_rx_ctl]
set_property PACKAGE_PIN K19 [get_ports rgmii1_rxc]
set_property PACKAGE_PIN N17 [get_ports {rgmii1_td[0]}]
set_property PACKAGE_PIN N18 [get_ports {rgmii1_td[1]}]
set_property PACKAGE_PIN N19 [get_ports {rgmii1_td[2]}]
set_property PACKAGE_PIN N20 [get_ports {rgmii1_td[3]}]
set_property PACKAGE_PIN R20 [get_ports rgmii1_tx_ctl]
set_property PACKAGE_PIN R21 [get_ports rgmii1_txc]


set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_rd[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_rd[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_rd[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_rd[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii1_rx_ctl]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii1_rxc]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_td[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_td[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_td[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rgmii1_td[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii1_tx_ctl]
set_property IOSTANDARD LVCMOS33 [get_ports rgmii1_txc]


connect_debug_port u_ila_0/probe2 [get_nets [list reset_n]]
connect_debug_port u_ila_1/probe0 [get_nets [list rgmii_tx_clk]]
connect_debug_port dbg_hub/clk [get_nets rgmii_tx_clk]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list rgmii1_rxc_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 4 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {rx_data1[0]} {rx_data1[1]} {rx_data1[2]} {rx_data1[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 4 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {rx_data2[0]} {rx_data2[1]} {rx_data2[2]} {rx_data2[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list rgmii1_rx_ctl_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list trans]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets rgmii1_rxc_IBUF_BUFG]
