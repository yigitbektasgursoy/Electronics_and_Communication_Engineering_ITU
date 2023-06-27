`timescale 1ns / 1ps

module Mux#(parameter WIDTH = 16, parameter DEPTH = 16)(
    input [$clog2(DEPTH)-1 : 0] addr,
    input [WIDTH*DEPTH-1 : 0] data_in,
    output [WIDTH-1 : 0] data_out );
   
    wire [WIDTH-1:0]inside[0:DEPTH-1] ;
    genvar i ;
   
    generate 
        for(i = 0; i < DEPTH; i=i+1) begin
             assign inside[i] = data_in[(i+1)*WIDTH-1 : i*WIDTH]; 
        end 
    endgenerate

    assign data_out = inside[addr];
endmodule