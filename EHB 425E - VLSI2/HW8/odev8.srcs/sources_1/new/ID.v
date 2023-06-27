module ID(

    input   wire        rst,
    input   wire[31:0]  pc_i,
    input   wire[31:0]  inst_i,
    input   wire[31:0]  RegData1,
    input   wire[31:0]  RegData2,

    input   wire[4:0]	exALUop,
	input   wire		exWriteReg,
	input   wire[31:0]	exWriteData,
	input   wire[4:0]   exWriteNum,
	input   wire		memWriteReg,
	input   wire[31:0]	memWriteData,
	input   wire[4:0]   memWriteNum,
    input   wire 		Predict,
    
    output  reg         RegRead1,     // if read register or not
    output  reg         RegRead2,     // if read register or not
    output  reg [4:0]   RegAddr1,
    output  reg [4:0]   RegAddr2,

    output  reg [5:0]   ALUop,
    output  reg [31:0]  Reg1,
    output  reg [31:0]  Reg2,
    output  reg [4:0]   WriteData,
    output  reg         WriteReg,     // if write register or not

    output  reg         Branch,       // if branch or not
    output  reg [31:0]  BranchAddr,   // branch address
    output  reg [31:0]  LinkAddr,     // link address for jal
    output  wire[31:0]  inst_o,
	output  wire[31:0] 	pc_o,
    output  reg			BranchFlag,
	output  reg			Accept,
	output  reg			PredictFlag,
    output  reg         StallBranch,	
	output  wire        StallReqLoad

);

    reg inst_valid;
    reg [31:0] imm;

    wire[31:0] pc_add_4;
    wire[31:0] pc_add_imm_B;
    wire[31:0] pc_add_imm_Jal;
    wire[31:0] pc_add_imm_Jalr;
    wire[31:0] pc_add_imm_U;
    wire[4:0]  rs1_addr = inst_i[19:15];
    wire[4:0]  rs2_addr = inst_i[24:20];
    wire[4:0]  rd_addr  = inst_i[11:7];


    wire[31:0] imm_I = {{21{inst_i[31:31]}}, inst_i[30:20]};
    wire[31:0] imm_S = {{21{inst_i[31:31]}}, inst_i[30:25], inst_i[11:7]};
    wire[31:0] imm_B = {{20{inst_i[31:31]}}, inst_i[ 7: 7], inst_i[30:25], inst_i[11:8], 1'b0};
    wire[31:0] imm_J = {{12{inst_i[31:31]}}, inst_i[19:12], inst_i[20:20], inst_i[30:25], inst_i[24:21], 1'b0};
	wire[31:0] imm_U = {inst_i[31:12], 12'b0};

    assign inst_o = inst_i;
    assign pc_o = pc_i;
    assign pc_add_4 = pc_i + 4;
    assign pc_add_imm_B = pc_i + imm_B;
    assign pc_add_imm_Jal = pc_i + imm_J;
	assign pc_add_imm_Jalr = rs1_addr + imm_J;
	assign pc_add_imm_U = (imm_U << 12);


    reg StallReq1;
	reg StallReq2;
	wire PreInstLoad;

	assign StallReqLoad = StallReq1 | StallReq2;
	assign PreInstLoad  = ( (exALUop == 6'b010011) || (exALUop <= 6'b010100) || (exALUop <= 6'b010101) || (exALUop <= 6'b010110) || (exALUop <= 6'b010111)) ? 1'b1 : 1'b0; //lb, lh, llw, lbu, lhu

/*
 * This always part controls ALUop, it helps EX module excute the different instructions.
 */
always @ (*) begin
    if (rst)
        ALUop <= 6'b0;
    else begin
        casex (inst_i)
		// R - TYPE
            32'b0000000xxxxxxxxxx000xxxxx0110011: ALUop <= 6'b000000;  // add
            32'b0100000xxxxxxxxxx000xxxxx0110011: ALUop <= 6'b000001;  // sub
            32'b0000000xxxxxxxxxx100xxxxx0110011: ALUop <= 6'b000010;  // xor
            32'b0000000xxxxxxxxxx110xxxxx0110011: ALUop <= 6'b000011;  // or
            32'b0000000xxxxxxxxxx111xxxxx0110011: ALUop <= 6'b000100;  // and
            32'b0000000xxxxxxxxxx001xxxxx0110011: ALUop <= 6'b000101;  // sll
            32'b0000000xxxxxxxxxx101xxxxx0110011: ALUop <= 6'b000110;  // srl
            32'b0100000xxxxxxxxxx101xxxxx0110011: ALUop <= 6'b000111;  // sra
            32'b0000000xxxxxxxxxx010xxxxx0110011: ALUop <= 6'b001000;  // slt
            32'b0000000xxxxxxxxxx011xxxxx0110011: ALUop <= 6'b001001;  // sltu
		// I - TYPE
			32'bxxxxxxxxxxxxxxxxx000xxxxx0010011: ALUop <= 6'b001010;  // addi
			32'bxxxxxxxxxxxxxxxxx100xxxxx0010011: ALUop <= 6'b001011;  // xori
			32'bxxxxxxxxxxxxxxxxx110xxxxx0010011: ALUop <= 6'b001100;  // ori
            32'bxxxxxxxxxxxxxxxxx111xxxxx0010011: ALUop <= 6'b001101;  // andi
            32'b0000000xxxxxxxxxx001xxxxx0010011: ALUop <= 6'b001110;  // slli
            32'b0000000xxxxxxxxxx101xxxxx0010011: ALUop <= 6'b001111;  // srli
            32'b0100000xxxxxxxxxx101xxxxx0110011: ALUop <= 6'b010000;  // srai
            32'bxxxxxxxxxxxxxxxxx010xxxxx0010011: ALUop <= 6'b010001;  // slti
            32'bxxxxxxxxxxxxxxxxx011xxxxx0010011: ALUop <= 6'b010010;  // sltiu
            32'bxxxxxxxxxxxxxxxxx000xxxxx0000011: ALUop <= 6'b010011;  // lb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0000011: ALUop <= 6'b010100;  // lh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0000011: ALUop <= 6'b010101;  // lw
            32'bxxxxxxxxxxxxxxxxx100xxxxx0000011: ALUop <= 6'b010110;  // lbu
            32'bxxxxxxxxxxxxxxxxx101xxxxx0000011: ALUop <= 6'b010111;  // lhu
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100111: ALUop <= 6'b011000;  // jalr	
		// S - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx0100011: ALUop <= 6'b011001;  // sb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0100011: ALUop <= 6'b011010;  // sh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0100011: ALUop <= 6'b011011;  // sw
		// B - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100011: ALUop <= 6'b011100;  // beq
            32'bxxxxxxxxxxxxxxxxx001xxxxx1100011: ALUop <= 6'b011101;  // bne
            32'bxxxxxxxxxxxxxxxxx100xxxxx1100011: ALUop <= 6'b011110;  // blt
            32'bxxxxxxxxxxxxxxxxx101xxxxx1100011: ALUop <= 6'b011111;  // bge
            32'bxxxxxxxxxxxxxxxxx110xxxxx1100011: ALUop <= 6'b100000;  // bltu
            32'bxxxxxxxxxxxxxxxxx111xxxxx1100011: ALUop <= 6'b100001;  // bgeu
		// J - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111: ALUop <= 6'b100010;  // jal
		// U - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0110111: ALUop <= 6'b100011;  // lui
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0010111: ALUop <= 6'b100100;  // auipc
            default: ALUop <= 6'b000000;
        endcase
    end
end

/*
 * This always part controls the signal WriteReg.
 */
always @ (*) begin
    if (rst)
        WriteReg = 1'b0;
    else begin
        casex (inst_i)
		// R - TYPE
            32'b0000000xxxxxxxxxx000xxxxx0110011: WriteReg <= 1'b1;  // add
            32'b0100000xxxxxxxxxx000xxxxx0110011: WriteReg <= 1'b1;  // sub
            32'b0000000xxxxxxxxxx100xxxxx0110011: WriteReg <= 1'b1;  // xor
            32'b0000000xxxxxxxxxx110xxxxx0110011: WriteReg <= 1'b1;  // or
            32'b0000000xxxxxxxxxx111xxxxx0110011: WriteReg <= 1'b1;  // and
            32'b0000000xxxxxxxxxx001xxxxx0110011: WriteReg <= 1'b1;  // sll
            32'b0000000xxxxxxxxxx101xxxxx0110011: WriteReg <= 1'b1;  // srl
            32'b0100000xxxxxxxxxx101xxxxx0110011: WriteReg <= 1'b1;  // sra
            32'b0000000xxxxxxxxxx010xxxxx0110011: WriteReg <= 1'b1;  // slt
            32'b0000000xxxxxxxxxx011xxxxx0110011: WriteReg <= 1'b1;  // sltu
		// I - TYPE
			32'bxxxxxxxxxxxxxxxxx000xxxxx0010011: WriteReg <= 1'b1;  // addi
			32'bxxxxxxxxxxxxxxxxx100xxxxx0010011: WriteReg <= 1'b1;  // xori
			32'bxxxxxxxxxxxxxxxxx110xxxxx0010011: WriteReg <= 1'b1;  // ori
            32'bxxxxxxxxxxxxxxxxx111xxxxx0010011: WriteReg <= 1'b1;  // andi
            32'b0000000xxxxxxxxxx001xxxxx0010011: WriteReg <= 1'b1;  // slli
            32'b0000000xxxxxxxxxx101xxxxx0010011: WriteReg <= 1'b1;  // srli
            32'b0100000xxxxxxxxxx101xxxxx0110011: WriteReg <= 1'b1;  // srai
            32'bxxxxxxxxxxxxxxxxx010xxxxx0010011: WriteReg <= 1'b1;  // slti
            32'bxxxxxxxxxxxxxxxxx011xxxxx0010011: WriteReg <= 1'b1;  // sltiu
            32'bxxxxxxxxxxxxxxxxx000xxxxx0000011: WriteReg <= 1'b1;  // lb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0000011: WriteReg <= 1'b1;  // lh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0000011: WriteReg <= 1'b1;  // lw
            32'bxxxxxxxxxxxxxxxxx100xxxxx0000011: WriteReg <= 1'b1;  // lbu
            32'bxxxxxxxxxxxxxxxxx101xxxxx0000011: WriteReg <= 1'b1;  // lhu
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100111: WriteReg <= 1'b1;  // jalr	
		// S - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx0100011: WriteReg <= 1'b0;  // sb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0100011: WriteReg <= 1'b0;  // sh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0100011: WriteReg <= 1'b0;  // sw
		// B - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100011: WriteReg <= 1'b0;  // beq
            32'bxxxxxxxxxxxxxxxxx001xxxxx1100011: WriteReg <= 1'b0;  // bne
            32'bxxxxxxxxxxxxxxxxx100xxxxx1100011: WriteReg <= 1'b0;  // blt
            32'bxxxxxxxxxxxxxxxxx101xxxxx1100011: WriteReg <= 1'b0;  // bge
            32'bxxxxxxxxxxxxxxxxx110xxxxx1100011: WriteReg <= 1'b0;  // bltu
            32'bxxxxxxxxxxxxxxxxx111xxxxx1100011: WriteReg <= 1'b0;  // bgeu
		// J - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111: WriteReg <= 1'b1;  // jal
		// U - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0110111: WriteReg <= 1'b1;  // lui
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0010111: WriteReg <= 1'b1;  // auipc

            default: WriteReg <= 1'b0;  // Unsupported opcode
        endcase
    end
end



/*
 * This always part controls the signal inst_valid, it checks the instructions legal or not.
 */
always @ (*) begin
    if (rst)
        inst_valid <= 1'b0;
    else begin
        casex (inst_i)
		// R - TYPE
            32'b0000000xxxxxxxxxx000xxxxx0110011: inst_valid <= 1'b0;  // add	
            32'b0100000xxxxxxxxxx000xxxxx0110011: inst_valid <= 1'b0;  // sub	
            32'b0000000xxxxxxxxxx100xxxxx0110011: inst_valid <= 1'b0;  // xor	
            32'b0000000xxxxxxxxxx110xxxxx0110011: inst_valid <= 1'b0;  // or
            32'b0000000xxxxxxxxxx111xxxxx0110011: inst_valid <= 1'b0;  // and
            32'b0000000xxxxxxxxxx001xxxxx0110011: inst_valid <= 1'b0;  // sll
            32'b0000000xxxxxxxxxx101xxxxx0110011: inst_valid <= 1'b0;  // srl
            32'b0100000xxxxxxxxxx101xxxxx0110011: inst_valid <= 1'b0;  // sra
            32'b0000000xxxxxxxxxx010xxxxx0110011: inst_valid <= 1'b0;  // slt
            32'b0000000xxxxxxxxxx011xxxxx0110011: inst_valid <= 1'b0;  // sltu
		// I - TYPE
			32'bxxxxxxxxxxxxxxxxx000xxxxx0010011: inst_valid <= 1'b0;  // addi
			32'bxxxxxxxxxxxxxxxxx100xxxxx0010011: inst_valid <= 1'b0;  // xori
			32'bxxxxxxxxxxxxxxxxx110xxxxx0010011: inst_valid <= 1'b0;  // ori
            32'bxxxxxxxxxxxxxxxxx111xxxxx0010011: inst_valid <= 1'b0;  // andi
            32'b0000000xxxxxxxxxx001xxxxx0010011: inst_valid <= 1'b0;  // slli
            32'b0000000xxxxxxxxxx101xxxxx0010011: inst_valid <= 1'b0;  // srli
            32'b0100000xxxxxxxxxx101xxxxx0110011: inst_valid <= 1'b0;  // srai
            32'bxxxxxxxxxxxxxxxxx010xxxxx0010011: inst_valid <= 1'b0;  // slti
            32'bxxxxxxxxxxxxxxxxx011xxxxx0010011: inst_valid <= 1'b0;  // sltiu
            32'bxxxxxxxxxxxxxxxxx000xxxxx0000011: inst_valid <= 1'b0;  // lb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0000011: inst_valid <= 1'b0;  // lh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0000011: inst_valid <= 1'b0;  // lw
            32'bxxxxxxxxxxxxxxxxx100xxxxx0000011: inst_valid <= 1'b0;  // lbu
            32'bxxxxxxxxxxxxxxxxx101xxxxx0000011: inst_valid <= 1'b0;  // lhu
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100111: inst_valid <= 1'b0;  // jalr	
		// S - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx0100011: inst_valid <= 1'b0;  // sb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0100011: inst_valid <= 1'b0;  // sh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0100011: inst_valid <= 1'b0;  // sw
		// B - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100011: inst_valid <= 1'b0;  // beq
            32'bxxxxxxxxxxxxxxxxx001xxxxx1100011: inst_valid <= 1'b0;  // bne
            32'bxxxxxxxxxxxxxxxxx100xxxxx1100011: inst_valid <= 1'b0;  // blt
            32'bxxxxxxxxxxxxxxxxx101xxxxx1100011: inst_valid <= 1'b0;  // bge
            32'bxxxxxxxxxxxxxxxxx111xxxxx1100011: inst_valid <= 1'b0;  // bltu
            32'bxxxxxxxxxxxxxxxxx110xxxxx1100011: inst_valid <= 1'b0;  // bgeu
		// J - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111: inst_valid <= 1'b0;  // jal
		// U - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0110111: inst_valid <= 1'b0;  // lui
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0010111: inst_valid <= 1'b0;  // auipc

            default: inst_valid <= 1'b1;
        endcase
    end
end


/*
 * This always part controls the signal RegRead1, it decides if this instruction needs rs1 or not.
 */
always @ (*) begin
    if (rst)
        RegRead1 <= 1'b0;
    else begin
        casex (inst_i)
		// R - TYPE
            32'b0000000xxxxxxxxxx000xxxxx0110011: RegRead1 <= 1'b1;  // add
            32'b0100000xxxxxxxxxx000xxxxx0110011: RegRead1 <= 1'b1;  // sub
            32'b0000000xxxxxxxxxx100xxxxx0110011: RegRead1 <= 1'b1;  // xor
            32'b0000000xxxxxxxxxx110xxxxx0110011: RegRead1 <= 1'b1;  // or
            32'b0000000xxxxxxxxxx111xxxxx0110011: RegRead1 <= 1'b1;  // and
            32'b0000000xxxxxxxxxx001xxxxx0110011: RegRead1 <= 1'b1;  // sll
            32'b0000000xxxxxxxxxx101xxxxx0110011: RegRead1 <= 1'b1;  // srl
            32'b0100000xxxxxxxxxx101xxxxx0110011: RegRead1 <= 1'b1;  // sra
            32'b0000000xxxxxxxxxx010xxxxx0110011: RegRead1 <= 1'b1;  // slt
            32'b0000000xxxxxxxxxx011xxxxx0110011: RegRead1 <= 1'b1;  // sltu
		// I - TYPE
			32'bxxxxxxxxxxxxxxxxx000xxxxx0010011: RegRead1 <= 1'b1;  // addi
			32'bxxxxxxxxxxxxxxxxx100xxxxx0010011: RegRead1 <= 1'b1;  // xori
            32'bxxxxxxxxxxxxxxxxx110xxxxx0010011: RegRead1 <= 1'b1;  // ori
            32'bxxxxxxxxxxxxxxxxx111xxxxx0010011: RegRead1 <= 1'b1;  // andi
            32'b0000000xxxxxxxxxx001xxxxx0010011: RegRead1 <= 1'b1;  // slli
            32'b0000000xxxxxxxxxx101xxxxx0010011: RegRead1 <= 1'b1;  // srli
            32'b0100000xxxxxxxxxx101xxxxx0110011: RegRead1 <= 1'b1;  // srai			
			32'bxxxxxxxxxxxxxxxxx010xxxxx0010011: RegRead1 <= 1'b1;  // slti
            32'bxxxxxxxxxxxxxxxxx011xxxxx0010011: RegRead1 <= 1'b1;  // sltiu
            32'bxxxxxxxxxxxxxxxxx000xxxxx0000011: RegRead1 <= 1'b1;  // lb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0000011: RegRead1 <= 1'b1;  // lh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0000011: RegRead1 <= 1'b1;  // lw
            32'bxxxxxxxxxxxxxxxxx100xxxxx0000011: RegRead1 <= 1'b1;  // lbu
            32'bxxxxxxxxxxxxxxxxx101xxxxx0000011: RegRead1 <= 1'b1;  // lhu
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100111: RegRead1 <= 1'b1;  // jalr	
		// S - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx0100011: RegRead1 <= 1'b1;  // sb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0100011: RegRead1 <= 1'b1;  // sh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0100011: RegRead1 <= 1'b1;  // sw
		// B - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100011: RegRead1 <= 1'b1;  // beq
            32'bxxxxxxxxxxxxxxxxx001xxxxx1100011: RegRead1 <= 1'b1;  // bne
            32'bxxxxxxxxxxxxxxxxx100xxxxx1100011: RegRead1 <= 1'b1;  // blt
            32'bxxxxxxxxxxxxxxxxx101xxxxx1100011: RegRead1 <= 1'b1;  // bge
            32'bxxxxxxxxxxxxxxxxx110xxxxx1100011: RegRead1 <= 1'b1;  // bltu
            32'bxxxxxxxxxxxxxxxxx111xxxxx1100011: RegRead1 <= 1'b1;  // bgeu
		// J - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111: RegRead1 <= 1'b0;  // jal
		// U - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0110111: RegRead1 <= 1'b0;  // lui
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0010111: RegRead1 <= 1'b0;  // auipc
            default: RegRead1 <= 1'b0;
        endcase
    end
end


/*
 * This always part controls the signal RegRead2, it decides if this instruction needs rs2 or not.
 */
always @ (*) begin
    if (rst)
        RegRead2 <= 1'b0;
    else begin
        casex (inst_i)
		// R - TYPE
            32'b0000000xxxxxxxxxx000xxxxx0110011: RegRead2 <= 1'b1;  // add
            32'b0100000xxxxxxxxxx000xxxxx0110011: RegRead2 <= 1'b1;  // sub
            32'b0000000xxxxxxxxxx100xxxxx0110011: RegRead2 <= 1'b1;  // xor
            32'b0000000xxxxxxxxxx110xxxxx0110011: RegRead2 <= 1'b1;  // or
            32'b0000000xxxxxxxxxx111xxxxx0110011: RegRead2 <= 1'b1;  // and
            32'b0000000xxxxxxxxxx001xxxxx0110011: RegRead2 <= 1'b1;  // sll
            32'b0000000xxxxxxxxxx101xxxxx0110011: RegRead2 <= 1'b1;  // srl
            32'b0100000xxxxxxxxxx101xxxxx0110011: RegRead2 <= 1'b1;  // sra
            32'b0000000xxxxxxxxxx010xxxxx0110011: RegRead2 <= 1'b1;  // slt
            32'b0000000xxxxxxxxxx011xxxxx0110011: RegRead2 <= 1'b1;  // sltu
		// I - TYPE
			32'bxxxxxxxxxxxxxxxxx000xxxxx0010011: RegRead2 <= 1'b0;  // addi
			32'bxxxxxxxxxxxxxxxxx100xxxxx0010011: RegRead2 <= 1'b0;  // xori
            32'bxxxxxxxxxxxxxxxxx110xxxxx0010011: RegRead2 <= 1'b0;  // ori
            32'bxxxxxxxxxxxxxxxxx111xxxxx0010011: RegRead2 <= 1'b0;  // andi
            32'b0000000xxxxxxxxxx001xxxxx0010011: RegRead2 <= 1'b0;  // slli
            32'b0000000xxxxxxxxxx101xxxxx0010011: RegRead2 <= 1'b0;  // srli
            32'b0100000xxxxxxxxxx101xxxxx0110011: RegRead2 <= 1'b0;  // srai			
			32'bxxxxxxxxxxxxxxxxx010xxxxx0010011: RegRead2 <= 1'b0;  // slti
            32'bxxxxxxxxxxxxxxxxx011xxxxx0010011: RegRead2 <= 1'b0;  // sltiu
            32'bxxxxxxxxxxxxxxxxx000xxxxx0000011: RegRead2 <= 1'b0;  // lb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0000011: RegRead2 <= 1'b0;  // lh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0000011: RegRead2 <= 1'b0;  // lw
            32'bxxxxxxxxxxxxxxxxx100xxxxx0000011: RegRead2 <= 1'b0;  // lbu
            32'bxxxxxxxxxxxxxxxxx101xxxxx0000011: RegRead2 <= 1'b0;  // lhu
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100111: RegRead2 <= 1'b0;  // jalr
		// S - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx0100011: RegRead2 <= 1'b1;  // sb
            32'bxxxxxxxxxxxxxxxxx001xxxxx0100011: RegRead2 <= 1'b1;  // sh
            32'bxxxxxxxxxxxxxxxxx010xxxxx0100011: RegRead2 <= 1'b1;  // sw
		// B - TYPE
            32'bxxxxxxxxxxxxxxxxx000xxxxx1100011: RegRead2 <= 1'b1;  // beq
            32'bxxxxxxxxxxxxxxxxx001xxxxx1100011: RegRead2 <= 1'b1;  // bne
            32'bxxxxxxxxxxxxxxxxx100xxxxx1100011: RegRead2 <= 1'b1;  // blt
            32'bxxxxxxxxxxxxxxxxx101xxxxx1100011: RegRead2 <= 1'b1;  // bge
            32'bxxxxxxxxxxxxxxxxx110xxxxx1100011: RegRead2 <= 1'b1;  // bltu
            32'bxxxxxxxxxxxxxxxxx111xxxxx1100011: RegRead2 <= 1'b1;  // bgeu
		// J - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111: RegRead2 <= 1'b0;  // jal
		// U - TYPE
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0110111: RegRead2 <= 1'b0;  // lui
            32'bxxxxxxxxxxxxxxxxxxxxxxxxx0010111: RegRead2 <= 1'b0;  // auipc
            default: RegRead2 <= 1'b0;
        endcase
    end
end


/*
 * This always part controls the signal imm, it gets the right format immediate number for I-type instuctions.
 */
always @ (*) begin
    if (rst)
        imm <= 32'b0;
    else if (inst_i[14:12] == 3'b000 && inst_i[6:0] == 7'b0010011)  // addi
        imm <= imm_I;
    else if (inst_i[14:12] == 3'b100 && inst_i[6:0] == 7'b0010011)  // xori
        imm <= imm_I;
    else if (inst_i[14:12] == 3'b110 && inst_i[6:0] == 7'b0010011)  // ori
        imm <= imm_I;
    else if (inst_i[14:12] == 3'b111 && inst_i[6:0] == 7'b0010011)  // andi
        imm <= imm_I;
    else if (inst_i[14:12] == 3'b000 && inst_i[6:0] == 7'b0010011)  // slli
        imm <= imm_I;
    else if (inst_i[14:12] == 3'b000 && inst_i[6:0] == 7'b0010011)  // srli
        imm <= imm_I;
    else if (inst_i[14:12] == 3'b010 && inst_i[6:0] == 7'b0110011)  // srai
        imm <= imm_I;
    else if (inst_i[14:12] == 3'b010 && inst_i[6:0] == 7'b0010011)  // slti
        imm <= imm_I;
    else if (inst_i[14:12] == 3'b011 && inst_i[6:0] == 7'b0010011)  // sltiu
        imm <= imm_I;
    else if (inst_i[6:0] == 7'b0110111)  // lui
        imm <= imm_U;
    else if (inst_i[6:0] == 7'b0010111)  // auipc
        imm <= pc_i + imm_U;
    else
        imm <= 32'b0;
end

/*
 * This always part controls the signal LinkAddr, it gets the right address.
 */
always @ (*) begin
    if (rst)
        LinkAddr <= 32'b0;
    else if (inst_i[6:0] == 7'b1101111)  // jal
        LinkAddr <= pc_add_4;
    else if (inst_i[6:0] == 7'b1100111)  // jalr
        LinkAddr <= pc_add_4;
    else
        LinkAddr <= 32'b0;
end

/*
 * This always part controls the signal BranchAddr, it gets the right address.
 */
always @ (*) begin
    if (rst)
        BranchAddr <= 32'b0;
    else if (inst_i[6:0] == 7'b1101111)  // jal
        BranchAddr <= pc_add_imm_Jal;
    else if (inst_i[6:0] == 7'b1100111)  // jalr
        BranchAddr <= pc_add_imm_Jalr;
    else if (inst_i[6:0] == 7'b1100011)  // beq, bne, blt, bge, bltu, bgeu
        BranchAddr <= pc_add_imm_B;
    else
        BranchAddr <= 32'b0;
end

/*
 * This always part controls the signal Branch, it decides if this instruction needs branch of not.
 */
always @ (*) begin
    if (rst)
        Branch <= 1'b0;	
    else if (inst_i[6:0] == 7'b1101111 || inst_i[6:0] == 7'b1100111 || inst_i[6:0] == 7'b1100011 || inst_i[6:0] == 0110111 || inst_i[6:0] == 0010111 )  
        Branch <= 1'b1;      // jal,                         jalr,    beq,bne,blt,bge,bltu,bgeu,                     lui,                      auipc
    else
        Branch <= 1'b0;
end

/*
 * This always part controls the signal BranchFlag.
 */
always @ (*) begin
    if (rst)
        BranchFlag <= 1'b0;
    else if (inst_i[6:0] == 7'b1101111 || inst_i[6:0] == 7'b1100111 || inst_i[6:0] == 7'b1100011 || inst_i[6:0] == 0110111 || inst_i[6:0] == 0010111 )
        BranchFlag <= 1'b1;  // jal,                         jalr,    beq,bne,blt,bge,bltu,bgeu,                     lui,                      auipc
    else
        BranchFlag <= 1'b0;
end

/*
 * This always part controls the signal Accept.
 */
always @ (*) begin
    if (rst)
        Accept <= 1'b0;
    else if (inst_i[6:0] == 7'b1100011)  // beq, bne, blt, bge, bltu, bgeu
        Accept <= 1'b1;
    else
        Accept <= 1'b0;
end

/*
 * This always part controls the signal WriteData, it decides if this instruction needs to write data of not.
 */
always @ (*) begin
    if (rst)
        WriteData <= 5'b0;
    else
        WriteData <= rd_addr;
end

/*
 * This always part controls the signal ReadAddr1, it gets the right rs1 number.
 */
always @ (*) begin
    if (rst)
        RegAddr1 <= 5'b0;
    else
        RegAddr1 <= rs1_addr;
end

/*
 * This always part controls the signal ReadAddr2, it gets the right rs2 number.
 */
always @ (*) begin
    if (rst)
        RegAddr2 <= 5'b0;
    else
        RegAddr2 <= rs2_addr;
end

/*
 * This always part controls the signal Reg1, it gets the right rs1 data.
 */
always @ (*) begin
    if (rst)
        Reg1 <= 32'b0;
    else if (RegRead1)
        Reg1 <= RegData1;
    else if (!RegRead1)
        Reg1 <= imm;
    else
        Reg1 <= 32'b0;
end

/*
 * This always part controls the signal Reg2, it gets the right rs2 data.
 */
always @ (*) begin
    if (rst)
        Reg2 <=  32'b0;
    else if (RegRead2)
        Reg2 <= RegData2;
    else if (!RegRead2)
        Reg2 <= imm;
    else
        Reg2 <= 32'b0;
end


/*
 * This always part controls the signal PredictFlag.
 */
always @ (*) begin
    if (rst)
        PredictFlag <= 1'b0;
    else if (inst_i[6:0] == 7'b1101111 || inst_i[6:0] == 7'b1100111 || inst_i[6:0] == 0110111 || inst_i[6:0] == 0010111)  
        PredictFlag <= 1'b1;// jal,                         jalr,                       lui,                      auipc
    else if (inst_i[6:0] == 7'b1100011)  // beq, bne, blt, bge, bltu, bgeu
        PredictFlag <= Predict ? 1'b1 : 1'b0;
    else
        PredictFlag <= 1'b0;
end

/*
 * This always part controls the signal StallBranch.
 */
always @ (*) begin
    if (rst)
        StallBranch <= 1'b0;
    else if (inst_i[6:0] == 7'b1101111 || inst_i[6:0] == 7'b1100111)  // jal and jalr
        StallBranch = 1'b1;
    else if (inst_i[6:0] == 7'b1100011)  // beq, bne, blt, bge, bltu, bgeu
        StallBranch <= 1'b1;
    else
        StallBranch <= 1'b0;
end

/*
 * This always part controls the signal StallReq1.
 */
always @ (*) begin
    if(PreInstLoad && RegRead1 && exWriteNum == RegAddr1)
	    StallReq1 <= 1'b1;
    else
        StallReq1 <= 1'b0;
end

/*
 * This always part controls the signal StallReq2.
 */
always @ (*) begin
    if(PreInstLoad && RegRead2 && exWriteNum == RegAddr2)
	    StallReq2 <= 1'b1;
    else
        StallReq2 <= 1'b0;
end	

endmodule