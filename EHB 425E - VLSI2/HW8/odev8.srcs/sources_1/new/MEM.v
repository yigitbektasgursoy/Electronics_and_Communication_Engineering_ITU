module MEM (

    input   wire        rst,
    input   wire        WriteReg_i,
    input   wire[4:0]   WriteDataAddr_i,
    input   wire[5:0]   ALUop_i,
    input   wire[31:0]  WriteData_i,
    input   wire[31:0]  MemAddr_i,
    input   wire[31:0]  Reg_i,
    input   wire[31:0]  MemData_i,
    output  wire        MemWE_o,
    output  reg         WriteReg_o,
    output  reg         MemCE_o,
    output  reg [4:0]   WriteDataAddr_o,
    output  reg [31:0]  WriteData_o,
    output  reg [31:0]  MemAddr_o,
    output  reg [31:0]  MemData_o

);

    reg mem_we;
    assign MemWE_o = mem_we;

/*
 * This always part controls the signal WriteDataAddr_o.
 */ 
always @ (*) begin
    if (rst)
        WriteDataAddr_o <= 5'b0;
    else
        WriteDataAddr_o <= WriteDataAddr_i;
end

/*
 * This always part controls the signal WriteReg_o.
 */ 
always @ (*) begin
    if (rst)
        WriteReg_o <= 1'b0;
    else
        WriteReg_o <= WriteReg_i;
end

/*
 * This always part controls the signal MemData_o.
 */ 
always @ (*) begin
    if (rst)
        MemData_o <= 32'b0;
    else begin
        if (ALUop_i == 6'b010000 || ALUop_i == 6'b010001 || ALUop_i == 6'b010010)  // sb, sh, sw
            MemData_o <= Reg_i;
        else
            MemData_o <= 32'b0;
    end
end

/*
 * This always part controls the signal WriteData_o.
 */ 
always @ (*) begin
    if (rst)
        WriteData_o <= 32'b0;
    else begin
        if (ALUop_i == 6'b010011)  // lb
            WriteData_o <= {24'b0, MemData_i[7:0]};
        else if (ALUop_i == 6'b010100)  // lh
            WriteData_o <= {16'b0, MemData_i[15:0]};
        else if (ALUop_i == 6'b010101)  // lw
            WriteData_o <= MemData_i;
        else if (ALUop_i == 6'b010110)  // lbu
            WriteData_o <= {24'b0, MemData_i[7:0]};
        else if (ALUop_i == 6'b010111)  // lhu
            WriteData_o <= {16'b0, MemData_i[15:0]};
        else
            WriteData_o <= WriteData_i;
    end
end

/*
 * This always part controls the signal MemAddr_o.
 */ 
always @ (*) begin
    if (rst)
        MemAddr_o <= 32'b0;
    else begin
        if (ALUop_i == 6'b010111 || ALUop_i == 6'b010110 || ALUop_i == 6'b010101 || ALUop_i == 6'b010100 || ALUop_i == 6'b010011 || ALUop_i == 6'b010010 || ALUop_i == 6'b010001 || ALUop_i == 6'b010000)  // lhu, lbu, lw, lh, lb, sw, sh, sb
            MemAddr_o <= MemAddr_i;
        else
            MemAddr_o <= 32'b0;
    end
end

/*
 * This always part controls the signal MemCE_o.
 */ 
always @ (*) begin
    if (rst)
        MemCE_o <= 1'b0;
    else begin
        if (ALUop_i == 6'b010111 || ALUop_i == 6'b010110 || ALUop_i == 6'b010101 || ALUop_i == 6'b010100 || ALUop_i == 6'b010011 || ALUop_i == 6'b010010 || ALUop_i == 6'b010001 || ALUop_i == 6'b010000)  // lhu, lbu, lw, lh, lb, sw, sh, sb
            MemCE_o <= 1'b1;
        else
            MemCE_o <= 1'b0;
    end
end

/*
 * This always part controls the signal mem_we.
 */ 
always @ (*) begin
    if (rst)
        mem_we <= 1'b0;
    else begin
        if (ALUop_i == 6'b010011 || ALUop_i == 6'b010100 || ALUop_i == 6'b010101 || ALUop_i == 6'b010110 || ALUop_i == 6'b010111)  // lb, lh, lw, lbu, lhu
            mem_we <= 1'b0;
        else if (ALUop_i == 6'b010010 || ALUop_i == 6'b010001 || ALUop_i == 6'b010000)  // sw, sh, sb
            mem_we <= 1'b1;
        else
            mem_we <= 1'b0;
    end
end

endmodule
