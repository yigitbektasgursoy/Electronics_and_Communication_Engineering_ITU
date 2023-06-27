`timescale 1ns / 1ps

module AND(
    input [7:0] a, b,
    output [7:0]r 
    );
    
    assign r = a & b;
    
endmodule
