read_liberty sky130_fd_sc_hd__tt_025C_1v80.lib
read_liberty sram_32_256_sky130A_TT_1p8V_25C.lib
read_verilog vsdmemsoc.synth.v
link_design vsdmemsoc
set_units  -time ns
read_sdc memsoc.sdc
report_checks -path_delay min -group_count 1000 -endpoint_count 1000 -unique_paths_to_endpoint -fields {nets cap slew input_pins}
report_checks -path_delay max -group_count 1000 -endpoint_count 1000 -unique_paths_to_endpoint -fields {nets cap slew input_pins}
report_worst_slack -min
report_worst_slack -max



