`timescale 1ns / 1ps
module FSM2(
    input x,clk,
    //output reg z //moore
    output z //mealy
    );
    
    //moore
//    wire Q0,Q1,Q2,zTEMP,aTEMP;
//    reg q0,q1,q2,a;
    //mealy
    wire Q0,Q1,Q2,aTEMP;
    reg q0,q1,q2;
    
    //starting state
    initial begin
    // first state:000
   q0=0;
   q1=0;
   q2=0;
    //a=0; // moore
    end
    
    assign Q0=aTEMP&~q0&~q1;
    assign Q1=aTEMP&(q0|q1);
    assign Q2=~x;
    assign z=aTEMP&q1; //mealy
    assign aTEMP = x^q2;  //mealy
//    assign zTEMP=aTEMP&q1; //moore
//    assign aTEMP = x^q2;  //moore
    
    always @(posedge clk) begin
    q2 = Q2;
    q1 = Q1;
    q0 = Q0;
//    z = zTEMP; // moore
//    a = aTEMP; //moore
    end
endmodule

