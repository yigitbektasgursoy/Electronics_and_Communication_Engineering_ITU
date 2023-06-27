`timescale 1ns / 1ps

module XOR(
    input [7:0] a, b,
    output [7:0]r 
    );
    
    assign r = a ^ b;
    
endmodule
