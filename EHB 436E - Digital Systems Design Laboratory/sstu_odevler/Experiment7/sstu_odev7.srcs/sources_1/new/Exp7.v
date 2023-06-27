`timescale 1ns / 1ps

module Exp7();
endmodule


module MULTS
    (
    input [7:0] A,
    input [7:0] X,
    output [15:0]result
    );
    
    wire [15:0]PP[7:0];
 
    genvar i;
    generate
        for(i = 0; i <= 7; i = i + 1)
        begin: PP_LOOP //PARTIAL PRODUCT
            assign PP[i][15:0] = (X[i] * A) << i;
        end
    endgenerate
    
    wire [15:0] sum [6:0];
    wire cout [6:0];
    
    // sum of partial product
    CLA CLA1(PP[0][15:0], PP[1][15:0], 0, cout[0], sum[0][15:0]); 
    CLA CLA2(PP[2][15:0], PP[3][15:0], 0, cout[1], sum[1][15:0]); 
    CLA CLA3(PP[4][15:0], PP[5][15:0], 0, cout[2], sum[2][15:0]); 
    CLA CLA4(PP[6][15:0], PP[7][15:0], 0, cout[3], sum[3][15:0]);
    
    // sum of result of partial product
    CLA CLA5(sum[0][15:0], sum[1][15:0], 0, cout[4], sum[4][15:0]); 
    CLA CLA6(sum[2][15:0], sum[3][15:0], 0, cout[5], sum[5][15:0]); 
    CLA CLA7(sum[4][15:0], sum[5][15:0], 0, cout[6], sum[6][15:0]); 
    assign result[15:0] = sum[6][15:0];
endmodule


module MULTS_signed
    (
    input [7:0] A,
    input [7:0] X,
    output [15:0] result
    );
    
    wire [7:0] PP [7:0];
    wire [7:0] PP_BW [7:0];
    wire [15:0] PP_shift [7:0];
 
    genvar i;
    generate
        for(i = 0; i <= 7; i = i + 1)
        begin: PP_LOOP
            assign PP[i][7:0] = (X[i] * A);
        end
    endgenerate
 
    genvar z, t;
    generate
        for(z = 0; z <= 7; z = z + 1)
        begin: PP_BW_LOOP
            for(t = 0; t <= 7; t = t + 1)        
            begin
                if(z != 7)
                begin
                    if(t != 7) 
                        assign PP_BW[z][t] = PP[z][t];
                    else
                        assign PP_BW[z][t] = ~PP[z][t];
                end
            else
            begin
                if(t == 7)
                    assign PP_BW[z][t] = PP[z][t];
                else
                    assign PP_BW[z][t] = ~PP[z][t];
                end
            end
        end 
    endgenerate
    
    genvar j;
    generate
    for(j = 0; j <= 7; j = j + 1)
    begin: PP_SHIFT_LOOP
        assign PP_shift[j][15:0] = PP_BW[j] << j;
    end
    endgenerate
 
    wire [15:0] sum [7:0];
    wire cout [7:0];
 
    CLA CLA1(PP_shift[0][15:0], PP_shift[1][15:0], 0, cout[0], sum[0][15:0]); 
    CLA CLA2(PP_shift[2][15:0], PP_shift[3][15:0], 0, cout[1], sum[1][15:0]); 
    CLA CLA3(PP_shift[4][15:0], PP_shift[5][15:0], 0, cout[2], sum[2][15:0]); 
    CLA CLA4(PP_shift[6][15:0], PP_shift[7][15:0], 0, cout[3], sum[3][15:0]);
    
    CLA CLA5(sum[0][15:0], sum[1][15:0], 0, cout[4], sum[4][15:0]); 
    CLA CLA6(sum[2][15:0], sum[3][15:0], 0, cout[5], sum[5][15:0]); 
    CLA CLA7(sum[4][15:0], sum[5][15:0], 0, cout[6], sum[6][15:0]); 
    CLA CLA8(sum[6][15:0], 16'b1000000100000000, 0, cout[7], sum[7][15:0]);
    assign result[15:0] = sum[7][15:0];
endmodule


module MULTB

    (
    input signed [7:0] A,
    input signed [7:0] B,
    output reg signed [15:0] result
    );
    always @ *
    begin
        result <= A * B;
    end
endmodule


module MAC
    (
    input clk,
    input reset,
    input signed [23:0] data,
    input signed [23:0] weight,
    output reg signed [15:0] result
    );
    
    wire signed [15:0] product [2:0];
    wire signed [15:0] sum [1:0];
    reg [1:0] count;
    
    MULTB MULT0(data[7:0], weight[7:0], product[0][15:0]);
    
    MULTB MULT1(data[15:8], weight[15:8], product[1][15:0]);
    
    MULTB MULT2(data[23:16], weight[23:16], product[2][15:0]);
    
    Behav_Adder ADD1(product[0][15:0], product[1][15:0], sum[0][15:0]);
    
    Behav_Adder ADD2(product[2][15:0], sum[0][15:0], sum[1][15:0]);
    
    always @ (posedge clk or posedge reset)
    begin
        if(reset)
        begin
            count <= 0;
            result <= 0;
        end
        else
        begin
            result <= result + sum[1][15:0];
            count <= count + 1;
        end
    end 
endmodule

module Conv

    (
    input clk,
    input reset,
    input signed [23:0] data,
    input signed [23:0] weight,
    output signed [15:0] result
    );
    
    MAC MAC
    (
    .clk(clk),
    .reset(reset),
    .data(data),
    .weight(weight),
    .result(result)
    );
endmodule
