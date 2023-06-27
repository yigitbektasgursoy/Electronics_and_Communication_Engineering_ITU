`timescale 1ns / 1ps

module CSA #(parameter N = 32)
    (
    input [N-1:0] A, // kýsmý çarpan 1
    input [N-1:0] B, // kýsmý çarpan 2 
    input [N-1:0] C, // kýsmý çarpan 3
    
    output [N-1:0] SUM,
    output [N-1:0] CARRY    
    );
    
    assign SUM = A ^ B ^ C;
    assign CARRY[0] = 0;
    assign CARRY[N-1:1] = (A&B) | (A&C) | (B&C);
        
endmodule