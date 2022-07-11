module Control_unit(Op, Mem_reg, Mem_write, Branch, ALU_Op, ALU_src, Reg_dst, Reg_write, Jump, Clk);
	input [5:0] Op;
    	input Clk;
    	output reg Mem_reg, Mem_write, Branch, ALU_src, Reg_dst, Reg_write, Jump;
    	output reg [1:0] ALU_Op;
	
    	always @(Op or posedge Clk)

	//more instructions can be added below

	begin					
        case(Op)
        6'b000000:                //R-instructions
        begin
            	Reg_dst=1;
            	ALU_src=0;
            	Mem_reg=0;
            	Reg_write=0;
            	Mem_write=0;
            	Branch=0;
            	ALU_Op=2;
            	Jump=0;
        end
        6'b001000:				//Addi- I instruction
        begin
            	Reg_dst=0;
            	ALU_src=1;
            	Mem_reg=0;
            	Reg_write=0;
            	Mem_write=0;
           	Branch=0;
            	ALU_Op=0;
            	Jump=0;
        end
        6'b100011:             //Load Word
        begin
            	Reg_dst=0;
            	ALU_src=1;
            	Mem_reg=1;
            	Reg_write=0;
            	Mem_write=0;
            	Branch=0;
            	ALU_Op=0;
            	Jump=0;
        end
        6'b101011:             //Store Word
        begin
            	Reg_dst=0;
            	ALU_src=1;
            	Mem_reg=0;
            	Reg_write=1;
            	Mem_write=1;
            	Branch=0;
            	ALU_Op=0;
            	Jump=0;
        end
        6'b000100:             //BEQ
        begin
            	Reg_dst=0;
            	ALU_src=0;
            	Mem_reg=0;
            	Reg_write=1;
            	Mem_write=1;
            	Branch=1;
            	ALU_Op=1;
            	Jump=0;
        end
        6'b000010:             //Jump
        begin
            	Reg_dst=0;
            	ALU_src=0;
            	Mem_reg=0;
            	Reg_write=1;
            	Mem_write=0;
            	Branch=0;
            	ALU_Op=0;
            	Jump=1;
        end
        endcase
    end
endmodule
