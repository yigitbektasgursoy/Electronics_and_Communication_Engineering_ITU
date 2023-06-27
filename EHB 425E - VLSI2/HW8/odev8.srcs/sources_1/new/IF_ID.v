    module IF_ID(

	input   wire        clk,
	input   wire        rst,
	input   wire[5:0]   stall,	
	input   wire[31:0]	IF_PC,
	input   wire[31:0]  IF_Instruction,
	input   wire 		IN_Predict,
	output  reg 		OUT_Predict,
	output  reg[31:0]   ID_PC,
	output  reg[31:0]   ID_Instruction

    );

/*
 * This always part controls the signal ID_PC.
 */
always @ (*) begin
    if (rst)
        ID_PC <= 32'b0; 
    else if (!stall[1])
        ID_PC <= IF_PC;
    else if (stall[2:1] ==2'b01)
        ID_PC <= 32'b0;
end

/*
 * This always part controls the signal ID_Instruction.
 */
always @ (*) begin
    if (rst)
        ID_Instruction <= 32'b0; 
    else if (!stall[1])
        ID_Instruction <= IF_Instruction;
    else if (stall[2:1] ==2'b01)
        ID_Instruction <= 32'b0;
end

/*
 * This always part controls the signal OUT_Predict.
 */
always @ (*) begin
    if (rst)
        OUT_Predict <= 1'b0; 
    else if (!stall[1])
        OUT_Predict <= IN_Predict;
    else if (stall[2:1] ==2'b01)
        OUT_Predict <= 1'b0;
end
	
 endmodule