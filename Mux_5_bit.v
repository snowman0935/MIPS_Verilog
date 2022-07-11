module Mux_5_bit(In1, In2, Out, Sel);
	parameter S = 4;
    input [S:0] In1, In2;
    input Sel;
    output reg [S:0] Out;
	
	always @(Sel or In1 or In2) 
	begin    
    		case (Sel)
        		0 : Out = In1;
        		1 : Out = In2;
    		endcase
	end
endmodule
