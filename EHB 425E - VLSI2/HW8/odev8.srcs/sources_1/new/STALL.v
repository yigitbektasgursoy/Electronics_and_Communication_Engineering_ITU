
 module STALL(

	input   wire        rst,
	input   wire        StallLoad,
	input   wire        StallBranch,
	output  reg [5:0]   stall       
	
);

/*
 * This always part controls the signal stall.
 */
always @ (*) begin
    if (rst)
        stall <= 6'b0;
    else if (StallBranch)
        stall <= 6'b000010;
    else if (StallLoad)
        stall <= 6'b000111;			
    else
        stall <= 6'b0;
end		

endmodule