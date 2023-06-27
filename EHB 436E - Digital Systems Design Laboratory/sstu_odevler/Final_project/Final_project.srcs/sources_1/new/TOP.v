`timescale 1ns / 1ps

module TOP(
    input clk, reset, Start, 
    input [7:0] InA, InB,
    output Busy,
    output [7:0]Out
    );
    
    wire we, co, z;
    wire [1:0] inssel;
    wire [2:0] inmuxadd;
    wire [3:0] outmuxadd, regadd;
    wire [7:0] cuconst, aluina, aluinb, aluout; 
    
    ALU ArithmeticLogicUnit (
        .InsSel(inssel),
        .ALUinA(aluina),
        .ALUinB(aluinb),
        .Z(z),
        .CO(co),
        .ALUout(aluout)
        );
    
    RB RegistersBlock (
        .clk(clk),
        .reset(reset),
        .InA(InA),
        .InB(InB),
        .WE(we),
        .CUconst(cuconst),
        .InMuxAdd(inmuxadd),
        .OutMuxAdd(outmuxadd),
        .RegAdd(regadd),
        .ALUinA(aluina),
        .ALUinB(aluinb),
        .ALUout(aluout),
        .Out(Out)
        );
     
     CU ControlUnit(
        .clk(clk),
        .reset(reset),
        .Start(Start),
        .InA(InA),
        .InB(InB),
        .CO(co),
        .Z(z),
        .Busy(Busy),
        .CUconst(cuconst),
        .InMuxAdd(inmuxadd),
        .OutMuxAdd(outmuxadd),
        .RegAdd(regadd),
        .WE(we),
        .InsSel(inssel)
        );   
        
    
endmodule
