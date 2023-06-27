`timescale 1ns / 1ps

module Registers(
    input clk, reset, En,
    input [7:0] Rin,
    output [7:0] Rout
    );
    
    reg [7:0] kaydedici;
    assign Rout = kaydedici;
    
    
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            kaydedici <= 0;
        end
        else begin
            if (En) begin
                kaydedici <= Rin;
            end
//            else begin
//                Rout <= kaydedici;
//            end    
        end
    end
endmodule
