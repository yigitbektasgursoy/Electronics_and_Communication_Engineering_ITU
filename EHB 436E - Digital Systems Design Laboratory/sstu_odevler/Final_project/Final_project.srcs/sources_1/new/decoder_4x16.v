`timescale 1ns / 1ps

module decoder_4x16(
    input [3:0] sel,
    input WE,
    output reg [15:0] out
    );
    
    always @(*) 
    begin
      if (WE)
         case (sel)
            4'b0000: out <= 16'd1;
            4'b0001: out <= 16'd2;
            4'b0010: out <= 16'd4;
            4'b0011: out <= 16'd8;
            4'b0100: out <= 16'd16;
            4'b0101: out <= 16'd32;
            4'b0110: out <= 16'd64;
            4'b0111: out <= 16'd128;
            4'b1000: out <= 16'd256;
            4'b1001: out <= 16'd512;
            4'b1010: out <= 16'd1024;
            4'b1011: out <= 16'd2048;
            4'b1100: out <= 16'd4096;
            4'b1101: out <= 16'd8192;
            4'b1110: out <= 16'd16324;
            4'b1111: out <= 16'd32648;
            default: out <= 16'd1;
         endcase
      end
    
    
endmodule
