`timescale 1ns / 1ps

module mux_8x1_8bit(
    input [7:0] a0, a1, a2, a3, a4, a5, a6, a7,
    input [2:0] sel,
    output reg [7:0] out
    );
    always@(*) begin
    case (sel)
      3'b000 : begin
                  out <= a0;
               end
      3'b001 : begin
                  out <= a1;
               end
      3'b010 : begin
                  out <= a2;
               end
      3'b011 : begin
                  out <= a3;
               end
      3'b100 : begin
                  out <= a4;
               end
      3'b101 : begin
                  out <= a5;
               end
      3'b110 : begin
                  out <= a6;
               end
      3'b111 : begin
                  out <= a7;
               end
      default: begin
                  out <= a0;
               end
   endcase
   end
endmodule
