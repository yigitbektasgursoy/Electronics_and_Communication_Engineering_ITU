`timescale 1ns / 1ps

module CU#(parameter SIZE = 32)(
    input wire clk,
    input wire reset,
    input wire [SIZE-1:0] instruction,
    input wire [SIZE-1:0] IMM_rs,
    input wire Z,
    input wire N,
    output [SIZE-1:0] PC_Addr,
    output [SIZE-1:0] IMM,
    output [2:0] Mem_type_sel,
    output  [$clog2(SIZE)-1 : 0] AA,
    output  [$clog2(SIZE)-1 : 0] BA,
    output  [$clog2(SIZE)-1 : 0] DA,
    output  we,
    output  MR,
    output  MD,
    output  MB,
    output  [3:0] FS
);

    wire [2:0] IMM_sel;
    wire [2:0] Branch_sel;
    wire MPC; // Branch/Jump control
    wire JALR; // Jump and link register control

    // Instantiate the Branch Controller
    Branch_Controller branch_controller(
        .Branch_sel(Branch_sel), 
        .Z(Z),
        .N(N),
        .MPC(MPC),
        .JALR(JALR)
    );

    // Instantiate the Instruction Decoder
    Instruction_decoder#(.size(SIZE)) instruction_decoder(
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

    // Instantiate the Program Counter
    ProgramCounter#(.SIZE(SIZE)) program_counter(
        .clk(clk),
        .reset(reset),
        .MPC(MPC),
        .JALR(JALR),
        .IMM(IMM),
        .IMM_rs(IMM_rs),
        .PC_out(PC_Addr)
    );
endmodule
