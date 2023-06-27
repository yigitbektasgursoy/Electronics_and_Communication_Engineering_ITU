`timescale 1ns / 1ps

module ALU(
    input [7:0] ALUinA, ALUinB,
    input [1:0] InsSel,
    output [7:0] ALUout,
    output CO,
    output Z
    );
    wire [7:0] AND_r, XOR_r, ADD_r, CLS_r, ALU_r;
    wire ADD_cout;
    
    ADD adder (
        .a(ALUinA),
        .b(ALUinB),
        .r(ADD_r),
        .cout(ADD_cout)
        );
    
    AND andop (
        .a(ALUinA),
        .b(ALUinB),
        .r(AND_r)
        );
    
    XOR xorop (
        .a(ALUinA),
        .b(ALUinB),
        .r(XOR_r)
        );
    
    Circular_Left_Shift clsop (
        .a(ALUinA),
        .r(CLS_r)
        );
    
    Zero_Comparator zecoop(
        .a(ALU_r),
        .Z(Z)
        );
    
    mux_4x1_1bit mux1(
        .a(1'b0),
        .b(1'b0),
        .c(ADD_cout),
        .d(CLS_r[0]),
        .sel(InsSel),
        .z(CO)
        );
        
    mux4x1_8bit mux2 (
        .a(AND_r),
        .b(XOR_r),
        .c(ADD_r),
        .d(CLS_r),
        .sel(InsSel),
        .z(ALU_r)
        );    
        assign ALUout = ALU_r;
endmodule
