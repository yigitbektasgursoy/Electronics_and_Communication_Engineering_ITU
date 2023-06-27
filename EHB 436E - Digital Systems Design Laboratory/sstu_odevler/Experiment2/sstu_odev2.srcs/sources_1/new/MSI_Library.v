`timescale 1ns / 1ps

module MSI_Library(
    );
endmodule

//module DECODER (
//    input [3:0]IN,
//    output reg [15:0]OUT
//    ); 
//    always @(IN)
//    begin
//        case(IN)
//            4'b0000: OUT = 16'b0000_0000_0000_0001;
//            4'b0001: OUT = 16'b0000_0000_0000_0010;
//            4'b0010: OUT = 16'b0000_0000_0000_0100;
//            4'b0011: OUT = 16'b0000_0000_0000_1000;
//            4'b0100: OUT = 16'b0000_0000_0001_0000;
//            4'b0101: OUT = 16'b0000_0000_0010_0000;
//            4'b0110: OUT = 16'b0000_0000_0100_0000;
//            4'b0111: OUT = 16'b0000_0000_1000_0000;
//            4'b1000: OUT = 16'b0000_0001_0000_0000;
//            4'b1001: OUT = 16'b0000_0010_0000_0000;
//            4'b1010: OUT = 16'b0000_0100_0000_0000;
//            4'b1011: OUT = 16'b0000_1000_0000_0000;
//            4'b1100: OUT = 16'b0001_0000_0000_0000;
//            4'b1101: OUT = 16'b0010_0000_0000_0000;
//            4'b1110: OUT = 16'b0100_0000_0000_0000;
//            4'b1111: OUT = 16'b1000_0000_0000_0000;
//        endcase
//    end
//endmodule

/*
module ENCODER(
    input [3:0]IN,
    output [1:0]OUT,
    output [0:0]V
    );   
    assign OUT[0] = (IN[3]) | (IN[1] & ~(IN[2]));
    assign OUT[1] = IN[3] | IN[2];
    assign V = (IN[0]) | (IN[1]) | (IN[2]) | (IN[3]);
    
endmodule
*/
    /*
    always@(IN)
    begin
        casez (IN)
            4'b0000: 
            begin 
                OUT = 2'b??; 
                V = 1'b0; 
            end
            
            4'b0001: 
            begin 
                OUT = 2'b00; 
                V = 1'b1; 
            end
            
            4'b001?:
            begin 
                OUT = 2'b01; 
                V = 1'b1; 
            end
            
            4'b01??: 
            begin 
                OUT = 2'b10; 
                V = 1'b1; 
            end
            
            4'b1???: 
            begin 
                OUT = 2'b11; 
                V = 1'b1; 
            end 
            
        endcase
    end
endmodule
        */
     
module MUX(
    input [3:0]D,
    input [1:0]S,
    output reg [0:0]O);
 
//    wire y0,y1,y2,y3;
    
//    assign y0 = D[0] && ~S[0] && ~S[1];
//    assign y1 = D[1] && ~S[0] && S[1];
//    assign y2 = D[2] && S[0] && ~S[1];
//    assign y3 = D[3] && S[0] && S[1];
    
//    assign O = y0 || y1 || y2 || y3;
//endmodule 


    always @(D,S)
    begin
        case (S)
            2'b00: O = D[0];
            2'b01: O = D[1];
            2'b10: O = D[2];
            2'b11: O = D[3];
        endcase
     end          
endmodule 

/*
module DEMUX(
    input [0:0]D,
    input [1:0]S,
    output [3:0]O
    );
    
    wire s0_not, s1_not;
    
    NOT_gate NOT1(.I(S[0]), .O(s0_not));
    NOT_gate NOT2(.I(S[1]), .O(s1_not));
    
    wire y0,y1,y2,y3;
    
    AND_gate AND1( .I1(s0_not), .I2(s1_not), .O(y0));
    AND_gate AND2( .I1(s0_not), .I2(S[1]), .O(y1));
    AND_gate AND3( .I1(S[0]), .I2(s1_not), .O(y2));
    AND_gate AND4( .I1(S[0]), .I2(S[1]), .O(y3));
    
    TRI TRI1( .I(D[0]), .E(y0), .O(O[0]));
    TRI TRI2( .I(D[0]), .E(y1), .O(O[1]));
    TRI TRI3( .I(D[0]), .E(y2), .O(O[2]));
    TRI TRI4( .I(D[0]), .E(y3), .O(O[3]));
  
endmodule  
*/