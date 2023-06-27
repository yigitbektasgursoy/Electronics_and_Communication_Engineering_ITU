`timescale 1ns / 1ps
  
    module PP
    (
    input [15:0] A,
    input [15:0] B,
	
    output [31:0]PP0,
    output [31:0]PP1,
    output [31:0]PP2, 
    output [31:0]PP3,
    output [31:0]PP4,
    output [31:0]PP5,
    output [31:0]PP6,
    output [31:0]PP7,
    output [31:0]PP8,
    output [31:0]PP9,
    output [31:0]PP10,
    output [31:0]PP11,
    output [31:0]PP12,
    output [31:0]PP13,
    output [31:0]PP14,
    output [31:0]PP15
    );
    
    wire [31:0]PP[15:0];
 
    genvar i;
    generate
        for(i = 0; i <= 15; i = i + 1)
        begin: PP_LOOP //PARTIAL PRODUCT
            assign PP[i][31:0] = {16'h0000,(A[i] * B)} << i;
        end
	endgenerate
	 	
	assign PP0 = PP[0][31:0];
    assign PP1 = PP[1][31:0];
    assign PP2 = PP[2][31:0];
    assign PP3 = PP[3][31:0];
    assign PP4 = PP[4][31:0];
    assign PP5 = PP[5][31:0];
    assign PP6 = PP[6][31:0];
    assign PP7 = PP[7][31:0];
    assign PP8 = PP[8][31:0];
    assign PP9 = PP[9][31:0];
    assign PP10 = PP[10][31:0];
    assign PP11 = PP[11][31:0];
    assign PP12 = PP[12][31:0];
    assign PP13 = PP[13][31:0];
    assign PP14 = PP[14][31:0];
    assign PP15 = PP[15][31:0];	
		
endmodule























































/*
module PP(
    input [15:0]A,
    input [15:0]B,
    
    output [31:0]PP0,
    output [31:0]PP1,
    output [31:0]PP2, 
    output [31:0]PP3,
    output [31:0]PP4,
    output [31:0]PP5,
    output [31:0]PP6,
    output [31:0]PP7,
    output [31:0]PP8,
    output [31:0]PP9,
    output [31:0]PP10,
    output [31:0]PP11,
    output [31:0]PP12,
    output [31:0]PP13,
    output [31:0]PP14,
    output [31:0]PP15
    );
    
    reg [31:0] parp [15:0];
    integer i;
   
    always @ (*)
    begin
        for ( i = 0; i <= 31; i = i+1)
        begin
            if ( B[i] == 1'b1 )
                parp[i] = {16'b0,A} <<i;    
            else
                parp[i] = 32'h00000000;      
        end
    end
    
    assign PP0 = parp[0][31:0];
    assign PP1 = parp[1][31:0];
    assign PP2 = parp[2][31:0];
    assign PP3 = parp[3][31:0];
    assign PP4 = parp[4][31:0];
    assign PP5 = parp[5][31:0];
    assign PP6 = parp[6][31:0];
    assign PP7 = parp[7][31:0];
    assign PP8 = parp[8][31:0];
    assign PP9 = parp[9][31:0];
    assign PP10 = parp[10][31:0];
    assign PP11 = parp[11][31:0];
    assign PP12 = parp[12][31:0];
    assign PP13 = parp[13][31:0];
    assign PP14 = parp[14][31:0];
    assign PP15 = parp[15][31:0];
      
endmodule
*/

