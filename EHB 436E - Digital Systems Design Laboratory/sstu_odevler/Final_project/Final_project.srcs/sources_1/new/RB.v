`timescale 1ns / 1ps

module RB(
    input [7:0] InA, InB, CUconst, ALUout,
    input [3:0] RegAdd, OutMuxAdd,
    input [2:0] InMuxAdd,
    input WE, clk, reset,
    output [7:0] Out, ALUinA, ALUinB
    );
    
    wire [7:0] RegBlocksOut [15:0];
    wire [15:0] DecoderOut; 
    wire [7:0] RegBlocksIn, RegOut; 
    
    decoder_4x16 decoder1 (.sel(RegAdd), .WE(WE), .out(DecoderOut));
    mux_8x1_8bit InMux (.a0(InA), .a1(InB), .a2(CUconst), .a3(ALUout), .a4(RegOut), .a5(RegOut), .a6(RegOut), .a7(RegOut), .sel(InMuxAdd), .out(RegBlocksIn));
    Registers reg0 (.En(DecoderOut[0]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[0][7:0]));
    Registers reg1 (.En(DecoderOut[1]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[1][7:0]));
    Registers reg2 (.En(DecoderOut[2]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[2][7:0]));
    Registers reg3 (.En(DecoderOut[3]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[3][7:0]));
    Registers reg4 (.En(DecoderOut[4]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[4][7:0]));
    Registers reg5 (.En(DecoderOut[5]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[5][7:0]));
    Registers reg6 (.En(DecoderOut[6]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[6][7:0]));
    Registers reg7 (.En(DecoderOut[7]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[7][7:0]));
    Registers reg8 (.En(DecoderOut[8]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[8][7:0]));
    Registers reg9 (.En(DecoderOut[9]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[9][7:0]));
    Registers reg10 (.En(DecoderOut[10]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[10][7:0]));
    Registers reg11 (.En(DecoderOut[11]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[11][7:0]));
    Registers reg12 (.En(DecoderOut[12]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[12][7:0]));
    Registers reg13 (.En(DecoderOut[13]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[13][7:0]));
    Registers reg14 (.En(DecoderOut[14]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[14][7:0]));
    Registers reg15 (.En(DecoderOut[15]), .clk(clk), .reset(reset), .Rin(RegBlocksIn), .Rout(RegBlocksOut[15][7:0]));
    
    assign Out = RegBlocksOut[0][7:0];
    assign ALUinA = RegBlocksOut[1][7:0];
    assign ALUinB = RegBlocksOut[2][7:0];

    mux_16x1_8bit OutMux(
        .a0(RegBlocksOut[0][7:0]),
        .a1(RegBlocksOut[1][7:0]),
        .a2(RegBlocksOut[2][7:0]),
        .a3(RegBlocksOut[3][7:0]),
        .a4(RegBlocksOut[4][7:0]),
        .a5(RegBlocksOut[5][7:0]),
        .a6(RegBlocksOut[6][7:0]),
        .a7(RegBlocksOut[7][7:0]),
        .a8(RegBlocksOut[8][7:0]),
        .a9(RegBlocksOut[9][7:0]),
        .a10(RegBlocksOut[10][7:0]),
        .a11(RegBlocksOut[11][7:0]),
        .a12(RegBlocksOut[12][7:0]),
        .a13(RegBlocksOut[13][7:0]),
        .a14(RegBlocksOut[14][7:0]),
        .a15(RegBlocksOut[15][7:0]),
        .sel(OutMuxAdd),
        .out(RegOut)
        );
endmodule
