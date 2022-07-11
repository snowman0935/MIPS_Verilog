module Instruction_Memory(A, RD);
	input [31:0] A;
	output reg [31:0] RD;
	reg [7:0] Memory[0:59];
	initial
		$readmemb("init.dat",Memory);
	
	always @(A)
	begin			//Read 4 lines from the instruction memory
		RD={Memory[A],Memory[A+1],Memory[A+2],Memory[A+3]};
	end
endmodule
