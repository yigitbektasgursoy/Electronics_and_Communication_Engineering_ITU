`timescale 1ns / 1ps
module tb;
    reg x; 
    reg clk;
    wire z;
    wire q0,q1,q2,q3,a,b; //debug for detector
    
//  FSM1 uut(x,clk,z);
//    FSM2 uut(x,clk,z);
   detector uut(x,clk,z,q0,q1,q2,q3,a,b);
    
    reg[15:0] testSignal =  16'b0010010000100100; //for detector
//  reg[15:0] testSignal =  16'b00010110100100100; //for detector
//    reg[41:0] testSignal = 41'b010011000111000011110000011111000000111111; // for FSM1,FSM2

    
    initial begin
        x = 0;
        clk = 0;
    end
    
    always #10 clk = !clk;
    
    always @(negedge clk) begin
        #5;
        testSignal = testSignal << 1;
        x = testSignal[15];
    end
endmodule
