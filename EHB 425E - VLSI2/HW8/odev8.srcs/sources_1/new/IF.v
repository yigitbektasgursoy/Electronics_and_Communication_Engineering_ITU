module IF(

	input	wire 		clk,
	input	wire		rst,
	input 	wire		Branch,
	input 	wire[31:0] 	Addr,
	input	wire[5:0]	stall,
	input	wire		PreBranch,  // predict
	input	wire[31:0]	PreAddr,
	output 	reg 	 	clk_en, //clock enable for bubble
	output	reg [31:0] 	PC

);

always @ (posedge clk) begin
	if (rst)
		clk_en <= 1'b0;
	else
		clk_en <= 1'b1;
end

always @ (posedge clk) begin
	if (!clk_en)
		PC <= 32'b0;
	else if (!(stall[0])) begin
		if (Branch)
			PC <= Addr;
		else if (PreBranch)
			PC <= PreAddr;
		else
			PC <= PC + 4'h4;  // New PC equals ((old PC) + 4) per cycle.
	end
end

endmodule