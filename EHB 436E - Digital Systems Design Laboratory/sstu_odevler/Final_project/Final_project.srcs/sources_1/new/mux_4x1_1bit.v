`timescale 1ns / 1ps
module mux_4x1_1bit(
    input a, b, c, d,
    input [1:0] sel, 
    output z
    );
    assign z = sel[1] ? (sel[0] ? (d):(c)):(sel[0] ? (b):(a));
endmodule
