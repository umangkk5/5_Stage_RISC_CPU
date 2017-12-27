

module flip_flop_2(
    output reg [1:0] Q,
    input [1:0] D,
    input clk
    );

always@(posedge clk)
begin
	Q <= D;
end
endmodule
