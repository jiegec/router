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
connect_debug_port u_ila_0/clk [get_nets [list port_inst_0/tri_mode_ethernet_mac_0_inst/inst/tri_mode_ethernet_mac_i/rgmii_interface/CLK]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 2 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {arp_insert_port[0]} {arp_insert_port[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {arp_insert_ip[0]} {arp_insert_ip[1]} {arp_insert_ip[2]} {arp_insert_ip[3]} {arp_insert_ip[4]} {arp_insert_ip[5]} {arp_insert_ip[6]} {arp_insert_ip[7]} {arp_insert_ip[8]} {arp_insert_ip[9]} {arp_insert_ip[10]} {arp_insert_ip[11]} {arp_insert_ip[12]} {arp_insert_ip[13]} {arp_insert_ip[14]} {arp_insert_ip[15]} {arp_insert_ip[16]} {arp_insert_ip[17]} {arp_insert_ip[18]} {arp_insert_ip[19]} {arp_insert_ip[20]} {arp_insert_ip[21]} {arp_insert_ip[22]} {arp_insert_ip[23]} {arp_insert_ip[24]} {arp_insert_ip[25]} {arp_insert_ip[26]} {arp_insert_ip[27]} {arp_insert_ip[28]} {arp_insert_ip[29]} {arp_insert_ip[30]} {arp_insert_ip[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 48 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {arp_insert_mac[0]} {arp_insert_mac[1]} {arp_insert_mac[2]} {arp_insert_mac[3]} {arp_insert_mac[4]} {arp_insert_mac[5]} {arp_insert_mac[6]} {arp_insert_mac[7]} {arp_insert_mac[8]} {arp_insert_mac[9]} {arp_insert_mac[10]} {arp_insert_mac[11]} {arp_insert_mac[12]} {arp_insert_mac[13]} {arp_insert_mac[14]} {arp_insert_mac[15]} {arp_insert_mac[16]} {arp_insert_mac[17]} {arp_insert_mac[18]} {arp_insert_mac[19]} {arp_insert_mac[20]} {arp_insert_mac[21]} {arp_insert_mac[22]} {arp_insert_mac[23]} {arp_insert_mac[24]} {arp_insert_mac[25]} {arp_insert_mac[26]} {arp_insert_mac[27]} {arp_insert_mac[28]} {arp_insert_mac[29]} {arp_insert_mac[30]} {arp_insert_mac[31]} {arp_insert_mac[32]} {arp_insert_mac[33]} {arp_insert_mac[34]} {arp_insert_mac[35]} {arp_insert_mac[36]} {arp_insert_mac[37]} {arp_insert_mac[38]} {arp_insert_mac[39]} {arp_insert_mac[40]} {arp_insert_mac[41]} {arp_insert_mac[42]} {arp_insert_mac[43]} {arp_insert_mac[44]} {arp_insert_mac[45]} {arp_insert_mac[46]} {arp_insert_mac[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {port_inst_0/rx_data_in[0]} {port_inst_0/rx_data_in[1]} {port_inst_0/rx_data_in[2]} {port_inst_0/rx_data_in[3]} {port_inst_0/rx_data_in[4]} {port_inst_0/rx_data_in[5]} {port_inst_0/rx_data_in[6]} {port_inst_0/rx_data_in[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {port_inst_0/rx_axis_mac_tdata[0]} {port_inst_0/rx_axis_mac_tdata[1]} {port_inst_0/rx_axis_mac_tdata[2]} {port_inst_0/rx_axis_mac_tdata[3]} {port_inst_0/rx_axis_mac_tdata[4]} {port_inst_0/rx_axis_mac_tdata[5]} {port_inst_0/rx_axis_mac_tdata[6]} {port_inst_0/rx_axis_mac_tdata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list arp_insert_ready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list arp_insert_valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list port_inst_0/rx_axis_mac_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list port_inst_0/rx_axis_mac_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list port_inst_0/rx_axis_mac_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list port_inst_0/rx_axis_mac_tvalid_last]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list port_inst_0/rx_data_busy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list port_inst_0/rx_data_full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list port_inst_0/rx_data_ren]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list port_inst_0/rx_data_wen]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list port_inst_0/rx_reset]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_CLK]
