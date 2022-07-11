module ALU_control_unit(ALU_Op, Function, ALU_control);
	input [1:0] ALU_Op;
	input [5:0] Function;
	output reg[2:0] ALU_control;

	always @(ALU_Op or Function)
	begin
		if(ALU_Op==0) begin				//Load Word
			ALU_control=2;
		end
		if(ALU_Op==1) begin				//BEQ
			ALU_control=3;
		end
		if(ALU_Op==2) begin				//R-Instructions
			if(Function==32) begin		//Add
				ALU_control=2;
			end
			if(Function==34) begin		//sub
				ALU_control=3;
			end
			if(Function==36) begin		//And
				ALU_control=0;
			end
			if(Function==37) begin		//Or	
				ALU_control=1;
			end
			if(Function==42) begin		//Set on less than
				ALU_control=4;
			end
		end
	end
endmodule



