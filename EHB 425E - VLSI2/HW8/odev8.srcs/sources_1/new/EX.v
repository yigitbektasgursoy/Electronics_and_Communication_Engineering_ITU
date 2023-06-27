
module EX(
    input   wire        rst,
    input   wire[5:0]   ALUop_i,
    input   wire[31:0]  Operand1,
    input   wire[31:0]  Operand2,
    input   wire[4:0]   WriteDataNum_i,
    input   wire        WriteReg_i,
    input   wire[31:0]  LinkAddr,
    input   wire[31:0]  inst_i,
    output  reg         WriteReg_o,
    output  wire[5:0]   ALUop_o,
    output  reg [4:0]   WriteDataNum_o,
    output  reg [31:0]  WriteData_o,
    output  wire[31:0]  MemAddr_o,
    output  wire[31:0]  Result
);

    assign ALUop_o   = ALUop_i;
    assign Result    = Operand2;
    assign MemAddr_o = Operand1 + ((inst_i[6:0] == 7'b0000011) ? {{20{inst_i[31]}}, inst_i[31:20]} : {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]});

    always @(*) begin
        WriteDataNum_o <= WriteDataNum_i;
    end

    always @(*) begin
        WriteReg_o <= WriteReg_i;
    end

    always @(*) begin
        if (rst)
            WriteData_o <= 32'b0;
        else begin
            case (ALUop_i)
                // R - TYPE
                6'b000000: WriteData_o <= Operand1 + Operand2; // add
                6'b000001: WriteData_o <= Operand1 - Operand2; // sub
                6'b000010: WriteData_o <= Operand1 ^ Operand2; // xor
                6'b000011: WriteData_o <= Operand1 | Operand2; // or
                6'b000100: WriteData_o <= Operand1 & Operand2; // and
                6'b000101: WriteData_o <= Operand1 << Operand2; // sll
                6'b000110: WriteData_o <= Operand1 >> Operand2; // srl
                6'b000111: WriteData_o <= Operand1 >>> Operand2; // sra
                6'b001000: WriteData_o <= (Operand1 < Operand2) ? 1 : 0; // slt
                6'b001001: WriteData_o <= (Operand1 < Operand2) ? 1 : 0; // sltu
                // I - TYPE
                6'b001010: WriteData_o <= Operand1 + Operand2; // addi
                6'b001011: WriteData_o <= Operand1 ^ Operand2; // xori
                6'b001100: WriteData_o <= Operand1 | Operand2; // ori
                6'b001101: WriteData_o <= Operand1 & Operand2; // andi
                6'b001110: WriteData_o <= Operand1 << Operand2[4:0]; // slli
                6'b001111: WriteData_o <= Operand1 >> Operand2[4:0]; // srli
                6'b010000: WriteData_o <= Operand1 >>> Operand2[4:0];// srai
                6'b010001: WriteData_o <= (Operand1 < Operand2) ? 1 : 0; // slti
                6'b010010: WriteData_o <= (Operand1 < Operand2) ? 1 : 0; // sltiu
                6'b010011: WriteData_o <= 32'b0; // lb
                6'b010100: WriteData_o <= 32'b0; // lh
                6'b010101: WriteData_o <= 32'b0; // lw
                6'b010110: WriteData_o <= 32'b0; // lbu
                6'b010111: WriteData_o <= 32'b0; // lhu
                6'b011000: WriteData_o <= LinkAddr; // jalr
                // S - TYPE
                6'b011001: WriteData_o <= 32'b0; // sb
                6'b011010: WriteData_o <= 32'b0; // sh
                6'b011011: WriteData_o <= 32'b0; // sw
                // B - TYPE
                6'b011100: WriteData_o <= LinkAddr; // beq
                6'b011101: WriteData_o <= LinkAddr; // bne
                6'b011110: WriteData_o <= LinkAddr; // blt
                6'b011111: WriteData_o <= LinkAddr; // bge
                6'b100000: WriteData_o <= LinkAddr; // bltu
                6'b100001: WriteData_o <= LinkAddr; // bgeu
                // J - TYPE
                6'b100010: WriteData_o <= LinkAddr; // jal
                // U - TYPE
                6'b100011: WriteData_o <= LinkAddr; // lui
                6'b100100: WriteData_o <= LinkAddr; // auipc
                default: WriteData_o <= 32'b0;
            endcase
        end
    end

endmodule
