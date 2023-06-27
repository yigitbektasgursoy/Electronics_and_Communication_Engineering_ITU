`timescale 1ns / 1ps

module RCA#(parameter size = 32)(x,y,ci,cout,s);

    input  [size-1:0] x;
    input  [size-1:0] y;
    input        ci;
    output       cout;
    output [size-1:0] s;
    
    
    wire [size:0] c;
    assign c[0] = ci;
    assign cout = c[size];
    genvar i;
    
    generate
        for(i=0;i < size;i=i+1) begin
            FA full_adder(
                .x(x[i]),
                .y(y[i]),
                .ci(c[i]),
                .cout(c[i+1]),
                .s(s[i]));
        end  
    endgenerate
   
endmodule
