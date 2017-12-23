
`include "parameter.v"

module test_32_bit_risc;

// Inputs
reg clk;

// Instantiate the Unit under test

risc_32_bit uut(.clk(clk));

initial begin
	clk <= 0;
	#200;
	$finish;
end

always
begin
	#5 clk = ~clk;
end

endmodule