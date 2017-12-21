`include "opcodes.v"
`include "floating_point_adder.v"
`include "floating_point_multiplier.v"

module ALU(a, b, function_select, result);

input[31:0] a;
input[31:0] b;
input[5:0] function_select;
output reg[31:0] result;

wire[31:0] x;
wire[31:0] y;
fp_adder FAP(.a(a), .b(b), .result(x));
fp_multiplier FMP(.a(a), .b(b), .result(y));

always @(*)
begin
	result = 0;
	
	case(function_select)
	
	`NOP_ALU: begin
			  // No operation
			  
			  end
			  
	`ADD_ALU: begin
			  // Signed addition
			  result = a + b;
			  end
			  
	`SUB_ALU: begin
			  // Signed subtraction
			  result = a - b;
			  end
			  
	`AND_ALU: begin
			  // logical AND
			  result = a & b;
			  end
			 
	`OR_ALU:  begin
			  // logical OR
			  result = a | b;
			  end
			  
	`NOT_ALU: begin
			  // logical inverter
			  result = ~a;
			  end
			  
	`XOR_ALU: begin
			  // logical XOR
			  result = a ^ b;
			  end
			  
	`SGE_ALU: begin
		      // Set if greater than or equal to
			  result = (a >= b)? 32'd1 : 32'd0;
			  end
			  
	`SGT_ALU: begin
			  // Set if greater than
			  result = (a > b)? 32'd1 : 32'd0;
			  end
			  
	`SLE_ALU: begin
			  // Set if less than or equal to
			  result = (a <= b)? 32'd1 : 32'd0;
			  end
			  
	`SLT_ALU: begin
			  // Set if less than
			  result = (a < b)? 32'd1 : 32'd0;
			  end
	`SEQ_ALU: begin
			  // Set if equal
			  result = (a == b)? 32'd1 : 32'd0;
			  end
			  
	`SNE_ALU: begin
			  // Set if not equal
			  result = (a == b)? 32'b0 : 32'b1;
			  end			  
			  
	`LOAD_ALU: begin
			   // load instruction
			   result = a + b;
			   end
			   
	`STORE_ALU: begin
			   // store instruction
			   result = a + b;
			   end
			   
	`SLI_ALU: begin
			   // shift left instruction
			   result = a << b;
			   end			   
			   
	`SRI_ALU: begin
			   // shift right instruction
			   result = a >> b;
			   end

	`MOVE_ALU: begin	
			   // Move instruction
			   result = a;
			   end

	`ADDI_ALU: begin	
			   // Add immediate instruction
			   result = a + b;
			   end
			   
	`SUBI_ALU: begin	
			   // Subtract immediate instruction
			   result = a - b;
			   end			   
			   
	`MOVEI_ALU: begin	
			   // Subtract immediate instruction
			   result = b;
			   end
			   
	`BRA_ALU: begin
			  // Branch instruction
			  result = 32'd1;
			  end
			  
	`ADDF_ALU: begin	
			   // Add floating point
			   result = x;
			   end
			   
	
	`MULF_ALU: begin	
			   // Multiply floating point
			   result = y;
			   end
			   		  
	default: result = result;
 endcase
end

endmodule