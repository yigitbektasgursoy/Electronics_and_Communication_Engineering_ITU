`timescale 1ns / 1ps


module Experiment4_tb();
endmodule

  //HALF ADDER TEST BENCH
 module HA_tb();
    reg X; 
    reg Y;
    wire COUT;
    wire SUM;
    HA DUT(.X(X),
           .Y(Y), 
           .COUT(COUT), 
           .S(SUM)
           );
    initial
    begin
        X = 1'b0 ; Y = 1'b0;
        #10 X = 1'b0 ; Y = 1'b1;
        #10 X = 1'b1 ; Y = 1'b0;
        #10 X = 1'b1 ; Y = 1'b1;
        #10 $finish;
    end
    endmodule
 
    
 
    //FULL ADDER TEST BENCH 
module FA_tb();  
    reg X;
    reg Y;
    reg CIN;
    
    wire COUT;
    wire SUM;
    FA DUT(.X(X),
           .Y(Y),
           .CIN(CIN), 
           .COUT(COUT), 
           .S(SUM)
           );
    initial
        begin
        X = 1'b0 ; Y = 1'b0; CIN = 1'b0;
        #10 X = 1'b0 ; Y = 1'b0; CIN = 1'b1;
        #10 X = 1'b0 ; Y = 1'b1; CIN = 1'b0;
        #10 X = 1'b0 ; Y = 1'b1; CIN = 1'b1;
        #10 X = 1'b1 ; Y = 1'b0; CIN = 1'b0;
        #10 X = 1'b1 ; Y = 1'b0; CIN = 1'b1;
        #10 X = 1'b1 ; Y = 1'b1; CIN = 1'b0;
        #10 X = 1'b1 ; Y = 1'b1; CIN = 1'b1;
        #10 $finish;
        end
    endmodule


 
    //RIPPLE CARRY ADDER TEST BENCH
module RCA_tb();
    reg [3:0]X;
    reg [3:0]Y;
    reg CIN;
    
    wire COUT;
    wire [3:0]SUM;
    
    RCA DUT(.X(X),
            .Y(Y),
            .CIN(CIN),
            .COUT(COUT),
            .S(SUM)
            );
    initial
        begin
        X = 4'b0000 ; Y = 4'b0000; CIN = 1'b0;
        #10 X = 4'b1110 ; Y = 4'b0011; CIN = 1'b1;
        #10 X = 4'b0110 ; Y = 4'b1100; CIN = 1'b0;
        #10 X = 4'b0011 ; Y = 4'b1010; CIN = 1'b1;
        #10 X = 4'b1000 ; Y = 4'b1111; CIN = 1'b0;
        #10 X = 4'b1111 ; Y = 4'b0101; CIN = 1'b1;
        #10 X = 4'b1001 ; Y = 4'b1100; CIN = 1'b0;
        #10 X = 4'b1101 ; Y = 4'b1111; CIN = 1'b1;
        #10 $finish;
        end
    endmodule

 //Ripple carry adder with generate for 

module parametric_RCA_tb();   
    parameter SIZE = 8 ;
    
    reg [SIZE-1:0]X;
    reg [SIZE-1:0]Y;
    reg CIN;
    
    wire COUT;
    wire [SIZE-1:0]S;
    
    parametric_RCA #(
                    .SIZE(SIZE)
                    )
    RCA(.X(X),
        .Y(Y),
        .CIN(CIN),
        
        .COUT(COUT),
        .S(S));
        
    initial
        begin
        X = 8'b10001110 ; Y = 8'b10100011; CIN = 1'b1;
        #10 X = 8'b01010110 ; Y = 8'b00111100; CIN = 1'b0;
        #10 X = 8'b01100011 ; Y = 8'b10001010; CIN = 1'b1;
        #10 X = 8'b00001000 ; Y = 8'b00101111; CIN = 1'b0;
        #10 X = 8'b01011111 ; Y = 8'b10000101; CIN = 1'b1;
        #10 $finish;
        end
endmodule 

    //CLA TEST BENCH
module CLA_tb();
    reg [3:0]X;
    reg [3:0]Y;
    reg CIN;
    
    wire COUT;
    wire [3:0]S;            
    
    CLA DUT(.X(X),
            .Y(Y),
            .CIN(CIN),
            
            .COUT(COUT),
            .S(S)
            );
    initial 
        begin
        X = 4'b0000 ; Y = 4'b0000; CIN = 1'b0;
        #10 X = 4'b1110 ; Y = 4'b0011; CIN = 1'b1;
        #10 X = 4'b0110 ; Y = 4'b1100; CIN = 1'b0;
        #10 X = 4'b0011 ; Y = 4'b1010; CIN = 1'b1;
        #10 X = 4'b1000 ; Y = 4'b1111; CIN = 1'b0;
        #10 X = 4'b1111 ; Y = 4'b0101; CIN = 1'b1;
        #10 X = 4'b1001 ; Y = 4'b1100; CIN = 1'b0;
        #10 X = 4'b1101 ; Y = 4'b1111; CIN = 1'b1;
        #10 $finish;
        end
    endmodule
    
module ADD_SUB_tb();

     reg [3:0]A;
     reg [3:0]B;
     reg CIN;
     
     wire COUT;
     wire V;
     wire [3:0] SUM;
     ADD_SUB AS
     (
     .A(A),
     .B(B),
     .CIN(CIN),
     
     .COUT(COUT),
     .V(V),
     .SUM(SUM)
     );
     initial
        begin
        A = 4'b0000; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b0001; B = 4'b0111; CIN = 1'b0;
        #10 A = 4'b0010; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b0011; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b0100; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b0101; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b0110; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b0111; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b1000; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b1001; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b1010; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b1011; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b1100; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b1101; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b1110; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b1111; B = 4'b0111; CIN = 1'b0; 
        #10 A = 4'b0000; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b0001; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b0010; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b0011; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b0100; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b0101; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b0110; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b0111; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b1000; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b1001; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b1010; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b1011; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b1100; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b1101; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b1110; B = 4'b0111; CIN = 1'b1; 
        #10 A = 4'b1111; B = 4'b0111; CIN = 1'b1; 
        $finish;
        end
    endmodule
   
   
        