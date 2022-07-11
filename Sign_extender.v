module Sign_extender (In, Out, Clk);
	input [15:0] In;
    	input Clk;
	output [31:0] Out;
    	assign Out = $signed(In);    
endmodule
