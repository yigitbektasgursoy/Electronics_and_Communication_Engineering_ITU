`timescale 1ns/1ps

    module CLA (
                A, 
                B, 
                CIN, 
                SUM, 
                COUT);
    parameter SIZE = 32;

    input [SIZE - 1:0] A;
    input [SIZE - 1:0] B;
    input CIN;
    output [SIZE - 1:0] SUM;
    output COUT;

//assign {carry_out, sum} = A + B + CIN;

        wire [SIZE - 1:0] G;
        wire [SIZE - 1:0] P;
        wire [SIZE:0] C;

        genvar j, i;
        generate
 //assume C in is zero
        assign C[0] = CIN;
 
 //carry generator
        for(j = 0; j < SIZE; j = j + 1) begin: carry_generator
            assign G[j] = A[j] & B[j];
            assign P[j] = A[j] | B[j];
            assign C[j+1] = G[j] | P[j] & C[j];
        end
 
 //carry out 
        assign COUT = C[SIZE];
 
 //calculate sum 
 //assign sum[0] = A[0] ^ B ^ CIN;
        for(i = 0; i < SIZE; i = i+1) begin: sum_without_carry
            assign SUM[i] = A[i] ^ B[i] ^ C[i];
        end 
    endgenerate 
endmodule