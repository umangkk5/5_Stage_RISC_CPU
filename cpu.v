
module risc_32_bit(input clk);

wire DM_write, RF_dest_addr, RF_write, sli_sri, imm_instr;
wire [5:0] opcode;
wire [1:0] jump_or_branch;
wire [1:0] mem_to_reg;

// DATAPATH

Datapath_Unit DU(.clk(clk), .jump_or_branch(jump_or_branch), .DM_write(DM_write), 
				 .RF_dest_addr(RF_dest_addr), .mem_to_reg(mem_to_reg),
				 .RF_write(RF_write), .opcode(opcode), .sli_sri(sli_sri), .imm_instr(imm_instr));
				 
// CONTROL UNIT

Control_Unit CU(.opcode(opcode), .jump_or_branch(jump_or_branch), .DM_write(DM_write), 
				 .RF_dest_addr(RF_dest_addr), .mem_to_reg(mem_to_reg), .imm_instr(imm_instr),
				 .RF_write(RF_write), .sli_sri(sli_sri));
				 

endmodule