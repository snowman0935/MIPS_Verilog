module PC(In, Out, Clk);
    	input [31:0] In;
    	input Clk;
    	output reg[31:0] Out;
		reg [31:0] PC = 0;
    	reg count = 0;
	always @(posedge Clk)
	begin
    		PC = In;
    		if (count == 0)	begin
        		Out = 0;				//initally PC is set to zero
        		count = 1;
    		end
    		else begin
    			Out = PC;        
    		end
	end    
endmodule
