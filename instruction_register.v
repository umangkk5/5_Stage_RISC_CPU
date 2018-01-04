`include "parameter.v"

module instruction_register(OPC, RS1_RS, RS2_RD, RD, IMM_J, IMM_BA, value, clk);

output reg[5:0] OPC;
output reg[4:0] RS1_RS;			// RS1 or RS depending upon instruction
output reg[4:0] RS2_RD;			// RS2 or RD depending upon instruction
output reg[4:0] RD;
output reg[25:0] IMM_J;			// Immediate value for Jump instruction
output reg[15:0] IMM_BA;		// Immediate value for ALU or Branch instruction
input clk;
input[31:0] value;
 
always @ (posedge clk)
begin
	OPC <= value[31:26];
	RS1_RS <= value[25:21];
	RS2_RD <= value[20:16];
	RD <= value[15:11];
	IMM_J <= value[25:0];
	IMM_BA <= value[15:0];
end
endmodule
