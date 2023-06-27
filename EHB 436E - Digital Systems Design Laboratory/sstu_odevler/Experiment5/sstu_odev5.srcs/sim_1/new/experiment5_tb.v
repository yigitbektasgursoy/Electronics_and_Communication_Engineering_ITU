`timescale 1ns / 1ps

module experiment5_tb();
endmodule

module SR_LATCH_tb();
    reg S;
    reg R;
    wire Q;
    wire Qn;
    
    SR_LATCH DUT(.S(S),
                 .R(R),
                 
                 .Q(Q),
                 .Qn(Qn)
                 );
    initial
        begin
            S = 1'b1; R = 1'b0;
            #10 S = 1'b1; R = 1'b1;
            #10 S = 1'b0; R = 1'b1;
            #10 S = 1'b1; R = 1'b1;
            #10 S = 1'b0; R = 1'b0;
            #10 $finish;
        end          
endmodule

module D_FLIP_FLOP_tb();

   reg D;
   reg CLK;
   
   wire Q;
   wire Qn;
   
   D_FLIP_FLOP DUT(
               .D(D),
               .CLK(CLK),
               .Q(Q),
               .Qn(Qn)
               );
   initial
       begin
            D = 1'b0; CLK = 1'b0;
            #5  D = 1'b0; #10 CLK = 1'b1;
            #15 D = 1'b1; #10 CLK = 1'b0;
            #25 D = 1'b1; #10 CLK = 1'b1;
            #10 $finish;
       end
endmodule

module MASTER_SLAVE_DFF_tb();

    reg D;
    reg CLK;
    
    wire Qs;
    wire Qs_NOT;
    
    MASTER_SLAVE_DFF DUT(
                        .D(D),
                        .CLK(CLK),
                        
                        .Qs(Qs),
                        .Qs_NOT(Qs_NOT)
                        );

    initial
        begin
            D = 1'b0; CLK = 1'b0;
            #10 D = 1'b0; #25 CLK = 1'b1;
            #10 D = 1'b1; #15 CLK = 1'b0;
            #10 D = 1'b1; #10 CLK = 1'b1;
            #10 D = 1'b0; #15 CLK = 1'b0;
            #10 D = 1'b1; #15 CLK = 1'b1;
            #10 D = 1'b1; #15 CLK = 1'b0;
            #10 $finish;    
        end
endmodule

module BEHAVIORAL_DFF_tb();
    reg D;
    reg CLK;
    
    wire Q;
    wire Qn;
    
    BEHAVIORAL_DFF DUT(
                   .D(D),
                   .CLK(CLK),
                   
                   .Q(Q),
                   .Qn(Qn)
                   );
    initial
       begin
            D = 1'b0; #5 CLK = 1'b0;
            #10 D = 1'b0; #5 CLK = 1'b1;
            #10 D = 1'b1; #10 CLK = 1'b0;
            #10 D = 1'b1; #15 CLK = 1'b1;
            #10 D = 1'b1; #15 CLK = 1'b0;    
            #10 D = 1'b0; #15 CLK = 1'b1;         
            #10 $finish;
       end                      
endmodule


module REGISTER_tb();

    reg [7:0]IN;
    reg CLK;
    reg CLEAR;
    
    wire [7:0]OUT;
    
    REGISTER DUT(
             .IN(IN),
             .CLK(CLK),
             .CLEAR(CLEAR),
             
             .OUT(OUT)
             );
    initial
        begin
            IN = 8'h01; CLK = 1'b0 ; CLEAR = 1'b0;
            #10 IN = 8'h01;#5 CLK = 1'b0 ; CLEAR = 1'b0;
            #10 IN = 8'h02;#5 CLK = 1'b1 ; CLEAR = 1'b0;
            #10 IN = 8'h03;#5 CLK = 1'b0 ; CLEAR = 1'b0;
            #10 IN = 8'h04;#5 CLK = 1'b1 ; CLEAR = 1'b1;
            #10 IN = 8'h05;#5 CLK = 1'b0 ; CLEAR = 1'b0;
            #10 IN = 8'h06;#5 CLK = 1'b1 ; CLEAR = 1'b0;
            #10 IN = 8'h07;#5 CLK = 1'b0 ; CLEAR = 1'b0;
            #10 IN = 8'h08;#5 CLK = 1'b1 ; CLEAR = 1'b0;
            #10 IN = 8'h09;#5 CLK = 1'b1 ; CLEAR = 1'b0;
            #10 IN = 8'hA;#10 CLK = 1'b0 ; CLEAR = 1'b0;
            #10 IN = 8'hB;#10 CLK = 1'b1 ; CLEAR = 1'b0;
            #10 IN = 8'hC;#10 CLK = 1'b0 ; CLEAR = 1'b0;
            #10 IN = 8'hD;#10 CLK = 1'b1 ; CLEAR = 1'b0;
            #10 IN = 8'hE;#10 CLK = 1'b0 ; CLEAR = 1'b1;
            #10 IN = 8'hF;#10 CLK = 1'b1 ; CLEAR = 1'b0;
            #10 $finish;
        end            
endmodule

module RAM_tb();

    reg clka;
    reg wea;
    reg [3:0]addra;
    
    wire [7:0]douta;
    
    RAM DUT(.clka(clka),
            .wea(wea),
            .addra(addra),
            
            .douta(douta)
            );
            
    always
        begin
            clka <=0; #10;
            clka <=1; #10;
        end
     initial
        begin
            wea = 1'b0;
            addra = 4'h0;
            #40 addra = 4'h1;
            #40 addra = 4'h2;
            #40 addra = 4'h3;
            #40 addra = 4'h4;
            #40 addra = 4'h5;
            #40 addra = 4'h6; 
            #40 addra = 4'h7;
            #40 addra = 4'h8;
            #40 addra = 4'h9;
            #40 addra = 4'hA;
            #40 addra = 4'hB;
            #40 addra = 4'hC;
            #40 addra = 4'hD;
            #40 addra = 4'hE;
            #40 addra = 4'hF;
            #80 $finish;                      
        end   
endmodule             