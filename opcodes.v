// ALU States
`define NOP_ALU 	6'd0    // No operation
`define ADD_ALU 	6'd1    // Signed Add
`define SUB_ALU 	6'd2    // Signed Subtract
`define AND_ALU 	6'd3    // Logical AND
`define OR_ALU  	6'd4    // Logical OR
`define NOT_ALU 	6'd5    // Logical Invert
`define XOR_ALU 	6'd6    // Logical XOR
`define SGE_ALU 	6'd7	// Set if greater than or equal to
`define SGT_ALU 	6'd8	// Set if greater than
`define SLE_ALU 	6'd9	// Set if less than or equal to
`define SLT_ALU 	6'd10	// Set if less than
`define SEQ_ALU 	6'd11	// Set if equal
`define SNE_ALU 	6'd12	// Set if not equal
`define LOAD_ALU	6'd13	// Load instruction
`define STORE_ALU	6'd14	// Store instruction
`define SLI_ALU		6'd15	// Shift left immediate
`define SRI_ALU 	6'd16	// Shift right immediate
`define MOVE_ALU	6'd17	// Move instruction
`define ADDI_ALU	6'd18 	// Add immediate instructiin
`define SUBI_ALU	6'd19	// Subtract immediate instruction
`define MOVEI_ALU	6'd20 	// Move immediate instruction
`define JUMP_ALU	6'd21	// Jump instruction
`define BRA_ALU		6'd22	// Branch instruction
`define ADDF_ALU	6'd23	// Add floating point
`define MULF_ALU	6'd24	// Multiply floating point