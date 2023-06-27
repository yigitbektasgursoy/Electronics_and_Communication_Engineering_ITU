
module inst_mem(

	input	wire		ce,    // chip select signal
	input	wire[31:0]	addr,  // instruction address
	output 	reg [31:0]	inst   // instruction
	
);

	reg[31:0]  inst_memory[0:1023];

	initial $readmemb ("D:/Ders/2022-2023 Spring/EHB 425E/new/new/machinecode.txt", inst_memory);	// read test assembly code file

always @ (*) begin
	if (!ce) 
		inst <= 32'b0;
	else
		inst <= inst_memory[addr[31:0]];
end

endmodule