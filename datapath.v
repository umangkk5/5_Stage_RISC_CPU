module Datapath_Unit(
 input clk,
 input DM_write,RF_dest_addr, RF_write, sli_sri, imm_instr,
 input[1:0] jump_or_branch, 
 input[1:0] mem_to_reg,
 output[5:0] opcode
);

// First stage: Program counter

reg[31:0] pc_current;
wire[31:0] pc_next,pc2;

initial begin
	pc_current <= 32'd0;
end

always @(posedge clk)
begin
	pc_current <= pc_next;
end
assign pc2 = pc_current + 32'd1;

// Instruction memory Stage
wire[31:0] instr;
instruction_memory IM(.DOut(instr), .AIn(pc_current));

wire[4:0] IF_RS1_RS;
wire[4:0] IF_RS2_RD;
wire[4:0] IF_RD;
wire[25:0] IF_IMM_J;
wire[15:0] IF_IMM_BA;

instruction_register IR(.OPC(opcode), .RS1_RS(IF_RS1_RS), .RS2_RD(IF_RS2_RD),
				     .RD(IF_RD), .IMM_J(IF_IMM_J), .IMM_BA(IF_IMM_BA), .value(instr), .clk(clk));
					

// Register file Stage

wire[31:0] RF_DOut1;
wire[31:0] RF_DOut2;
wire[31:0] RF_write_data;
wire[4:0]  RF_write_addr;

assign RF_write_addr = (mem_to_reg || sli_sri || imm_instr)? IF_RS2_RD : IF_RD ;

wire[4:0] RF_stage_delay_ain3;
wire[4:0] Alu_stage_delay_ain3;
wire[4:0] DM_stage_delay_ain3;

// 3-stage delay for AIn3
flip_flop_5 FF1(.Q(RF_stage_delay_ain3), .D(RF_write_addr), .clk(clk));
flip_flop_5 FF2(.Q(Alu_stage_delay_ain3), .D(RF_stage_delay_ain3), .clk(clk));
flip_flop_5 FF3(.Q(DM_stage_delay_ain3), .D(Alu_stage_delay_ain3), .clk(clk));

// 3-stage delay for WE

wire RF_write_delay1;
wire RF_write_delay2;
wire RF_write_delay3;

flip_flop FF4(.Q(RF_write_delay1), .D(RF_write), .clk(clk));
flip_flop FF5(.Q(RF_write_delay2), .D(RF_write_delay1), .clk(clk));
flip_flop FF6(.Q(RF_write_delay3), .D(RF_write_delay2), .clk(clk));

register_file RF(.DOut1(RF_DOut1), .DOut2(RF_DOut2), .AIn1(IF_RS1_RS), .AIn2(IF_RS2_RD), .AIn3(DM_stage_delay_ain3), .DIn(RF_write_data), .WE(RF_write_delay3), .clk(clk));

wire[31:0] ALU_in_RF_DOut1;
wire[31:0] ALU_in_RF_DOut2;

flip_flop_32 FF7(.Q(ALU_in_RF_DOut1), .D(RF_DOut1), .clk(clk));
flip_flop_32 FF8(.Q(ALU_in_RF_DOut2), .D(RF_DOut2), .clk(clk));

wire[31:0] ALU_in_Imm_BA;

flip_flop_32 FF9(.Q(ALU_in_Imm_BA), .D({{16{IF_IMM_BA[15]}}, IF_IMM_BA}), .clk(clk));

wire[5:0] RF_opcode;

flip_flop_6 FF10(.Q(RF_opcode), .D(opcode), .clk(clk));

// ALU Stage

wire[31:0] ALU_in1;
wire[31:0] ALU_in2;

wire[1:0] RF_delay_mem_to_reg1;
wire RF_delay_RF_dest_addr;
wire RF_delay_dm_write;
wire RF_delay_sli_sri;
wire RF_delay_imm_instr;

flip_flop_2 FF11(.Q(RF_delay_mem_to_reg1), .D(mem_to_reg), .clk(clk));
flip_flop FF12(.Q(RF_delay_RF_dest_addr), .D(RF_dest_addr), .clk(clk));
flip_flop FF13(.Q(RF_delay_dm_write), .D(DM_write), .clk(clk));
flip_flop FF14(.Q(RF_delay_sli_sri), .D(sli_sri), .clk(clk));
flip_flop FF15(.Q(RF_delay_imm_instr), .D(imm_instr), .clk(clk));


assign ALU_in1 = (RF_delay_mem_to_reg1 || RF_delay_RF_dest_addr || RF_delay_sli_sri || RF_delay_imm_instr)? ALU_in_RF_DOut1 : ALU_in_RF_DOut2;
assign ALU_in2 = (jump_or_branch == 2'b01)? IF_RS2_RD :(RF_delay_mem_to_reg1 || RF_delay_dm_write || RF_delay_sli_sri || RF_delay_imm_instr)? ALU_in_Imm_BA : ALU_in_RF_DOut2;

wire[31:0] AS_out;

ALU AS(.a(ALU_in1), .b(ALU_in2), .function_select(RF_opcode), .result(AS_out));

wire[31:0] DM_in_Addr;
wire[31:0] DM_in_data;

flip_flop_32 FF16(.Q(DM_in_Addr), .D(AS_out), .clk(clk));
flip_flop_32 FF17(.Q(DM_in_data), .D(ALU_in_RF_DOut1), .clk(clk));

wire[31:0] pc3;

flip_flop_32 FF18(.Q(pc3), .D(pc2), .clk(clk));

assign pc_next = (jump_or_branch == 2'b01)? pc3 + {{16{1'b0}}, IF_IMM_BA} : (jump_or_branch == 3'b10)? {{6{1'b0}},IF_IMM_J} : pc2;

// Data memory Stage
wire[31:0] DM_Out;
wire DM_delay_WE;

flip_flop FF19(.Q(DM_delay_WE), .D(RF_delay_dm_write), .clk(clk));

data_memory DM(.DOut(DM_Out), .AIn(DM_in_Addr), .DIn(DM_in_data), .WE(DM_delay_WE));

// Write back stage

wire[31:0] bypass_dm_out;
wire[31:0] wb_in_DOut;
wire[1:0] DM_delay_mem_to_reg2;
wire[1:0] DM_delay_mem_to_reg3;

flip_flop_32 FF20(.Q(bypass_dm_out), .D(DM_in_Addr), .clk(clk));
flip_flop_32 FF21(.Q(wb_in_DOut), .D(DM_Out), .clk(clk));
flip_flop_2 FF22(.Q(DM_delay_mem_to_reg2), .D(RF_delay_mem_to_reg1), .clk(clk));
flip_flop_2 FF23(.Q(DM_delay_mem_to_reg3), .D(DM_delay_mem_to_reg2), .clk(clk));

wire[31:0] move_data;

flip_flop_32 FF24(.Q(move_data), .D(DM_in_data), .clk(clk));

assign RF_write_data = (DM_delay_mem_to_reg3 == 2'b00)? bypass_dm_out : (DM_delay_mem_to_reg3 == 2'b01)? wb_in_DOut :  move_data;

endmodule