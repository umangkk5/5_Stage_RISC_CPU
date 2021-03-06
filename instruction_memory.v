module instruction_memory(DOut, AIn);

input[31:0] AIn;
output[31:0] DOut;

reg[31:0] instruction_mem[31:0];

initial
begin
	$readmemb("./Files/instructions.data", instruction_mem);
end
assign DOut = instruction_mem[AIn];
	
endmodule