module register_file(DOut1, DOut2, AIn1, AIn2, AIn3, DIn, WE, clk);

input[4:0] AIn1;
input[4:0] AIn2;
input[4:0] AIn3;
input[31:0] DIn;
input WE, clk;
output reg[31:0] DOut1;
output reg[31:0] DOut2;

reg[31:0] register_arr[31:0];
integer i;

initial begin
	for(i=0;i<32;i=i+1)
		register_arr[i] <= 32'd0;
end

always @(posedge clk)
begin
	if(WE)
	begin
		register_arr[AIn3] = DIn;
	end
	
assign DOut1 = register_arr[AIn1];
assign DOut2 = register_arr[AIn2];

end

endmodule
