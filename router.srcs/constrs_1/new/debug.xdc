create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list mmcm_inst/inst/clk_out3]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {port_inst_0/rx_nexthop_ipv4_addr[0]} {port_inst_0/rx_nexthop_ipv4_addr[1]} {port_inst_0/rx_nexthop_ipv4_addr[2]} {port_inst_0/rx_nexthop_ipv4_addr[3]} {port_inst_0/rx_nexthop_ipv4_addr[4]} {port_inst_0/rx_nexthop_ipv4_addr[5]} {port_inst_0/rx_nexthop_ipv4_addr[6]} {port_inst_0/rx_nexthop_ipv4_addr[7]} {port_inst_0/rx_nexthop_ipv4_addr[8]} {port_inst_0/rx_nexthop_ipv4_addr[9]} {port_inst_0/rx_nexthop_ipv4_addr[10]} {port_inst_0/rx_nexthop_ipv4_addr[11]} {port_inst_0/rx_nexthop_ipv4_addr[12]} {port_inst_0/rx_nexthop_ipv4_addr[13]} {port_inst_0/rx_nexthop_ipv4_addr[14]} {port_inst_0/rx_nexthop_ipv4_addr[15]} {port_inst_0/rx_nexthop_ipv4_addr[16]} {port_inst_0/rx_nexthop_ipv4_addr[17]} {port_inst_0/rx_nexthop_ipv4_addr[18]} {port_inst_0/rx_nexthop_ipv4_addr[19]} {port_inst_0/rx_nexthop_ipv4_addr[20]} {port_inst_0/rx_nexthop_ipv4_addr[21]} {port_inst_0/rx_nexthop_ipv4_addr[22]} {port_inst_0/rx_nexthop_ipv4_addr[23]} {port_inst_0/rx_nexthop_ipv4_addr[24]} {port_inst_0/rx_nexthop_ipv4_addr[25]} {port_inst_0/rx_nexthop_ipv4_addr[26]} {port_inst_0/rx_nexthop_ipv4_addr[27]} {port_inst_0/rx_nexthop_ipv4_addr[28]} {port_inst_0/rx_nexthop_ipv4_addr[29]} {port_inst_0/rx_nexthop_ipv4_addr[30]} {port_inst_0/rx_nexthop_ipv4_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 48 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {port_inst_0/rx_nexthop_mac_addr[0]} {port_inst_0/rx_nexthop_mac_addr[1]} {port_inst_0/rx_nexthop_mac_addr[2]} {port_inst_0/rx_nexthop_mac_addr[3]} {port_inst_0/rx_nexthop_mac_addr[4]} {port_inst_0/rx_nexthop_mac_addr[5]} {port_inst_0/rx_nexthop_mac_addr[6]} {port_inst_0/rx_nexthop_mac_addr[7]} {port_inst_0/rx_nexthop_mac_addr[8]} {port_inst_0/rx_nexthop_mac_addr[9]} {port_inst_0/rx_nexthop_mac_addr[10]} {port_inst_0/rx_nexthop_mac_addr[11]} {port_inst_0/rx_nexthop_mac_addr[12]} {port_inst_0/rx_nexthop_mac_addr[13]} {port_inst_0/rx_nexthop_mac_addr[14]} {port_inst_0/rx_nexthop_mac_addr[15]} {port_inst_0/rx_nexthop_mac_addr[16]} {port_inst_0/rx_nexthop_mac_addr[17]} {port_inst_0/rx_nexthop_mac_addr[18]} {port_inst_0/rx_nexthop_mac_addr[19]} {port_inst_0/rx_nexthop_mac_addr[20]} {port_inst_0/rx_nexthop_mac_addr[21]} {port_inst_0/rx_nexthop_mac_addr[22]} {port_inst_0/rx_nexthop_mac_addr[23]} {port_inst_0/rx_nexthop_mac_addr[24]} {port_inst_0/rx_nexthop_mac_addr[25]} {port_inst_0/rx_nexthop_mac_addr[26]} {port_inst_0/rx_nexthop_mac_addr[27]} {port_inst_0/rx_nexthop_mac_addr[28]} {port_inst_0/rx_nexthop_mac_addr[29]} {port_inst_0/rx_nexthop_mac_addr[30]} {port_inst_0/rx_nexthop_mac_addr[31]} {port_inst_0/rx_nexthop_mac_addr[32]} {port_inst_0/rx_nexthop_mac_addr[33]} {port_inst_0/rx_nexthop_mac_addr[34]} {port_inst_0/rx_nexthop_mac_addr[35]} {port_inst_0/rx_nexthop_mac_addr[36]} {port_inst_0/rx_nexthop_mac_addr[37]} {port_inst_0/rx_nexthop_mac_addr[38]} {port_inst_0/rx_nexthop_mac_addr[39]} {port_inst_0/rx_nexthop_mac_addr[40]} {port_inst_0/rx_nexthop_mac_addr[41]} {port_inst_0/rx_nexthop_mac_addr[42]} {port_inst_0/rx_nexthop_mac_addr[43]} {port_inst_0/rx_nexthop_mac_addr[44]} {port_inst_0/rx_nexthop_mac_addr[45]} {port_inst_0/rx_nexthop_mac_addr[46]} {port_inst_0/rx_nexthop_mac_addr[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 2 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {port_inst_0/rx_nexthop_port[0]} {port_inst_0/rx_nexthop_port[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 14 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {port_inst_0/rx_outbound_counter[0]} {port_inst_0/rx_outbound_counter[1]} {port_inst_0/rx_outbound_counter[2]} {port_inst_0/rx_outbound_counter[3]} {port_inst_0/rx_outbound_counter[4]} {port_inst_0/rx_outbound_counter[5]} {port_inst_0/rx_outbound_counter[6]} {port_inst_0/rx_outbound_counter[7]} {port_inst_0/rx_outbound_counter[8]} {port_inst_0/rx_outbound_counter[9]} {port_inst_0/rx_outbound_counter[10]} {port_inst_0/rx_outbound_counter[11]} {port_inst_0/rx_outbound_counter[12]} {port_inst_0/rx_outbound_counter[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 14 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {port_inst_0/rx_outbound_length[0]} {port_inst_0/rx_outbound_length[1]} {port_inst_0/rx_outbound_length[2]} {port_inst_0/rx_outbound_length[3]} {port_inst_0/rx_outbound_length[4]} {port_inst_0/rx_outbound_length[5]} {port_inst_0/rx_outbound_length[6]} {port_inst_0/rx_outbound_length[7]} {port_inst_0/rx_outbound_length[8]} {port_inst_0/rx_outbound_length[9]} {port_inst_0/rx_outbound_length[10]} {port_inst_0/rx_outbound_length[11]} {port_inst_0/rx_outbound_length[12]} {port_inst_0/rx_outbound_length[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 8 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {port_inst_0/rx_saved_ipv4_out[0]} {port_inst_0/rx_saved_ipv4_out[1]} {port_inst_0/rx_saved_ipv4_out[2]} {port_inst_0/rx_saved_ipv4_out[3]} {port_inst_0/rx_saved_ipv4_out[4]} {port_inst_0/rx_saved_ipv4_out[5]} {port_inst_0/rx_saved_ipv4_out[6]} {port_inst_0/rx_saved_ipv4_out[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 14 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {port_inst_0/rx_saved_ipv4_addr[0]} {port_inst_0/rx_saved_ipv4_addr[1]} {port_inst_0/rx_saved_ipv4_addr[2]} {port_inst_0/rx_saved_ipv4_addr[3]} {port_inst_0/rx_saved_ipv4_addr[4]} {port_inst_0/rx_saved_ipv4_addr[5]} {port_inst_0/rx_saved_ipv4_addr[6]} {port_inst_0/rx_saved_ipv4_addr[7]} {port_inst_0/rx_saved_ipv4_addr[8]} {port_inst_0/rx_saved_ipv4_addr[9]} {port_inst_0/rx_saved_ipv4_addr[10]} {port_inst_0/rx_saved_ipv4_addr[11]} {port_inst_0/rx_saved_ipv4_addr[12]} {port_inst_0/rx_saved_ipv4_addr[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 8 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {port_inst_0/rx_saved_ipv4_in[0]} {port_inst_0/rx_saved_ipv4_in[1]} {port_inst_0/rx_saved_ipv4_in[2]} {port_inst_0/rx_saved_ipv4_in[3]} {port_inst_0/rx_saved_ipv4_in[4]} {port_inst_0/rx_saved_ipv4_in[5]} {port_inst_0/rx_saved_ipv4_in[6]} {port_inst_0/rx_saved_ipv4_in[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 8 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {port_inst_1/rx_saved_ipv4_out[0]} {port_inst_1/rx_saved_ipv4_out[1]} {port_inst_1/rx_saved_ipv4_out[2]} {port_inst_1/rx_saved_ipv4_out[3]} {port_inst_1/rx_saved_ipv4_out[4]} {port_inst_1/rx_saved_ipv4_out[5]} {port_inst_1/rx_saved_ipv4_out[6]} {port_inst_1/rx_saved_ipv4_out[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 8 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {port_inst_1/rx_saved_ipv4_in[0]} {port_inst_1/rx_saved_ipv4_in[1]} {port_inst_1/rx_saved_ipv4_in[2]} {port_inst_1/rx_saved_ipv4_in[3]} {port_inst_1/rx_saved_ipv4_in[4]} {port_inst_1/rx_saved_ipv4_in[5]} {port_inst_1/rx_saved_ipv4_in[6]} {port_inst_1/rx_saved_ipv4_in[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 14 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {port_inst_1/rx_saved_ipv4_addr[0]} {port_inst_1/rx_saved_ipv4_addr[1]} {port_inst_1/rx_saved_ipv4_addr[2]} {port_inst_1/rx_saved_ipv4_addr[3]} {port_inst_1/rx_saved_ipv4_addr[4]} {port_inst_1/rx_saved_ipv4_addr[5]} {port_inst_1/rx_saved_ipv4_addr[6]} {port_inst_1/rx_saved_ipv4_addr[7]} {port_inst_1/rx_saved_ipv4_addr[8]} {port_inst_1/rx_saved_ipv4_addr[9]} {port_inst_1/rx_saved_ipv4_addr[10]} {port_inst_1/rx_saved_ipv4_addr[11]} {port_inst_1/rx_saved_ipv4_addr[12]} {port_inst_1/rx_saved_ipv4_addr[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 2 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {port_inst_1/rx_nexthop_port[0]} {port_inst_1/rx_nexthop_port[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 14 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {port_inst_1/rx_outbound_counter[0]} {port_inst_1/rx_outbound_counter[1]} {port_inst_1/rx_outbound_counter[2]} {port_inst_1/rx_outbound_counter[3]} {port_inst_1/rx_outbound_counter[4]} {port_inst_1/rx_outbound_counter[5]} {port_inst_1/rx_outbound_counter[6]} {port_inst_1/rx_outbound_counter[7]} {port_inst_1/rx_outbound_counter[8]} {port_inst_1/rx_outbound_counter[9]} {port_inst_1/rx_outbound_counter[10]} {port_inst_1/rx_outbound_counter[11]} {port_inst_1/rx_outbound_counter[12]} {port_inst_1/rx_outbound_counter[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 32 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {port_inst_1/rx_nexthop_ipv4_addr[0]} {port_inst_1/rx_nexthop_ipv4_addr[1]} {port_inst_1/rx_nexthop_ipv4_addr[2]} {port_inst_1/rx_nexthop_ipv4_addr[3]} {port_inst_1/rx_nexthop_ipv4_addr[4]} {port_inst_1/rx_nexthop_ipv4_addr[5]} {port_inst_1/rx_nexthop_ipv4_addr[6]} {port_inst_1/rx_nexthop_ipv4_addr[7]} {port_inst_1/rx_nexthop_ipv4_addr[8]} {port_inst_1/rx_nexthop_ipv4_addr[9]} {port_inst_1/rx_nexthop_ipv4_addr[10]} {port_inst_1/rx_nexthop_ipv4_addr[11]} {port_inst_1/rx_nexthop_ipv4_addr[12]} {port_inst_1/rx_nexthop_ipv4_addr[13]} {port_inst_1/rx_nexthop_ipv4_addr[14]} {port_inst_1/rx_nexthop_ipv4_addr[15]} {port_inst_1/rx_nexthop_ipv4_addr[16]} {port_inst_1/rx_nexthop_ipv4_addr[17]} {port_inst_1/rx_nexthop_ipv4_addr[18]} {port_inst_1/rx_nexthop_ipv4_addr[19]} {port_inst_1/rx_nexthop_ipv4_addr[20]} {port_inst_1/rx_nexthop_ipv4_addr[21]} {port_inst_1/rx_nexthop_ipv4_addr[22]} {port_inst_1/rx_nexthop_ipv4_addr[23]} {port_inst_1/rx_nexthop_ipv4_addr[24]} {port_inst_1/rx_nexthop_ipv4_addr[25]} {port_inst_1/rx_nexthop_ipv4_addr[26]} {port_inst_1/rx_nexthop_ipv4_addr[27]} {port_inst_1/rx_nexthop_ipv4_addr[28]} {port_inst_1/rx_nexthop_ipv4_addr[29]} {port_inst_1/rx_nexthop_ipv4_addr[30]} {port_inst_1/rx_nexthop_ipv4_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 48 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {port_inst_1/rx_nexthop_mac_addr[0]} {port_inst_1/rx_nexthop_mac_addr[1]} {port_inst_1/rx_nexthop_mac_addr[2]} {port_inst_1/rx_nexthop_mac_addr[3]} {port_inst_1/rx_nexthop_mac_addr[4]} {port_inst_1/rx_nexthop_mac_addr[5]} {port_inst_1/rx_nexthop_mac_addr[6]} {port_inst_1/rx_nexthop_mac_addr[7]} {port_inst_1/rx_nexthop_mac_addr[8]} {port_inst_1/rx_nexthop_mac_addr[9]} {port_inst_1/rx_nexthop_mac_addr[10]} {port_inst_1/rx_nexthop_mac_addr[11]} {port_inst_1/rx_nexthop_mac_addr[12]} {port_inst_1/rx_nexthop_mac_addr[13]} {port_inst_1/rx_nexthop_mac_addr[14]} {port_inst_1/rx_nexthop_mac_addr[15]} {port_inst_1/rx_nexthop_mac_addr[16]} {port_inst_1/rx_nexthop_mac_addr[17]} {port_inst_1/rx_nexthop_mac_addr[18]} {port_inst_1/rx_nexthop_mac_addr[19]} {port_inst_1/rx_nexthop_mac_addr[20]} {port_inst_1/rx_nexthop_mac_addr[21]} {port_inst_1/rx_nexthop_mac_addr[22]} {port_inst_1/rx_nexthop_mac_addr[23]} {port_inst_1/rx_nexthop_mac_addr[24]} {port_inst_1/rx_nexthop_mac_addr[25]} {port_inst_1/rx_nexthop_mac_addr[26]} {port_inst_1/rx_nexthop_mac_addr[27]} {port_inst_1/rx_nexthop_mac_addr[28]} {port_inst_1/rx_nexthop_mac_addr[29]} {port_inst_1/rx_nexthop_mac_addr[30]} {port_inst_1/rx_nexthop_mac_addr[31]} {port_inst_1/rx_nexthop_mac_addr[32]} {port_inst_1/rx_nexthop_mac_addr[33]} {port_inst_1/rx_nexthop_mac_addr[34]} {port_inst_1/rx_nexthop_mac_addr[35]} {port_inst_1/rx_nexthop_mac_addr[36]} {port_inst_1/rx_nexthop_mac_addr[37]} {port_inst_1/rx_nexthop_mac_addr[38]} {port_inst_1/rx_nexthop_mac_addr[39]} {port_inst_1/rx_nexthop_mac_addr[40]} {port_inst_1/rx_nexthop_mac_addr[41]} {port_inst_1/rx_nexthop_mac_addr[42]} {port_inst_1/rx_nexthop_mac_addr[43]} {port_inst_1/rx_nexthop_mac_addr[44]} {port_inst_1/rx_nexthop_mac_addr[45]} {port_inst_1/rx_nexthop_mac_addr[46]} {port_inst_1/rx_nexthop_mac_addr[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 14 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {port_inst_1/rx_outbound_length[0]} {port_inst_1/rx_outbound_length[1]} {port_inst_1/rx_outbound_length[2]} {port_inst_1/rx_outbound_length[3]} {port_inst_1/rx_outbound_length[4]} {port_inst_1/rx_outbound_length[5]} {port_inst_1/rx_outbound_length[6]} {port_inst_1/rx_outbound_length[7]} {port_inst_1/rx_outbound_length[8]} {port_inst_1/rx_outbound_length[9]} {port_inst_1/rx_outbound_length[10]} {port_inst_1/rx_outbound_length[11]} {port_inst_1/rx_outbound_length[12]} {port_inst_1/rx_outbound_length[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list port_inst_1/arp_write]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list port_inst_0/arp_write]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list port_inst_0/arp_written]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list port_inst_1/arp_written]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list port_inst_1/ip_lookup_routing]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list port_inst_0/ip_lookup_routing]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list port_inst_1/ip_routed]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list port_inst_0/ip_routed]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list port_inst_0/ip_routing]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list port_inst_1/ip_routing]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list port_inst_0/rx_found_nexthop_ipv4]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list port_inst_1/rx_found_nexthop_ipv4]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list port_inst_0/rx_lookup_nexthop_mac]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list port_inst_1/rx_lookup_nexthop_mac]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list port_inst_0/rx_outbound]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list port_inst_1/rx_outbound]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list port_inst_1/rx_outbound_port_id]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list port_inst_0/rx_outbound_port_id]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list port_inst_0/rx_read]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list port_inst_1/rx_read]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list port_inst_0/rx_saved_ipv4_wen]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list port_inst_1/rx_saved_ipv4_wen]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets internal_clk]
