module Data_memory(A, WD, WE, RD);
	input [31:0]A,WD;
	input WE;
	output reg [31:0]RD;
	reg [7:0]Memory[0:1];
	initial
        	$readmemb("init_data_mem.dat",Memory);
	always @(A or WD or WE) begin
		if(WE==1'b0) begin				//Read 4 consecutive lines from the memory
			Memory[A]=WD[7:0];
			Memory[A+1]=WD[15:8];
			Memory[A+2]=WD[23:16];
			Memory[A+3]=WD[31:24];
		end
		if(WE==1'b1) begin				//Write 4 consecutive line in the memory
			RD={Memory[A],Memory[A+1],Memory[A+2],Memory[A+3]};
		end
	end
endmodule

