`timescale 1ns / 1ps
module FU#(parameter SIZE=32)(
    input [SIZE-1:0]A,
    input [SIZE-1:0]B,
    input [SIZE-1:0]imm,pc,
    input [2:0]branch_in,
    input [1:0]shift_type,
    input [3:0]FSel,
    input MF_sel,
    input sub,JAL,JALR,
    output reg [SIZE-1:0]F,
    output V,C,N,Z
    );
    
    wire [SIZE-1:0]ALU_OUT, SHIFT_OUT;
    wire BRANCH_OUT,CO;
    
    ALU#(.SIZE(32))ALU(
    .A(A),
    .B(B),
    .imm(imm),
    .pc(pc),
    .GSel(FSel),
    .branch_in(branch_in),
    .JAL(JAL),
    .JALR(JALR),
    .sub(sub),
    .G(ALU_OUT),
    .BRANCH_OUT(BRANCH_OUT), 
    .CO(CO), 
    .V(V), 
    .C(C), 
    .N(N), 
    .Z(Z));
    Shifter #(.SIZE(32))Shifter(
        .A(A),
        .B(B),
        .shamt(imm),
        .shift_type(shift_type),
        .SHIFT_OUT(SHIFT_OUT)
    );
    always @(*)
    begin
        case(MF_sel)
            1'b0:
            begin
                F=ALU_OUT;
            end
            1'b1:
            begin
                F=SHIFT_OUT;
            end
        endcase     
    end
endmodule