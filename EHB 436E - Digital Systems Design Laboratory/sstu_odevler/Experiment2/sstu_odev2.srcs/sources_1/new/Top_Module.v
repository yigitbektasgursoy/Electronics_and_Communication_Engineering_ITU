`timescale 1ns / 1ps
module Top_Module(
    input [7:0]SW,
    input [3:0]BTN,
    output [7:0]LED,
    output [6:0]CAT,
    output [3:0]AN,
    output [0:0]DP
    );
/*
    DECODER DECODER1(
    .IN(SW[3:0]),
    .OUT({DP,CAT,LED})
    );
    
*/    

/*  ENCODER ENCODER1(
    .IN(SW[3:0]),
    .OUT(LED[1:0]),
    .V(LED[7])
    );
    assign AN = 4'b1111;
    */
/*
   MUX MUX1(
    .D(SW[3:0]),
    .S(BTN[1:0]),
    .O(LED[0]));
    assign AN = 4'b1110;
*/
    DEMUX DEMUX1(
    .D(SW[0]),
    .S(BTN[1:0]),
    .O(LED[3:0]));

endmodule