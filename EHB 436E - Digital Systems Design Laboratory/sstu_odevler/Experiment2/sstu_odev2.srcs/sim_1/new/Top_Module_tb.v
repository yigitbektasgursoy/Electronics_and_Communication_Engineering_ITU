`timescale 1ns / 1ps

module Top_Module_tb();
    reg [7:0]SW;
    reg [3:0]BTN;
    
    wire [7:0]LED;
    wire [6:0]CAT;
    wire [3:0]AN;
    wire [0:0]DP;
    
    Top_Module DUT(
        .SW(SW),
        .BTN(BTN),
        .LED(LED),
        .CAT(CAT),
        .AN(AN),
        .DP(DP)
        );
        
        initial
        begin
  /*        SW[3:0] = 4'h0;
        #10 SW[3:0] = 4'h1;
        #10 SW[3:0] = 4'h2;
        #10 SW[3:0] = 4'h3;
        #10 SW[3:0] = 4'h4;
        #10 SW[3:0] = 4'h5;
        #10 SW[3:0] = 4'h6;
        #10 SW[3:0] = 4'h7;
        #10 SW[3:0] = 4'h8;
        #10 SW[3:0] = 4'h9;
        #10 SW[3:0] = 4'hA;
        #10 SW[3:0] = 4'hB;
        #10 SW[3:0] = 4'hC;
        #10 SW[3:0] = 4'hD;
        #10 SW[3:0] = 4'hE;
        #10 SW[3:0] = 4'hF;
        #10 $finish;
        end     
        */
        /*  SW[3:0] = 4'b0000; #10 BTN[1:0] = 2'h0 ;#10  BTN[1:0] = 2'h1 ;#10  BTN[1:0] = 2'h2 ;#10  BTN[1:0] = 2'h3 ;
        #10 SW[3:0] = 4'b0001; #10 BTN[1:0] = 2'h0 ;#10  BTN[1:0] = 2'h1 ;#10  BTN[1:0] = 2'h2 ;#10  BTN[1:0] = 2'h3 ;
        #10 SW[3:0] = 4'b0010; #10 BTN[1:0] = 2'h0 ;#10  BTN[1:0] = 2'h1 ;#10  BTN[1:0] = 2'h2 ;#10  BTN[1:0] = 2'h3 ;
        #10 SW[3:0] = 4'b0100; #10 BTN[1:0] = 2'h0 ;#10  BTN[1:0] = 2'h1 ;#10  BTN[1:0] = 2'h2 ;#10  BTN[1:0] = 2'h3 ;
        #10 SW[3:0] = 4'b1000; #10 BTN[1:0] = 2'h0 ;#10  BTN[1:0] = 2'h1 ;#10  BTN[1:0] = 2'h2 ;#10  BTN[1:0] = 2'h3 ; 
        #10 $finish;
        end */
            SW[0]= 1'b0; #10 BTN[1:0] = 2'h0 ;#10  BTN[1:0] = 2'h1 ;#10  BTN[1:0] = 2'h2 ;#10  BTN[1:0] = 2'h3;
        #10 SW[0]= 1'b1; #10 BTN[1:0] = 2'h0 ;#10  BTN[1:0] = 2'h1 ;#10  BTN[1:0] = 2'h2 ;#10  BTN[1:0] = 2'h3;
        #10 $finish;   
        end
endmodule
