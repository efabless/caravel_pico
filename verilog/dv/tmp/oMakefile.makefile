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
#
# SPDX-License-Identifier: Apache-2.0


include ../../make/env.makefile
include ../../make/var.makefile
include ../../make/cpu.makefile
#include ../../../make/sim.makefile


#BLOCKS := $(wildcard *)


BLOCKS = $(shell find * -maxdepth 1 -type d)
CLEAN = $(foreach block,$(BLOCKS), clean-$(block))

  
.PHONY: blocks $(BLOCKS)

AA:= $(wildcard *)/$(wildcard *.vcd) 

all: $(BLOCKS)

$(BLOCKS) : % : ./%/$(wildcard */*.vcd)
	@echo $*
	
#$(BLOCKS) : % : ./%/$(*.vcd)

##$(BLOCKS) : % : ./%/config.tcl FORCE

%.elf: %.c $(LINKER_SCRIPT) $(SOURCE_FILES) 
	${GCC_PATH}/${GCC_PREFIX}-gcc -I$(FIRMWARE_PATH) -march=rv32imc -mabi=ilp32 \
	-Wl,-Bstatic,-T,$(LINKER_SCRIPT),--strip-debug \
	-ffreestanding -nostdlib -o $@ $(SOURCE_FILES) $<
	
%.hex: %.elf
	${GCC_PATH}/${GCC_PREFIX}-objcopy -O verilog $< $@ 
	# to fix flash base address
	sed -i 's/@10000000/@00000000/g' $@

%.bin: %.elf
	${GCC_PATH}/${GCC_PREFIX}-objcopy -O binary $< /dev/stdout | tail -c +1048577 > $@

%.vvp: %_tb.v %.hex
ifeq ($(SIM),RTL)
	iverilog -Ttyp $(SIM_DEFINES) -I $(VIP_PATH) \
	-I $(PDK_PATH) -I $(RTL_PATH) -I $(COMMON) -I $(CARAVEL_VERILOG_PATH)/rtl \
	$< -o $@ 
endif 
ifeq ($(SIM),GL)
	iverilog -Ttyp $(SIM_DEFINES) -DGL -I $(VIP_PATH) \
	-I $(PDK_PATH) -I $(RTL_PATH) -I $(COMMON) -I $(CARAVEL_VERILOG_PATH)/rtl \
	$< -o $@ 
endif 
ifeq ($(SIM),GL_SDF)
	$(eval VIP_PATH := $(shell realpath --relative-to=$(shell pwd) $(VIP_PATH)))
	$(eval PDK_ABSOLUTE_PATH := $(shell realpath --relative-to=$(shell pwd) $(PDK_PATH)))
	$(eval RTL_ABSOLUTE_PATH := $(shell realpath --relative-to=$(shell pwd) $(RTL_PATH)))
	$(eval VERILOG_ABSOLUTE_PATH := $(shell realpath --relative-to=$(shell pwd) $(VERILOG_PATH)))
	$(eval CURRENT_DIRECTORY := $(shell pwd))
	cvc +interp +incdir+$(VIP_PATH)+$(RTL_ABSOLUTE_PATH)+$(VERILOG_ABSOLUTE_PATH)+$(PDK_ABSOLUTE_PATH)+$(CURRENT_DIRECTORY) \
	    +define+FUNCTIONAL +define+SIM +define+GL +define+USE_POWER_PINS +define+ENABLE_SDF +change_port_type +dump2fst $<
endif

%.vcd : %.vvp
	vvp $<



check-env:
ifndef PDK_ROOT
	$(error PDK_ROOT is undefined, please export it before running make)
endif
ifeq (,$(wildcard $(PDK_ROOT)/sky130A))
	$(error $(PDK_ROOT)/sky130A not found, please install pdk before running make)
endif
ifeq (,$(wildcard $(GCC_PATH)/$(GCC_PREFIX)-gcc ))
	$(error $(GCC_PATH)/$(GCC_PREFIX)-gcc is not found, please export GCC_PATH and GCC_PREFIX before running make)
endif
# check for efabless style installation
ifeq (,$(wildcard $(PDK_ROOT)/sky130A/libs.ref/*/verilog))
SIM_DEFINES := ${SIM_DEFINES} -DEF_STYLE
endif


# ---- Clean ----

clean:
	rm -f *.elf *.hex *.bin *.vvp *.vcd *.log

.PHONY: clean hex all


#ifeq ($(PDK_ROOT),)
#	@echo "Please export PDK_ROOT"
#	@exit 1
#endif


	
	
	
		