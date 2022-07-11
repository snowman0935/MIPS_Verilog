module Registers(A1, A2, A3, WD3, RD1, RD2, WE3);
	input [4:0] A1, A2, A3;
	input [31:0] WD3;
	input WE3;
	output reg [31:0] RD1, RD2;
	reg [31:0] Reg[0:31];
	reg [4:0] count;
	integer i;

	initial begin				//initalising all the registers to 0
  		count=0;
  		for (i=0;i<=31;i=i+1)
    			Reg[i]=0;
	end
	always @(A1 or A2 or A3 or WD3 or WE3)
	begin
		RD1=Reg[A1];
		RD2=Reg[A2];
		if (WE3 == 0)	begin
			Reg[A3]<=WD3;
		end
	end
endmodule
