`include "parameter.v"

module data_memory(DOut, AIn, DIn, WE);

input[`MEMORY_SIZE-1:0] AIn;
input[`MEMORY_SIZE-1:0] DIn;
input WE;
output reg[`MEMORY_SIZE-1:0] DOut;

reg[`MEMORY_SIZE-1:0] data_memory[`DM_LENGTH-1:0];
integer f;

initial begin	
  $readmemb("./Files/memory.data", data_memory);
  
  f = $fopen("./Files/memory_read.data");
  $fmonitor(f, "time = %d\n", $time, 
  "\tmemory[0] = %b\n", data_memory[0],   
  "\tmemory[1] = %b\n", data_memory[1],
  "\tmemory[2] = %b\n", data_memory[2],
  "\tmemory[3] = %b\n", data_memory[3],
  "\tmemory[4] = %b\n", data_memory[4],
  "\tmemory[5] = %b\n", data_memory[5],
  "\tmemory[6] = %b\n", data_memory[6],
  "\tmemory[7] = %b\n", data_memory[7]);
  #200;
  $fclose(f);
end

always @(*)
begin
	if(WE == 1)
		data_memory[AIn] = DIn;	
	else
		DOut = data_memory[AIn];
end

endmodule
