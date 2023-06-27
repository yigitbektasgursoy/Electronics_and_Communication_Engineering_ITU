`timescale 1ns / 1ps

(* DONT_TOUCH = "TRUE" *)
module Wallace_Tree_Mult(
    input [15:0]A,
    input [15:0]B,
    output [31:0]C,
    output carry
    );
    
    wire  [31:0] pp [15:0];
    
    PP partial_products( 
        A, 
        B, 
        pp[0][31:0],
        pp[1][31:0],
        pp[2][31:0],
        pp[3][31:0],
        pp[4][31:0],
        pp[5][31:0],
        pp[6][31:0],
        pp[7][31:0],
        pp[8][31:0],
        pp[9][31:0],
        pp[10][31:0],
        pp[11][31:0],
        pp[12][31:0],
        pp[13][31:0],
        pp[14][31:0],
        pp[15][31:0]
        );
    
    // STAGE1
    wire [31:0] sum_s11, carry_s11, sum_s12, carry_s12, sum_s13, carry_s13, sum_s14, carry_s14, sum_s15, carry_s15;
    CSA s11 (pp[0][31:0], pp[1][31:0], pp[2][31:0], sum_s11[31:0], carry_s11[31:0]);
	CSA s12 (pp[3][31:0], pp[4][31:0], pp[5][31:0], sum_s12[31:0], carry_s12[31:0]);
	CSA s13 (pp[6][31:0], pp[7][31:0], pp[8][31:0], sum_s13[31:0], carry_s13[31:0]);
	CSA s14 (pp[9][31:0], pp[10][31:0], pp[11][31:0], sum_s14[31:0], carry_s14[31:0]);
	CSA s15 (pp[12][31:0], pp[13][31:0], pp[14][31:0], sum_s15[31:0], carry_s15[31:0]);
	
	//STAGE2
	wire [31:0] sum_s21, carry_s21, sum_s22, carry_s22, sum_s23, carry_s23;
    CSA s21 (sum_s11[31:0], carry_s11[31:0], sum_s12[31:0], sum_s21[31:0], carry_s21[31:0]);
	CSA s22 (carry_s12[31:0], sum_s13[31:0], carry_s13[31:0], sum_s22[31:0], carry_s22[31:0]);
	CSA s23 (sum_s14[31:0], carry_s14[31:0], sum_s15[31:0], sum_s23[31:0], carry_s23[31:0]);
	
	//STAGE3
	wire [31:0] sum_s31, carry_s31, sum_s32, carry_s32;
    CSA s31 (sum_s21[31:0], carry_s21[31:0], sum_s22[31:0], sum_s31[31:0], carry_s31[31:0]);
	CSA s32 (carry_s22[31:0], sum_s23[31:0], carry_s23[31:0], sum_s32[31:0], carry_s32[31:0]);
	
	//STAGE4
	wire [31:0] sum_s41, carry_s41, sum_s42, carry_s42;
    CSA s41 (sum_s31[31:0], carry_s31[31:0], sum_s32[31:0], sum_s41[31:0], carry_s41[31:0]);
	CSA s42 (carry_s32[31:0], carry_s15[31:0], pp[15][31:0], sum_s42[31:0], carry_s42[31:0]);
	
	//STAGE5
	wire [31:0] sum_s51, carry_s51;
    CSA s51 (sum_s41[31:0], carry_s41[31:0], sum_s42[31:0], sum_s51[31:0], carry_s51[31:0]);
    
    //STAGE6
 	wire [31:0] sum_s61, carry_s61;
    CSA s61 (sum_s51[31:0], carry_s51[31:0], carry_s42[31:0], sum_s61[31:0], carry_s61[31:0]);   
    
    CLA Carry_Lookahead_Adder(
        .A(sum_s61),
        .B(carry_s61),
        .CIN(1'b0),
        .COUT(carry),
        .SUM(C)
        );
    
    //assign C = sum_s61 + carry_s61;
	//assign carry = 1'b0; // 16 bit iki sayý çarpýldýðýnda carry'ye gerek kalmýyor    
endmodule
