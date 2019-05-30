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
connect_debug_port u_ila_0/clk [get_nets [list top_axi_inst/mmcm_inst_1/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 14 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {top_axi_inst/port_inst_0/tx_len_in[0]} {top_axi_inst/port_inst_0/tx_len_in[1]} {top_axi_inst/port_inst_0/tx_len_in[2]} {top_axi_inst/port_inst_0/tx_len_in[3]} {top_axi_inst/port_inst_0/tx_len_in[4]} {top_axi_inst/port_inst_0/tx_len_in[5]} {top_axi_inst/port_inst_0/tx_len_in[6]} {top_axi_inst/port_inst_0/tx_len_in[7]} {top_axi_inst/port_inst_0/tx_len_in[8]} {top_axi_inst/port_inst_0/tx_len_in[9]} {top_axi_inst/port_inst_0/tx_len_in[10]} {top_axi_inst/port_inst_0/tx_len_in[11]} {top_axi_inst/port_inst_0/tx_len_in[12]} {top_axi_inst/port_inst_0/tx_len_in[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {top_axi_inst/port_inst_0/tx_data_in[0]} {top_axi_inst/port_inst_0/tx_data_in[1]} {top_axi_inst/port_inst_0/tx_data_in[2]} {top_axi_inst/port_inst_0/tx_data_in[3]} {top_axi_inst/port_inst_0/tx_data_in[4]} {top_axi_inst/port_inst_0/tx_data_in[5]} {top_axi_inst/port_inst_0/tx_data_in[6]} {top_axi_inst/port_inst_0/tx_data_in[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {top_axi_inst/fifo_matrix_tx_douta[0]} {top_axi_inst/fifo_matrix_tx_douta[1]} {top_axi_inst/fifo_matrix_tx_douta[2]} {top_axi_inst/fifo_matrix_tx_douta[3]} {top_axi_inst/fifo_matrix_tx_douta[4]} {top_axi_inst/fifo_matrix_tx_douta[5]} {top_axi_inst/fifo_matrix_tx_douta[6]} {top_axi_inst/fifo_matrix_tx_douta[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {top_axi_inst/os_txd_tdata[0]} {top_axi_inst/os_txd_tdata[1]} {top_axi_inst/os_txd_tdata[2]} {top_axi_inst/os_txd_tdata[3]} {top_axi_inst/os_txd_tdata[4]} {top_axi_inst/os_txd_tdata[5]} {top_axi_inst/os_txd_tdata[6]} {top_axi_inst/os_txd_tdata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 14 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {top_axi_inst/fifo_matrix_tx_length[0]} {top_axi_inst/fifo_matrix_tx_length[1]} {top_axi_inst/fifo_matrix_tx_length[2]} {top_axi_inst/fifo_matrix_tx_length[3]} {top_axi_inst/fifo_matrix_tx_length[4]} {top_axi_inst/fifo_matrix_tx_length[5]} {top_axi_inst/fifo_matrix_tx_length[6]} {top_axi_inst/fifo_matrix_tx_length[7]} {top_axi_inst/fifo_matrix_tx_length[8]} {top_axi_inst/fifo_matrix_tx_length[9]} {top_axi_inst/fifo_matrix_tx_length[10]} {top_axi_inst/fifo_matrix_tx_length[11]} {top_axi_inst/fifo_matrix_tx_length[12]} {top_axi_inst/fifo_matrix_tx_length[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 2 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {top_axi_inst/fifo_matrix_tx_index[0]} {top_axi_inst/fifo_matrix_tx_index[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {top_axi_inst/fifo_matrix_tx_dina[0]} {top_axi_inst/fifo_matrix_tx_dina[1]} {top_axi_inst/fifo_matrix_tx_dina[2]} {top_axi_inst/fifo_matrix_tx_dina[3]} {top_axi_inst/fifo_matrix_tx_dina[4]} {top_axi_inst/fifo_matrix_tx_dina[5]} {top_axi_inst/fifo_matrix_tx_dina[6]} {top_axi_inst/fifo_matrix_tx_dina[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 14 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {top_axi_inst/fifo_matrix_tx_counter[0]} {top_axi_inst/fifo_matrix_tx_counter[1]} {top_axi_inst/fifo_matrix_tx_counter[2]} {top_axi_inst/fifo_matrix_tx_counter[3]} {top_axi_inst/fifo_matrix_tx_counter[4]} {top_axi_inst/fifo_matrix_tx_counter[5]} {top_axi_inst/fifo_matrix_tx_counter[6]} {top_axi_inst/fifo_matrix_tx_counter[7]} {top_axi_inst/fifo_matrix_tx_counter[8]} {top_axi_inst/fifo_matrix_tx_counter[9]} {top_axi_inst/fifo_matrix_tx_counter[10]} {top_axi_inst/fifo_matrix_tx_counter[11]} {top_axi_inst/fifo_matrix_tx_counter[12]} {top_axi_inst/fifo_matrix_tx_counter[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 14 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {top_axi_inst/fifo_matrix_tx_addra[0]} {top_axi_inst/fifo_matrix_tx_addra[1]} {top_axi_inst/fifo_matrix_tx_addra[2]} {top_axi_inst/fifo_matrix_tx_addra[3]} {top_axi_inst/fifo_matrix_tx_addra[4]} {top_axi_inst/fifo_matrix_tx_addra[5]} {top_axi_inst/fifo_matrix_tx_addra[6]} {top_axi_inst/fifo_matrix_tx_addra[7]} {top_axi_inst/fifo_matrix_tx_addra[8]} {top_axi_inst/fifo_matrix_tx_addra[9]} {top_axi_inst/fifo_matrix_tx_addra[10]} {top_axi_inst/fifo_matrix_tx_addra[11]} {top_axi_inst/fifo_matrix_tx_addra[12]} {top_axi_inst/fifo_matrix_tx_addra[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 14 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {top_axi_inst/port_inst_1/tx_len_in[0]} {top_axi_inst/port_inst_1/tx_len_in[1]} {top_axi_inst/port_inst_1/tx_len_in[2]} {top_axi_inst/port_inst_1/tx_len_in[3]} {top_axi_inst/port_inst_1/tx_len_in[4]} {top_axi_inst/port_inst_1/tx_len_in[5]} {top_axi_inst/port_inst_1/tx_len_in[6]} {top_axi_inst/port_inst_1/tx_len_in[7]} {top_axi_inst/port_inst_1/tx_len_in[8]} {top_axi_inst/port_inst_1/tx_len_in[9]} {top_axi_inst/port_inst_1/tx_len_in[10]} {top_axi_inst/port_inst_1/tx_len_in[11]} {top_axi_inst/port_inst_1/tx_len_in[12]} {top_axi_inst/port_inst_1/tx_len_in[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 14 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {top_axi_inst/port_inst_1/fifo_matrix_tx_length[0]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[1]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[2]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[3]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[4]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[5]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[6]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[7]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[8]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[9]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[10]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[11]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[12]} {top_axi_inst/port_inst_1/fifo_matrix_tx_length[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 8 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {top_axi_inst/port_inst_1/tx_data_in[0]} {top_axi_inst/port_inst_1/tx_data_in[1]} {top_axi_inst/port_inst_1/tx_data_in[2]} {top_axi_inst/port_inst_1/tx_data_in[3]} {top_axi_inst/port_inst_1/tx_data_in[4]} {top_axi_inst/port_inst_1/tx_data_in[5]} {top_axi_inst/port_inst_1/tx_data_in[6]} {top_axi_inst/port_inst_1/tx_data_in[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 3 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {top_axi_inst/port_inst_1/fifo_matrix_tx_index[0]} {top_axi_inst/port_inst_1/fifo_matrix_tx_index[1]} {top_axi_inst/port_inst_1/fifo_matrix_tx_index[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 14 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {top_axi_inst/port_inst_0/fifo_matrix_tx_length[0]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[1]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[2]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[3]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[4]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[5]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[6]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[7]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[8]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[9]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[10]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[11]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[12]} {top_axi_inst/port_inst_0/fifo_matrix_tx_length[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 3 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {top_axi_inst/port_inst_0/fifo_matrix_tx_index[0]} {top_axi_inst/port_inst_0/fifo_matrix_tx_index[1]} {top_axi_inst/port_inst_0/fifo_matrix_tx_index[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list top_axi_inst/port_inst_0/fifo_matrix_tx_last_wlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list top_axi_inst/port_inst_1/fifo_matrix_tx_last_wlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list top_axi_inst/fifo_matrix_tx_progress]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list top_axi_inst/port_inst_1/fifo_matrix_tx_progress]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list top_axi_inst/port_inst_0/fifo_matrix_tx_progress]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list top_axi_inst/fifo_matrix_tx_wea]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list top_axi_inst/os_txd_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list top_axi_inst/os_txd_tready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list top_axi_inst/os_txd_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list top_axi_inst/port_inst_1/tx_data_busy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list top_axi_inst/port_inst_0/tx_data_busy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list top_axi_inst/port_inst_0/tx_data_full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list top_axi_inst/port_inst_1/tx_data_full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list top_axi_inst/port_inst_0/tx_data_wen]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list top_axi_inst/port_inst_1/tx_data_wen]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list top_axi_inst/port_inst_0/tx_len_busy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list top_axi_inst/port_inst_1/tx_len_busy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list top_axi_inst/port_inst_0/tx_len_full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list top_axi_inst/port_inst_1/tx_len_full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list top_axi_inst/port_inst_0/tx_len_wen]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list top_axi_inst/port_inst_1/tx_len_wen]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list top_axi_inst/port_inst_0/tri_mode_ethernet_mac_0_inst/inst/tri_mode_ethernet_mac_support_clocking_i/gtx_clk_out]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 8 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {top_axi_inst/port_inst_0/tx_data_out[0]} {top_axi_inst/port_inst_0/tx_data_out[1]} {top_axi_inst/port_inst_0/tx_data_out[2]} {top_axi_inst/port_inst_0/tx_data_out[3]} {top_axi_inst/port_inst_0/tx_data_out[4]} {top_axi_inst/port_inst_0/tx_data_out[5]} {top_axi_inst/port_inst_0/tx_data_out[6]} {top_axi_inst/port_inst_0/tx_data_out[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 14 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list {top_axi_inst/port_inst_0/tx_len_out[0]} {top_axi_inst/port_inst_0/tx_len_out[1]} {top_axi_inst/port_inst_0/tx_len_out[2]} {top_axi_inst/port_inst_0/tx_len_out[3]} {top_axi_inst/port_inst_0/tx_len_out[4]} {top_axi_inst/port_inst_0/tx_len_out[5]} {top_axi_inst/port_inst_0/tx_len_out[6]} {top_axi_inst/port_inst_0/tx_len_out[7]} {top_axi_inst/port_inst_0/tx_len_out[8]} {top_axi_inst/port_inst_0/tx_len_out[9]} {top_axi_inst/port_inst_0/tx_len_out[10]} {top_axi_inst/port_inst_0/tx_len_out[11]} {top_axi_inst/port_inst_0/tx_len_out[12]} {top_axi_inst/port_inst_0/tx_len_out[13]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 8 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list {top_axi_inst/port_inst_1/tx_data_out[0]} {top_axi_inst/port_inst_1/tx_data_out[1]} {top_axi_inst/port_inst_1/tx_data_out[2]} {top_axi_inst/port_inst_1/tx_data_out[3]} {top_axi_inst/port_inst_1/tx_data_out[4]} {top_axi_inst/port_inst_1/tx_data_out[5]} {top_axi_inst/port_inst_1/tx_data_out[6]} {top_axi_inst/port_inst_1/tx_data_out[7]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe3]
set_property port_width 14 [get_debug_ports u_ila_1/probe3]
connect_debug_port u_ila_1/probe3 [get_nets [list {top_axi_inst/port_inst_1/tx_len_out[0]} {top_axi_inst/port_inst_1/tx_len_out[1]} {top_axi_inst/port_inst_1/tx_len_out[2]} {top_axi_inst/port_inst_1/tx_len_out[3]} {top_axi_inst/port_inst_1/tx_len_out[4]} {top_axi_inst/port_inst_1/tx_len_out[5]} {top_axi_inst/port_inst_1/tx_len_out[6]} {top_axi_inst/port_inst_1/tx_len_out[7]} {top_axi_inst/port_inst_1/tx_len_out[8]} {top_axi_inst/port_inst_1/tx_len_out[9]} {top_axi_inst/port_inst_1/tx_len_out[10]} {top_axi_inst/port_inst_1/tx_len_out[11]} {top_axi_inst/port_inst_1/tx_len_out[12]} {top_axi_inst/port_inst_1/tx_len_out[13]}]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe4]
set_property port_width 1 [get_debug_ports u_ila_1/probe4]
connect_debug_port u_ila_1/probe4 [get_nets [list top_axi_inst/port_inst_0/tx_data_ren]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe5]
set_property port_width 1 [get_debug_ports u_ila_1/probe5]
connect_debug_port u_ila_1/probe5 [get_nets [list top_axi_inst/port_inst_1/tx_data_ren]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe6]
set_property port_width 1 [get_debug_ports u_ila_1/probe6]
connect_debug_port u_ila_1/probe6 [get_nets [list top_axi_inst/port_inst_0/tx_len_empty]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe7]
set_property port_width 1 [get_debug_ports u_ila_1/probe7]
connect_debug_port u_ila_1/probe7 [get_nets [list top_axi_inst/port_inst_1/tx_len_empty]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe8]
set_property port_width 1 [get_debug_ports u_ila_1/probe8]
connect_debug_port u_ila_1/probe8 [get_nets [list top_axi_inst/port_inst_1/tx_len_ren]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe9]
set_property port_width 1 [get_debug_ports u_ila_1/probe9]
connect_debug_port u_ila_1/probe9 [get_nets [list top_axi_inst/port_inst_0/tx_len_ren]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_1_gtx_clk_out]
