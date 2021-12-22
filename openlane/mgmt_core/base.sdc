## MASTER CLOCKS
create_clock [get_ports $::env(CLOCK_PORT)]  -name $::env(CLOCK_PORT)  -period $::env(CLOCK_PERIOD)

## FALSE PATHS
set_false_path -from [get_port $::env(RESET_PORT)]

## INPUT/OUTPUT DELAYS
set input_delay_value [expr $::env(CLOCK_PERIOD) * $::env(IO_PCT)]
set output_delay_value [expr $::env(CLOCK_PERIOD) * $::env(IO_PCT)]
puts "\[INFO\]: Setting output delay to: $output_delay_value"
puts "\[INFO\]: Setting input delay to: $input_delay_value"

## DFFRAM INPUTS
set mem_rdata_0_delay 2.99 
set mem_rdata_1_delay 3.03
set mem_rdata_2_delay 3.02
set mem_rdata_3_delay 2.99
set mem_rdata_4_delay 2.66
set mem_rdata_5_delay 2.97
set mem_rdata_6_delay 3.03
set mem_rdata_7_delay 2.99
set mem_rdata_8_delay 3.08
set mem_rdata_9_delay 3.08
set mem_rdata_10_delay 3.08
set mem_rdata_11_delay 3.03
set mem_rdata_12_delay 3.02
set mem_rdata_13_delay 3.02
set mem_rdata_14_delay 3.01
set mem_rdata_15_delay 3.04
set mem_rdata_16_delay 2.85
set mem_rdata_17_delay 2.85
set mem_rdata_18_delay 2.85
set mem_rdata_19_delay 2.87
set mem_rdata_20_delay 2.88
set mem_rdata_21_delay 2.87
set mem_rdata_22_delay 2.9
set mem_rdata_23_delay 2.91
set mem_rdata_24_delay 3.02
set mem_rdata_25_delay 3.02
set mem_rdata_26_delay 3.02
set mem_rdata_27_delay 3.01
set mem_rdata_28_delay 3.08
set mem_rdata_29_delay 3.06
set mem_rdata_30_delay 3.09
set mem_rdata_31_delay 3.09

set_input_delay $mem_rdata_0_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[0]]
set_input_delay $mem_rdata_1_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[1]]
set_input_delay $mem_rdata_2_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[2]]
set_input_delay $mem_rdata_3_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[3]]
set_input_delay $mem_rdata_4_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[4]]
set_input_delay $mem_rdata_5_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[5]]
set_input_delay $mem_rdata_6_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[6]]
set_input_delay $mem_rdata_7_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[7]]
set_input_delay $mem_rdata_8_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[8]]
set_input_delay $mem_rdata_9_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[9]]
set_input_delay $mem_rdata_10_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[10]]
set_input_delay $mem_rdata_11_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[11]]
set_input_delay $mem_rdata_12_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[12]]
set_input_delay $mem_rdata_13_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[13]]
set_input_delay $mem_rdata_14_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[14]]
set_input_delay $mem_rdata_15_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[15]]
set_input_delay $mem_rdata_16_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[16]]
set_input_delay $mem_rdata_17_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[17]]
set_input_delay $mem_rdata_18_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[18]]
set_input_delay $mem_rdata_19_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[19]]
set_input_delay $mem_rdata_20_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[20]]
set_input_delay $mem_rdata_21_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[21]]
set_input_delay $mem_rdata_22_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[22]]
set_input_delay $mem_rdata_23_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[23]]
set_input_delay $mem_rdata_24_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[24]]
set_input_delay $mem_rdata_25_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[25]]
set_input_delay $mem_rdata_26_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[26]]
set_input_delay $mem_rdata_27_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[27]]
set_input_delay $mem_rdata_28_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[28]]
set_input_delay $mem_rdata_29_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[29]]
set_input_delay $mem_rdata_30_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[30]]
set_input_delay $mem_rdata_31_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_port mem_rdata[31]]

## HK INPUTS 
set hk_min_input_delay 1 
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports irq[*]]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports flash_io0_di]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports flash_io1_di]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports flash_io2_di]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports flash_io3_di]
set_input_delay 1.85 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports hk_dat_i[*]]
set_input_delay 1.85 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports hk_ack_i]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports ser_rx]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports spi_sdi]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports debug_in]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports sram_ro_clk]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports sram_ro_csb]
set_input_delay $hk_min_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports sram_ro_addr[*]]


## USER PROJECT WRAPPER INPUTS
set user_input_delay 1 
set_input_delay $user_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports la_input[*]]
set_input_delay $user_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports mprj_ack_i]
set_input_delay $user_input_delay -clock [get_clocks $::env(CLOCK_PORT)] [get_ports mprj_dat_i[*]]

## PADFRAME INPUTS
set padframe_input_delay 1 
set_input_delay $padframe_input_delay  -clock [get_clocks $::env(CLOCK_PORT)] [get_ports gpio_in_pad]

## OUTPUT DELAYS
#set_output_delay $output_delay_value  -clock [get_clocks $::env(CLOCK_PORT)] [all_outputs]

set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {debug_mode}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {debug_oeb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {debug_out}]

set flash_output_delay 15 
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_clk}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_csb}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io0_do}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io0_oeb}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io1_do}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io1_oeb}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io2_do}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io2_oeb}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io3_do}]
set_output_delay $flash_output_delay -clock [get_clocks {core_clk}] -add_delay [get_ports {flash_io3_oeb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_inenb_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_mode0_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_mode1_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_out_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {gpio_outenb_pad}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {hk_cyc_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {hk_stb_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {la_iena[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {la_oenb[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {la_output[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mem_addr[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mem_wdata[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mem_ena}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mem_wen[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_adr_o[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_cyc_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_dat_o[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_sel_o[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_stb_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_wb_iena}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {mprj_we_o}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {qspi_enabled}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {ser_tx}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_sck}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_csb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_enabled}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_sdo}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {spi_sdoenb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {sram_ro_addr[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {sram_ro_clk}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {sram_ro_csb}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {sram_ro_data[*]}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {trap}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {uart_enabled}]
set_output_delay $output_delay_value -clock [get_clocks {core_clk}] -add_delay [get_ports {user_irq_ena[*]}]

## INPUT DRIVER
set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINITY)"
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks $::env(CLOCK_PORT)]

puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks $::env(CLOCK_PORT)]

puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 10}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]
