module PPA
(
    input [31:0] PP0,
    input [31:0] PP1,
    input [31:0] PP2,
    input [31:0] PP3,
    input [31:0] PP4,
    input [31:0] PP5,
    input [31:0] PP6,
    input [31:0] PP7,
    input [31:0] PP8,
    input [31:0] PP9,
    input [31:0] PP10,
    input [31:0] PP11,
    input [31:0] PP12,
    input [31:0] PP13,
    input [31:0] PP14,
    input [31:0] PP15,
    output [31:0] CARRY,
    output [31:0] SUM
);
    
    wire [31:0] cout [8:0];
    wire [31:0] cin [7:0];
    wire [31:0] sum [7:0];
    
    Compressor_42 C1(PP0, PP1, PP2, PP3, 32'd0, cout[0], cin[0], sum[0]);
    Compressor_42 C2(PP4, PP5, PP6, PP7, cout[0], cout[1], cin[1], sum[1]);
    Compressor_42 C3(PP8, PP9, PP10, PP11, cout[1], cout[2], cin[2], sum[2]);
    Compressor_42 C4(PP12, PP13, PP14, PP15, cout[2], cout[3], cin[3], sum[3]);
    Compressor_42 C5(sum[0], cin[0], sum[1], cin[1], 32'd0, cout[4], cin[4], sum[4]);
    Compressor_42 C6(sum[2], cin[2], sum[3], cin[3], cout[4], cout[5], cin[5], sum[5]);
    Compressor_42 C7(sum[4], cin[4], sum[5], cin[5], 32'd0, cout[6], cin[6], sum[6]);
    Compressor_42 C8(cout[5], cout[3],32'd0, 32'd0, cout[6], cout[7], cin[7], sum[7]);
    Compressor_42 C9(sum[6], cin[6], sum[7], cin[7], cout[7], cout[8], CARRY, SUM);
endmodule