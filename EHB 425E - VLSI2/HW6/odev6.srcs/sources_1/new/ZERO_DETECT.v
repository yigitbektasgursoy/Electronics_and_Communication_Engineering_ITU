`timescale 1ns / 1ps

module ZERO_DETECT(
    input [31:0]ALU_OUT,
    output reg Z
    );
    always @(*)
    begin
        if (ALU_OUT == 0)
            Z=1;
        else
            Z=0;
    end
endmodule
