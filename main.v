`timescale 1ns/1ps
`include "Mips.v"

//This Mips processor is based on the slides discussed in the class

//main contains the clock and calls the module Mips
//All the modules and connections are initialised in Mips.v

module main(clk);
	output reg clk = 0;
	Mips uut (
    		.clk(clk)
	);

	always #5 clk = ~ clk;
	initial begin 
		$dumpfile("Mips.vcd");
		$dumpvars(0,main);
	end    
endmodule
