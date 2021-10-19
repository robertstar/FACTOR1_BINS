# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a100tfgg676-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/vladimir/FACTOR2_bins/project_led.cache/wt [current_project]
set_property parent.project_path /home/vladimir/FACTOR2_bins/project_led.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/vladimir/FACTOR2_bins/project_led.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/UART_RX.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/ad9850.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/crc.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/events.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/mac.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/ram_adc.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/ram_dual2.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/ram_dual_v.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/rs485.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/rs485_bins.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/uart_rx_dfs.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/uart_tx_bins.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/uart_tx_dfs.sv
  /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/new/factor.sv
}
read_ip -quiet /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/pll/pll.xci
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/pll/pll_board.xdc]
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/pll/pll.xdc]
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/pll/pll_ooc.xdc]

read_ip -quiet /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_ser/fifo_ser.xci
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_ser/fifo_ser.xdc]
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_ser/fifo_ser_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_ser/fifo_ser_ooc.xdc]

read_ip -quiet /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_arp/fifo_arp.xci
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_arp/fifo_arp.xdc]
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_arp/fifo_arp_ooc.xdc]

read_ip -quiet /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_apo/fifo_apo.xci
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_apo/fifo_apo.xdc]
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_apo/fifo_apo_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/vladimir/FACTOR2_bins/project_led.srcs/sources_1/ip/fifo_apo/fifo_apo_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/vladimir/FACTOR2_bins/project_led.srcs/constrs_1/new/LED.xdc
set_property used_in_implementation false [get_files /home/vladimir/FACTOR2_bins/project_led.srcs/constrs_1/new/LED.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top factor -part xc7a100tfgg676-2 -flatten_hierarchy none -bufg 20 -fanout_limit 50000 -directive RuntimeOptimized


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef factor.dcp
create_report "synth_5_synth_report_utilization_0" "report_utilization -file factor_utilization_synth.rpt -pb factor_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
