module program_counter(pc, jump, branch, select_jump, select_branch, rst, clk);

output reg[31:0] pc;
input[31:0] jump;
input[31:0] branch;
input select_jump;
input select_branch;
input rst;
input clk;

wire[1:0] counter_input_select = {select_jump, select_branch};

always @(posedge clk or posedge rst)
begin
	if(rst)
		pc <= 0;
	else
	begin
		casex(counter_input_select)
		2'b00: pc <= pc + 1;
		2'bx1: pc <= branch;
		2'b1x: pc <= jump;
		default: pc <= pc + 1;
		endcase
	end
end

endmodule
