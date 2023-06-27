
module ID_EX(

	input   wire        clk,
	input   wire        rst,
	input   wire[5:0]   stall,
	input   wire[5:0]   idALUop,
	input   wire[31:0]  idReg1,
	input   wire[31:0]  idReg2,
	input   wire[4:0]   idWriteNum,
	input   wire        idWriteReg,	
	input   wire[31:0]  idLinkAddr,
	input   wire[31:0]  idInst,	
	output  reg [5:0]   exALUop,
	output  reg [31:0]  exLinkAddr,
	output  reg [31:0]  exInst,
	output  reg [31:0]  exReg1,
	output  reg [31:0]  exReg2,
	output  reg [4:0]   exWriteNum,
	output  reg         exWriteReg
	
);

/*
 * This always part controls the signal exALUop.
 */
always @ (posedge clk) begin
    if (rst)
        exALUop <= 6'b0;
    else if (stall[3:2] == 2'b01)
        exALUop <= 6'b0;
    else if (!stall[2]) begin
        casex (idInst)
            // R - TYPE
            32'b0000000xxxxxxxxxx000xxxxx0110011: exALUop <= 6'b000000;  // add
            32'b0100000xxxxxxxxxx000xxxxx0110011: exALUop <= 6'b000001;  // sub
            32'b0000000xxxxxxxxxx100xxxxx0110011: exALUop <= 6'b000010;  // xor
            32'b0000000xxxxxxxxxx110xxxxx0110011: exALUop <= 6'b000011;  // or
            32'b0000000xxxxxxxxxx111xxxxx0110011: exALUop <= 6'b000100;  // and
            32'b0000000xxxxxxxxxx001xxxxx0110011: exALUop <= 6'b000101;  // sll
            32'b0000000xxxxxxxxxx101xxxxx0110011: exALUop <= 6'b000110;  // srl
            32'b0100000xxxxxxxxxx101xxxxx0110011: exALUop <= 6'b000111;  // sra
            32'b0000000xxxxxxxxxx010xxxxx0110011: exALUop <= 6'b001000;  // slt
            32'b0000000xxxxxxxxxx011xxxxx0110011: exALUop <= 6'b001001;  // sltu
		// I - TYPE
			32'bxxxxxxxxxxxxxxxxx000xxxxx0010011: exALUop <= 6'b001010;  // addi
			32'bxxxxxxxxxxxxxxxxx100xxxxx0010011: exALUop <= 6'b001011;  // xori
			32'bxxxxxxxxxxxxxxxxx110xxxxx0010011: exALUop <= 6'b001100;  // ori
            32'bxxxxxxxxxxxxxxxxx111xxxxx0010011: exALUop <= 6'b001101;  // andi
            32'b0000000xxxxxxxxxx001xxxxx0010011: exALUop <= 6'b001110;  // slli
            32'b0000000xxxxxxxxxx101xxxxx0010011: exALUop <= 6'b001111;  // srli
            32'b0100000xxxxxxxxxx101xxxxx0110011: exALUop <= 6'b010000;  // srai
            32'bxxxxxxxxxxxxxxxxx010xxxxx0010011: exALUop <= 6'b010001;  // slti
            32'bxxxxxxxxxxxxxxxxx011xxxxx0010011: exALUop <= 6'b010010;  // sltiu
            32'bxxxxxxxxxxxxxxxxx000xxxxx0000011: exALUop <= 6'b010011;  // lb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0000011: exALUop <= 6'b010100;  // lh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0000011: exALUop <= 6'b010101;  // lw
            32'bxxxxxxxxxxxxxxxxx100xxxxx0000011: exALUop <= 6'b010110;  // lbu
            32'bxxxxxxxxxxxxxxxxx101xxxxx0000011: exALUop <= 6'b010111;  // lhu
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100111: exALUop <= 6'b011000;  // jalr	
		// S - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx0100011: exALUop <= 6'b011001;  // sb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0100011: exALUop <= 6'b011010;  // sh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0100011: exALUop <= 6'b011011;  // sw
		// B - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100011: exALUop <= 6'b011100;  // beq
            32'bxxxxxxxxxxxxxxxxx001xxxxx1100011: exALUop <= 6'b011101;  // bne
            32'bxxxxxxxxxxxxxxxxx100xxxxx1100011: exALUop <= 6'b011110;  // blt
            32'bxxxxxxxxxxxxxxxxx101xxxxx1100011: exALUop <= 6'b011111;  // bge
            32'bxxxxxxxxxxxxxxxxx110xxxxx1100011: exALUop <= 6'b100000;  // bltu
            32'bxxxxxxxxxxxxxxxxx111xxxxx1100011: exALUop <= 6'b100001;  // bgeu
		// J - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111: exALUop <= 6'b100010;  // jal
		// U - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0110111: exALUop <= 6'b100011;  // lui
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0010111: exALUop <= 6'b100100;  // auipc
            default: exALUop <= 6'b000000;
        endcase
    end
end

/*
 * This always part controls the signal exReg1.
 */
always @ (posedge clk) begin
    if (rst)
        exReg1 <= 32'b0;
    else if (stall[3:2] == 2'b01)
        exReg1 <= 32'b0;
    else if (!stall[2])
        exReg1 <= idReg1;
end

/*
 * This always part controls the signal exReg2.
 */
always @ (posedge clk) begin
    if (rst)
        exReg2 <= 32'b0;
    else if (stall[3:2] == 2'b01)
        exReg2 <= 32'b0;
    else if (!stall[2])
        exReg2 <= idReg2;
end

/*
 * This always part controls the signal exWriteNum.
 */
always @ (posedge clk) begin
    if (rst)
        exWriteNum <= 5'b0;
    else if (stall[3:2] == 2'b01)
        exWriteNum <= 5'b0;
    else if (!stall[2])
        exWriteNum <= idWriteNum;
end

/*
 * This always part controls the signal exWriteReg.
 */
always @ (posedge clk) begin
    if (rst)
        exWriteReg <= 1'b0;
    else if (stall[3:2] == 2'b01)
        exWriteReg <= 1'b0;
    else if (!stall[2])
        exWriteReg <= idWriteReg;
end

/*
 * This always part controls the signal exLinkAddr.
 */
always @ (posedge clk) begin
    if (rst)
        exLinkAddr <= 32'b0;
    else if (stall[3:2] == 2'b01)
        exLinkAddr <= 32'b0;
    else if (!stall[2])
        exLinkAddr <= idLinkAddr;
end

/*
 * This always part controls the signal exInst.
 */
always @ (posedge clk) begin
    if (rst)
        exInst <= 32'b0;
    else if (stall[3:2] == 2'b01)
        exInst <= 32'b0;
    else if (!stall[2])
        exInst <= idInst;
end

endmodule