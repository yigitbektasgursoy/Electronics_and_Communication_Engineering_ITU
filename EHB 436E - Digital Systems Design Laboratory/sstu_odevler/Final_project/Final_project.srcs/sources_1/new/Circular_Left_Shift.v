`timescale 1ns / 1ps

module Circular_Left_Shift(
    input [7:0] a,
    output [7:0]r 
    );
    
    assign r[0] = a[7];
    assign r[7:1] = a[6:0];
    
    
endmodule
