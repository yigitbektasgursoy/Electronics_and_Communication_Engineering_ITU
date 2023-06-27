`timescale 1ns / 1ps

module FU_tb();
    reg [31:0] A, B, imm, pc;
    reg [2:0] branch_in;
    reg [1:0] shift_type;
    reg [3:0] FSel;
    reg  MF_sel;
    reg sub, JAL, JALR;
    wire [31:0] F;
    wire V, C, N, Z;

    // Instantiate the FU module
    FU#(32) FU_inst (
        .A(A),
        .B(B),
        .imm(imm),
        .pc(pc),
        .branch_in(branch_in),
        .shift_type(shift_type),
        .FSel(FSel),
        .MF_sel(MF_sel),
        .sub(sub),
        .JAL(JAL),
        .JALR(JALR),
        .F(F),
        .V(V),
        .C(C),
        .N(N),
        .Z(Z)
    );

    // Testbench process
    initial begin
        // Initialize the inputs
        A = 32'h00000000;
        B = 32'h00000000;
        imm = 32'h00000000;
        pc = 32'h00000000;
        branch_in = 3'b000;
        shift_type = 2'b00;
        FSel = 4'b0000;
        MF_sel = 1'b0;
        sub = 1'b0;
        JAL = 1'b0;
        JALR = 1'b0;
        #10
        // Test ALU operations
         // Test AND
        FSel = 4'b0000;
        $display("Testing ALU operations");
        A = 32'hFFAB_C102;
        B = 32'hF50A_CE70;
        #10 $display("AND: %b & %b = %b, V: %b, C: %b, N: %b, Z: %b", A, B, F, V, C, N, Z);

        // Test OR
        A = 32'hF00B_C102;
        B = 32'h0F0A_C001;
        FSel = 4'b0010;
        sub = 1'b0;
        #10 $display("OR: %b | %b = %b, V: %b, C: %b, N: %b, Z: %b", A, B, F, V, C, N, Z);

        // Test XOR
        A = 32'hFFAB_C172;
        B = 32'h011A_C101;
        FSel = 4'b0100;
        #10 $display("XOR: %b ^ %b = %b, V: %b, C: %b, N: %b, Z: %b", A, B, F, V, C, N, Z);
        
        //Test ADD
        A = 32'hFFAB_C002;
        B = 32'h000A_CFF1;
        FSel = 4'b0110;
        #10 $display("ADD: %d & %d = %d, V: %b, C: %b, N: %b, Z: %b", A, B, F, V, C, N, Z);
        
        //TEST SUB
        sub=1'b1;
        FSel = 4'b0110;
        A = 32'hFFAD_C002;
        B = 32'h021A_CFF1;
        #10 $display("SUB: %d & %d = %d, V: %b, C: %b, N: %b, Z: %b", A, B, F, V, C, N, Z);
        // Test Shifter operations
        $display("Testing Shifter operations");
        MF_sel = 2'b01;
        A = 32'h0F;
        imm = 32'h02;
        
        // Test SLL
        shift_type = 2'b01;
        #10 $display("SLL: %b << %d = %b, V: %b, C: %b, N: %b, Z: %b", A, imm, F, V, C, N, Z);

        // Test SRL
        shift_type = 2'b10;
        #10 $display("SRL: %b >> %d = %b, V: %b, C: %b, N: %b, Z: %b", A, imm, F, V, C, N, Z);

        // Test SRA
        A = 32'hFFFFFFF0; // Negative value for testing SRA
        shift_type = 2'b11;
        #10 $display("SRA: %b >>> %d = %b, V: %b, C: %b, N: %b, Z: %b", A, imm, F, V, C, N, Z);

        // Test end
        $display("Testbench completed.");
        $finish;
    end
endmodule

