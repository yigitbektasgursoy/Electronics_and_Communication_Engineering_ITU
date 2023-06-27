`timescale 1ns / 1ps

module mux4x1_8bit(
    input [7:0] a, b, c, d,
    input [1:0] sel,
    output reg [7:0] z
    );
    
    always@(*)
    begin
       case (sel)
      2'b00  : z <= a;
      2'b01  : z <= b;
      2'b10  : z <= c;
      2'b11  : z <= d;
   endcase    
    end
endmodule
