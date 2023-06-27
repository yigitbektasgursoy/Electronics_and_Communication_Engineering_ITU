module FSM1(
    input x,clk,
    //output reg z //moore
    output z //mealy
    );
    
    wire Q0,Q1,Q2,zTEMP;
    reg q0,q1,q2;
    
    //starting state
    initial begin
    // first state:000
   q0=0;
   q1=0;
   q2=0;
    end
    
    assign Q0=(x&~q1)|(~q0&~q1&~q2)|(x&~q0);
    assign Q1=(q1&~q0)|(q0&~q1&~q2)|(x&~q2&~q1);
    assign Q2=(x&q2)|(x&q0&q1);
    //assign zTEMP=(x&q0&q2)|(~x&q1&~q0); //moore
    assign z=(x&q0&q2)|(~x&q1&~q0); //mealy
    
    always @(posedge clk) begin
    q2 <= Q2;
    q1 <= Q1;
    q0 <= Q0;
    //z = zTEMP; //moore machine
    end
endmodule

