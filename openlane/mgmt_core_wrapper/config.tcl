# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

set script_dir [file dirname [file normalize [info script]]]

set ::env(ROUTING_CORES) "6"

set ::env(DESIGN_NAME) mgmt_core_wrapper

set ::env(DESIGN_IS_CORE) 1

set ::env(RUN_KLAYOUT) 0

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) ""
set ::env(CLOCK_PERIOD) "25"

set ::env(SYNTH_STRATEGY) "DELAY 1"
set ::env(SYNTH_MAX_FANOUT) 6

set ::env(CTS_SINK_CLUSTERING_MAX_DIAMETER) "20"
set ::env(CTS_SINK_CLUSTERING_SIZE) "8"

set ::env(FP_PDN_VPITCH) 50
set ::env(FP_PDN_HPITCH) 130


set ::env(FP_PDN_CHECK_NODES) 0
set ::env(FP_PDN_IRDROP) 0

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2900 800"

set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro_placement.cfg
set ::env(PL_TARGET_DENSITY) 0.18
set ::env(CELL_PAD) 0

# Disable resizer design optimizations to prevent adding a buffer after tristate cells
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0

set ::env(GLB_RT_ADJUSTMENT) 0
set ::env(GLB_RT_L2_ADJUSTMENT) 0.31
set ::env(GLB_RT_L3_ADJUSTMENT) 0.31
set ::env(GLB_RT_L4_ADJUSTMENT) 0.21
set ::env(GLB_RT_L5_ADJUSTMENT) 0.21
set ::env(GLB_RT_L6_ADJUSTMENT) 0.1
set ::env(GLB_RT_ALLOW_CONGESTION) 1
set ::env(GLB_RT_OVERFLOW_ITERS) 200

set ::env(GLB_RT_OBS) "\
   met5 20 20 570 760, \
   met4 20 20 570 760"

set ::env(FP_PDN_ENABLE_RAILS) 0

set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(FILL_INSERTION) 0
set ::env(TAP_DECAP_INSERTION) 0
set ::env(CLOCK_TREE_SYNTH) 0

# magic drc checking on the sram block shows millions of false errors
set ::env(MAGIC_DRC_USE_GDS) 0

set ::env(QUIT_ON_LVS_ERROR) "0"

set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/defines.v\
	$script_dir/../../verilog/rtl/mgmt_core_wrapper.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
	$script_dir/../../verilog/rtl/defines.v\
	$script_dir/../../verilog/rtl/mgmt_core.v\
	$script_dir/../../verilog/rtl/DFFRAM.v"

set ::env(EXTRA_LEFS) "\
	$script_dir/../../lef/DFFRAM.lef
	$script_dir/../../lef/mgmt_core.lef"

set ::env(EXTRA_GDS_FILES) "\
	$script_dir/../../gds/mgmt_core.gds
	$script_dir/../../gds/DFFRAM.gds"

