`timescale 1ns / 1ps

module Instruction_decoder_tb;

    reg [31:0] instruction;
    wire [2:0] IMM_sel;
    wire [2:0] Branch_sel;
    wire [2:0] Mem_type_sel;
    wire [4:0] AA;
    wire [4:0] BA;
    wire [4:0] DA;
    wire we;
    wire MR;
    wire MD;
    wire MB;
    wire [3:0] FS;

    // Instantiate the module
    Instruction_decoder #(32) u1 (
        .instruction(instruction),
        .IMM_sel(IMM_sel),
        .Branch_sel(Branch_sel),
        .Mem_type_sel(Mem_type_sel),
        .AA(AA),
        .BA(BA),
        .DA(DA),
        .we(we),
        .MR(MR),
        .MD(MD),
        .MB(MB),
        .FS(FS)
    );

    // Testbench logic
    initial begin
        $dumpfile("Instruction_decoder_tb.vcd");
        $dumpvars(0, Instruction_decoder_tb);

        instruction = 32'b0000000_00011_00100_000_00111_0110011;#10; //ADD 
        instruction = 32'b0100000_00111_00100_000_00011_0110011; #10; //SUB 
        instruction = 32'b0000000_00001_00010_100_00011_0110011; #10; // XOR
        instruction = 32'b0000000_00000_00000_001_00000_0110011; #10; //SLL
        instruction = 32'b0000000_00000_00000_000_00000_0010011; #10; //ADDI
        instruction = 32'b0000000_00000_00000_000_00000_0100011; #10; //SB
        instruction = 32'b0000000_00000_00000_000_00000_1100011; #10; // BEQ
        instruction = 32'b0000000_00000_00000_000_00000_1101111; #10; // JAL
        #10;
        $finish;
    end

endmodule
