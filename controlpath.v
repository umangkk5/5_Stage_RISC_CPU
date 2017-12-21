`include "opcodes.v"

module Control_Unit(
 input[5:0] opcode,
 output reg DM_write,RF_dest_addr, RF_write, sli_sri, imm_instr,
 output reg[1:0] jump_or_branch,
 output reg[1:0] mem_to_reg
);

initial begin
RF_dest_addr = 1'b0;
mem_to_reg = 1'b0;
RF_write = 1'b0;
DM_write = 1'b0;
jump_or_branch = 0;  
sli_sri = 0;
imm_instr = 0;
end

always @(*)
begin
	case(opcode)
	`NOP_ALU:   begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b0;
				RF_write = 1'b0;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
			
	`ADD_ALU:
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;	
				imm_instr = 0;
				end
	`SUB_ALU:
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;	
				imm_instr = 0;
				end
	`AND_ALU:
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
	
	`OR_ALU	:
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
	
	`XOR_ALU:
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`NOT_ALU:
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
	
	
	`LOAD_ALU :	
				begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b01;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
								
	`STORE_ALU :
				begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b0;
				RF_write = 1'b0;
				DM_write = 1'b1;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
				
				
	`MOVE_ALU :
				begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b10;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`SLI_ALU :	
				begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 1;
				imm_instr = 0;
				end
				
	`SRI_ALU :	
				begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 1;
				imm_instr = 0;
				end
	
	`SGE_ALU :	
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`SGT_ALU :	
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
	
	`SLE_ALU :
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`SLT_ALU :
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`SEQ_ALU :	
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`SNE_ALU :
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`ADDI_ALU :
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 1;
				end
	
	`SUBI_ALU :
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 1;
				end
				
	`MOVEI_ALU :
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;
				imm_instr = 1;
				end
				
	`JUMP_ALU :
				begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b0;
				RF_write = 1'b0;
				DM_write = 1'b0;
				jump_or_branch = 2'b10;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`BRA_ALU :
				begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b0;
				RF_write = 1'b0;
				DM_write = 1'b0;
				jump_or_branch = 2'b01;
				sli_sri = 0;
				imm_instr = 0;
				end
				
	`ADDF_ALU:
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;	
				imm_instr = 0;
				end
				
	`MULF_ALU:
				begin
				RF_dest_addr = 1'b1;
				mem_to_reg = 2'b0;
				RF_write = 1'b1;
				DM_write = 1'b0;
				jump_or_branch = 0;
				sli_sri = 0;	
				imm_instr = 0;
				end
	
	default: 	begin
				RF_dest_addr = 1'b0;
				mem_to_reg = 2'b0;
				RF_write = 1'b0;
				DM_write = 1'b0;
				jump_or_branch = 0;
				imm_instr = 0;
				end
	endcase
end

endmodule