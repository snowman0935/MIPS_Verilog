module ALU(SrcA, SrcB, ALUSec, ALU_result, Zero);
	input [31:0] SrcA;
	input [31:0] SrcB;
	input [2:0] ALUSec;

	output reg [31:0] ALU_result;
	output reg Zero;

	always @(SrcA or SrcB or ALUSec) begin
		Zero=0;
		if(ALUSec==0) begin				//And
			ALU_result=SrcA & SrcB;
		end
		if(ALUSec==1) begin				//Or
			ALU_result=SrcA | SrcB;
		end
		if(ALUSec==2) begin				//Add
			ALU_result=SrcA+SrcB;
		end
		if(ALUSec==3) begin				//Subtract
			ALU_result=SrcA-SrcB;
			if(ALU_result==0) begin		//Beq
				Zero<=1;
			end
			else begin
				Zero<=0;
			end
		end
		if(ALUSec==4) begin				//Set on less than
			if(SrcA<SrcB) begin
				ALU_result <= 1;
			end
			if(SrcA>=SrcB) begin
				ALU_result <= 0;
			end
		end
	end
endmodule
