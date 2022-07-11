`include "ALU.v"
`include "ALU_control_unit.v"
`include "Instruction_Memory.v"
`include "Registers.v"
`include "Data_Memory.v"
`include "Control_unit.v"
`include "Mux.v"
`include "Sign_extender.v"
`include "Mux_5_bit.v"
`include "PC.v"

module Mips(clk);
	wire Jump, PC_Src;          //Jump--PC_mux_2 switch, PC_Src--PC_mux_1_switch 
	wire [31:0] PC_jump, PC_branch, PC_mux_1_2; //PC_mux_1_2 between mux1 and mux 2
	wire [31:0] PC_1, PC_2; //to PC_reg, out PC_reg
	wire [31:0] PC_plus_4;  //for PC++, from adder
	wire [27:0] PC_slt;//after Instr & shift left to PC_jump
	wire [31:0] Instr;  //out Instr_mem
	wire [31:0] Sign_imm;   //After sign ext
	wire [31:0] Sign_imm_mux; //After let shift to mux
	//wires from Control unit
	wire Reg_write, Reg_dst, ALU_src, Branch, Mem_write, Mem_reg;
	wire [1:0] ALU_Op;
	wire [4:0] Write_reg;
	wire [2:0] ALU_control_wire;
	//wires from Reg_file
	wire [31:0] Src_A, Write_data;
	//wires for ALU
	wire Zero;
	wire [31:0] Src_B, ALU_result;
	//wires from Data memory
	wire [31:0] Read_data;
	//wire after Mem to Reg Mux
	wire [31:0] Result;
	input clk;
	reg [31:0] Reg;
	Instruction_Memory instr_mem_unit (
    		.A(PC_2),
    		.RD(Instr)
	);
	Registers register_file_unit (
    		.RD1(Src_A),                //3 inputs 
    		.RD2(Write_data),
    		.A3(Write_reg),      
    		.WE3(Reg_write),            //enable from control
    		.WD3(Result),               //data from alu/memory
    		.A1(Instr[25:21]),          //Reg to ALU
    		.A2(Instr[20:16])           //to ALU/memory
	);
	Control_unit control_unit (
    		.Op(Instr[31:26]),          //OP code        
    		.Mem_reg(Mem_reg),          //Mem to Register file mux
    		.Mem_write(Mem_write),      //Memory Enable
    		.Branch(Branch),            
    		.ALU_Op(ALU_Op),  	    //ALU control
    		.ALU_src(ALU_src),          //mux for regfile to alu/memory
    		.Reg_dst(Reg_dst),          //mux for A3 in reg file
    		.Reg_write(Reg_write),      //reg write enable
    		.Jump(Jump),                
    		.Clk(clk)
	);
	ALU_control_unit alu_control_unit (
    		.ALU_Op(ALU_Op),
    		.Function(Instr[5:0]),
    		.ALU_control(ALU_control_wire)
	);
	ALU alu_unit (
    		.SrcA(Src_A),           //input A for ALU
    		.SrcB(Src_B),           //input B for ALU
    		.ALUSec(ALU_control_wire),   //ALU Select
    		.Zero(Zero),            
    		.ALU_result(ALU_result)
	);
	Data_memory data_mem_unit (
    		.A(ALU_result),     //input from ALU
    		.WD(Write_data),    //input from Reg file
    		.WE(Mem_write),     //memory enable
    		.RD(Read_data)     //memory output
	);
	Sign_extender uut5 (
    		.In(Instr[15:0]),
    		.Out(Sign_imm)
	);
	//Mux_1 before PC 
	Mux uut6(               
    		.In1(PC_plus_4),
    		.In2(PC_branch),
    		.Out(PC_mux_1_2),
    		.Sel(PC_Src)
	);
	//Mux_2 before PC
	Mux uut7(               
    		.In1(PC_mux_1_2),
    		.In2(PC_jump),
    		.Out(PC_1),
    		.Sel(Jump)
	);
	//Mux before ALU
	Mux uut8(               
    		.In1(Write_data),
    		.In2(Sign_imm),
    		.Out(Src_B),
    		.Sel(ALU_src)
	);
	//Mux for Reg file, for R format instructions
	Mux_5_bit uut9 (        
    		.In1(Instr[20:16]),
    		.In2(Instr[15:11]),
    		.Out(Write_reg),
    		.Sel(Reg_dst)
	);
	//Mux after ALU/Data_Memory
	Mux uut10(              
    		.In1(ALU_result),
    		.In2(Read_data),
    		.Out(Result),
    		.Sel(Mem_reg)
	);
	PC pc_unit(
    		.In(PC_1),
    		.Out(PC_2),
    		.Clk(clk)
	);
	assign PC_plus_4 = PC_2 + 4;
	assign PC_branch = PC_plus_4+(Sign_imm << 2);
	assign PC_slt = Instr << 2;
	assign PC_jump = {PC_plus_4[31:28],PC_slt};
	assign PC_Src = (Branch & Zero);
endmodule
