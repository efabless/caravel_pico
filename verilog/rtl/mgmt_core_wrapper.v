`default_nettype none
/*
 *  SPDX-FileCopyrightText: 2015 Clifford Wolf
 *  PicoSoC - A simple example SoC using PicoRV32
 *
 *  Copyright (C) 2017  Clifford Wolf <clifford@clifford.at>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *  Revision 1,  July 2019:  Added signals to drive flash_clk and flash_csb
 *  output enable (inverted), tied to reset so that the flash is completely
 *  isolated from the processor when the processor is in reset.
 *
 *  Also: Made ram_wenb a 4-bit bus so that the memory access can be made
 *  byte-wide for byte-wide instructions.
 *
 *  SPDX-License-Identifier: ISC
 */

`ifndef _MGMT_CORE_WRAPPER_
`define _MGMT_CORE_WRAPPER_

/* Wrapper module around management SoC core for pin compatibility	*/
/* with the Caravel harness chip.					*/

`include "storage.v"
`include "DFFRAM.v"
`include "DFFRAMBB.v"
`include "sram_1rw1r_32_256_8_sky130.v"
`include "storage_bridge_wb.v"
`include "gpio_wb.v"
`include "mgmt_core.v"

module mgmt_core_wrapper (
`ifdef USE_POWER_PINS
    inout VPWR,	    /* 1.8V domain */
    inout VGND,
`endif
    // Clock and reset
    input core_clk,
    input core_rstn,

    // GPIO (one pin)
    output gpio_out_pad,	// Connect to out on gpio pad
    input  gpio_in_pad,		// Connect to in on gpio pad
    output gpio_mode0_pad,	// Connect to dm[0] on gpio pad
    output gpio_mode1_pad,	// Connect to dm[2] on gpio pad
    output gpio_outenb_pad,	// Connect to oe_n on gpio pad
    output gpio_inenb_pad,	// Connect to inp_dis on gpio pad

    // Logic analyzer signals
    input  [127:0] la_input,            // From user project to CPU
    output [127:0] la_output,           // From CPU to user project
    output [127:0] la_oenb,             // Logic analyzer output enable
    output [127:0] la_iena,             // Logic analyzer input enable

    // Flash memory control (SPI master)
    output flash_csb,
    output flash_clk,

    output flash_io0_oeb,
    output flash_io1_oeb,
    output flash_io2_oeb,
    output flash_io3_oeb,

    output flash_io0_do,
    output flash_io1_do,
    output flash_io2_do,
    output flash_io3_do,

    input  flash_io0_di,
    input  flash_io1_di,
    input  flash_io2_di,
    input  flash_io3_di,

    // Exported Wishboned bus
    output 	  mprj_cyc_o,
    output 	  mprj_stb_o,
    output 	  mprj_we_o,
    output [3:0]  mprj_sel_o,
    output [31:0] mprj_adr_o,
    output [31:0] mprj_dat_o,
    input  	  mprj_ack_i,
    input  [31:0] mprj_dat_i,

    output 	  hk_stb_o,
    input  [31:0] hk_dat_i,
    input  	  hk_ack_i,

    // IRQ
    input  [5:0] irq,		// IRQ from SPI and user project

    // Module status
    output qspi_enabled,
    output uart_enabled,
    output spi_enabled,
    output debug_mode,

    // Module I/O
    output ser_tx,
    input  ser_rx,
    output spi_csb,
    output spi_sck,
    output spi_sdo,
    output spi_sdoenb,
    input  spi_sdi,
    input  debug_in,
    output debug_out,
    output debug_oeb,

    // SRAM read-only access from housekeeping
    input sram_ro_clk,
    input sram_ro_csb,
    input [7:0] sram_ro_addr,
    output [31:0] sram_ro_data,

    // Trap state from CPU
    output trap
);

    wire [`RAM_BLOCKS-1:0] mgmt_ena;
    wire [(`RAM_BLOCKS*4)-1:0] mgmt_wen_mask;
    wire [`RAM_BLOCKS-1:0] mgmt_wen;
    wire [7:0] mgmt_addr;
    wire [31:0] mgmt_wdata;
    wire [(`RAM_BLOCKS*32)-1:0] mgmt_rdata;

    wire mgmt_ena_ro;
    wire [7:0] mgmt_addr_ro;
    wire [31:0] mgmt_rdata_ro;

    /* Implement the PicoSoC core */

    mgmt_core core (
	`ifdef USE_POWER_PINS
	    .vdd(VPWR),	    /* 1.8V domain */
	    .vss(VGND),
	`endif
    	.clk(core_clk),
    	.resetn(core_rstn),

    	// Trap state from CPU
    	.trap(trap),

    	// GPIO (one pin)
    	.gpio_out_pad(gpio_out_pad),		// Connect to out on gpio pad
    	.gpio_in_pad(gpio_in_pad),		// Connect to in on gpio pad
    	.gpio_mode0_pad(gpio_mode0_pad),	// Connect to dm[0] on gpio pad
    	.gpio_mode1_pad(gpio_mode1_pad),	// Connect to dm[2] on gpio pad
    	.gpio_outenb_pad(gpio_outenb_pad),	// Connect to oe_n on gpio pad
    	.gpio_inenb_pad(gpio_inenb_pad),	// Connect to inp_dis on gpio pad

	.la_input(la_input),			// From user project to CPU
	.la_output(la_output),			// From CPU to user project
	.la_oenb(la_oenb),			// Logic analyzer output enable
	.la_iena(la_iena),			// Logic analyzer input enable

        // IRQ
        .irq(irq),		// IRQ from SPI and user project

        // Flash memory control (SPI master)
        .flash_csb(flash_csb),
        .flash_clk(flash_clk),

        .flash_io0_oeb(flash_io0_oeb),
        .flash_io1_oeb(flash_io1_oeb),
        .flash_io2_oeb(flash_io2_oeb),
        .flash_io3_oeb(flash_io3_oeb),

        .flash_io0_do(flash_io0_do),
        .flash_io1_do(flash_io1_do),
        .flash_io2_do(flash_io2_do),
        .flash_io3_do(flash_io3_do),

        .flash_io0_di(flash_io0_di),
        .flash_io1_di(flash_io1_di),
        .flash_io2_di(flash_io2_di),
        .flash_io3_di(flash_io3_di),

        // WB MI A (User project)
        .mprj_ack_i(mprj_ack_i),
        .mprj_dat_i(mprj_dat_i),
        .mprj_cyc_o(mprj_cyc_o),
        .mprj_stb_o(mprj_stb_o),
        .mprj_we_o(mprj_we_o),
        .mprj_sel_o(mprj_sel_o),
        .mprj_adr_o(mprj_adr_o),
        .mprj_dat_o(mprj_dat_o),

	.hk_stb_o(hk_stb_o),
	.hk_dat_i(hk_dat_i),
	.hk_ack_i(hk_ack_i),

    	// Module status
    	.qspi_enabled(qspi_enabled),
    	.uart_enabled(uart_enabled),
    	.spi_enabled(spi_enabled),
    	.debug_mode(debug_mode),

    	// Module I/O
    	.ser_tx(ser_tx),
    	.ser_rx(ser_rx),
    	.spi_csb(spi_csb),
    	.spi_sck(spi_sck),
    	.spi_sdo(spi_sdo),
    	.spi_sdoenb(spi_sdoenb),
    	.spi_sdi(spi_sdi),
    	.debug_in(debug_in),
    	.debug_out(debug_out),
    	.debug_oeb(debug_oeb),

        // MGMT area R/W interface for mgmt RAM
        .mgmt_ena(mgmt_ena), 
        .mgmt_wen_mask(mgmt_wen_mask),
        .mgmt_wen(mgmt_wen),
        .mgmt_addr(mgmt_addr),
        .mgmt_wdata(mgmt_wdata),
        .mgmt_rdata(mgmt_rdata),

        // MGMT area RO interface for user RAM 
        .mgmt_ena_ro(mgmt_ena_ro),
        .mgmt_addr_ro(mgmt_addr_ro),
        .mgmt_rdata_ro(mgmt_rdata_ro)
    );

    /* Storage (memory) area */

    storage storage(
        `ifdef USE_POWER_PINS
            .VPWR(VPWR),
            .VGND(VGND),
        `endif
        .mgmt_clk(core_clk),
        .mgmt_ena(mgmt_ena),
        .mgmt_wen(mgmt_wen),
        .mgmt_wen_mask(mgmt_wen_mask),
        .mgmt_addr(mgmt_addr),
        .mgmt_wdata(mgmt_wdata),
        .mgmt_rdata(mgmt_rdata),

        // Management RO interface
        .mgmt_ena_ro(mgmt_ena_ro),
        .mgmt_addr_ro(mgmt_addr_ro),
        .mgmt_rdata_ro(mgmt_rdata_ro),

	// Housekeeping read-only interface
	.sram_ro_clk(sram_ro_clk),
	.sram_ro_csb(sram_ro_csb),
	.sram_ro_addr(sram_ro_addr),
	.sram_ro_data(sram_ro_data)
    );

endmodule
`default_nettype wire

`endif
