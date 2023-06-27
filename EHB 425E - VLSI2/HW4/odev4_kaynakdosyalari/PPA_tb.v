`timescale 1ns / 1ps
module PPG_tb();
    reg [15:0] X;
    reg [15:0] Y;
    wire [31:0] PP0;
    wire [31:0] PP1;
    wire [31:0] PP2;
    wire [31:0] PP3;
    wire [31:0] PP4;
    wire [31:0] PP5;
    wire [31:0] PP6;
    wire [31:0] PP7;
    wire [31:0] PP8;
    wire [31:0] PP9;
    wire [31:0] PP10;
    wire [31:0] PP11;
    wire [31:0] PP12;
    wire [31:0] PP13;
    wire [31:0] PP14;
    wire [31:0] PP15;
    
    PPG DUT(.X(X), .Y(Y), .PP0(PP0), .PP1(PP1), .PP2(PP2), .PP3(PP3), .PP4(PP4), .PP5(PP5), .PP6(PP6), .PP7(PP7),
    .PP8(PP8), .PP9(PP9), .PP10(PP10), .PP11(PP11), .PP12(PP12), .PP13(PP13), .PP14(PP14), .PP15(PP15));
      
    integer i;
    initial begin
        for(i = 0; i <= 10; i = i + 1) begin
            {X, Y} = 32'd40180063 + i; // student id = 040180063
            #100;
            $display ("Y = %b, X = %b, PP0 = %b", Y, X, PP0);
            $display ("Y = %b, X = %b, PP1 = %b", Y, X, PP1);
            $display ("Y = %b, X = %b, PP2 = %b", Y, X, PP2);
            $display ("Y = %b, X = %b, PP3 = %b", Y, X, PP3);
            $display ("Y = %b, X = %b, PP4 = %b", Y, X, PP4);
            $display ("Y = %b, X = %b, PP5 = %b", Y, X, PP5);
            $display ("Y = %b, X = %b, PP6 = %b", Y, X, PP6);
            $display ("Y = %b, X = %b, PP7 = %b", Y, X, PP7);
            $display ("Y = %b, X = %b, PP8 = %b", Y, X, PP8);
            $display ("Y = %b, X = %b, PP9 = %b", Y, X, PP9);
            $display ("Y = %b, X = %b, PP10 = %b", Y, X, PP10);
            $display ("Y = %b, X = %b, PP11 = %b", Y, X, PP11);
            $display ("Y = %b, X = %b, PP12 = %b", Y, X, PP12);
            $display ("Y = %b, X = %b, PP13 = %b", Y, X, PP13);
            $display ("Y = %b, X = %b, PP14 = %b", Y, X, PP14);
            $display ("Y = %b, X = %b, PP15 = %b", Y, X, PP15);
        end
        $finish();
    end
endmodule

module Compressor_42_tb();
    reg [31:0] X1;
    reg [31:0] X2;
    reg [31:0] X3;
    reg [31:0] X4;
    reg [31:0] Cin;
    wire [31:0] Cout;
    wire [31:0] CARRY;
    wire [31:0] SUM;
    
    Compressor_42 DUT(.X1(X1), .X2(X2), .X3(X3), .X4(X4), .Cin(Cin), .Cout(Cout), .CARRY(CARRY), .SUM(SUM));
    
    integer i;
    initial begin
        for(i = 0; i <= 10; i = i + 1) begin
            X1 = 32'd40180063 + i + 1; // student id = 040180063
            X2 = 32'd40180063 + i + 2;
            X3 = 32'd40180063 + i + 3;
            X4 = 32'd40180063 + i + 4;
            Cin = 32'd40180063 + i + 5;
            #100;
            $display ("X1 = %b, X2 = %b, X3 = %b, X4 = %b, Cin = %b, Cout = %b, CARRY = %b, SUM = %b", X1, X2, X3, X4, Cin, Cout, CARRY, SUM);
        end
        $finish();
    end

endmodule

module PPA_tb();
    reg [31:0] PP0;
    reg [31:0] PP1;
    reg [31:0] PP2;
    reg [31:0] PP3;
    reg [31:0] PP4;
    reg [31:0] PP5;
    reg [31:0] PP6;
    reg [31:0] PP7;
    reg [31:0] PP8;
    reg [31:0] PP9;
    reg [31:0] PP10;
    reg [31:0] PP11;
    reg [31:0] PP12;
    reg [31:0] PP13;
    reg [31:0] PP14;
    reg [31:0] PP15;
    wire [31:0] COUT;
    wire [31:0] CARRY;
    wire [31:0] SUM;
    
    PPA DUT(.PP0(PP0), .PP1(PP1), .PP2(PP2), .PP3(PP3), .PP4(PP4), .PP5(PP5), .PP6(PP6), .PP7(PP7), .PP8(PP8),.PP9(PP9), 
    .PP10(PP10), .PP11(PP11), .PP12(PP12), .PP13(PP13), .PP14(PP14), .PP15(PP15), .COUT(COUT), .CARRY(CARRY), .SUM(SUM));

    integer i;
        initial begin
            for(i = 0; i <= 10; i = i + 1) begin
                PP0 = 32'd40180063 + i + 0; // student id = 040180063
                PP1 = 32'd40180063 + i + 1;
                PP2 = 32'd40180063 + i + 2;
                PP3 = 32'd40180063 + i + 3;
                PP4 = 32'd40180063 + i + 4;
                PP5 = 32'd40180063 + i + 5;
                PP6 = 32'd40180063 + i + 6;
                PP7 = 32'd40180063 + i + 7;
                PP8 = 32'd40180063 + i + 8;
                PP9 = 32'd40180063 + i + 9;
                PP10 = 32'd40180063 + i + 10;
                PP11 = 32'd40180063 + i + 11;
                PP12 = 32'd40180063 + i + 12;
                PP13 = 32'd40180063 + i + 13;
                PP14 = 32'd40180063 + i + 14;
                PP15 = 32'd40180063 + i + 15;
                #100;
            end
            $finish();
        end

    endmodule

module RCA_tb();
    parameter SIZE = 32;
    
    reg[SIZE-1:0] X;
    reg[SIZE-1:0] Y;
    reg CIN;
    wire COUT;
    wire[SIZE-1:0] S;
    
    RCA DUT(.X(X), .Y(Y), .CIN(CIN), .COUT(COUT), .S(S));
    
    integer i;
    initial begin
        for(i = 0; i <= 10; i = i + 1) begin
            CIN = 0;
            X = 32'd40180063 + i + 6; // student id = 040180063
            Y = 32'd40180063 + i + 7;
            #100;
        end
        $finish();
    end
endmodule

module MUL_tb();
    reg [15:0] X;
    reg [15:0] Y;
    wire [31:0] result;

    MUL DUT(.X(X), .Y(Y), .result(result));
    integer k;
    initial
    begin
        X = 16'd0000;
        Y = 16'd0001;
        k= X*Y;
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);
        X = 16'd1235;
        Y = 16'd0002;
        k= X*Y; 
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);
        X = 16'd12373;
        Y = 16'd1;
        k= X*Y;
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);
        X = 16'd0151;
        Y = 16'd0010;
        k= X*Y;
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);
        X = 16'd1235;
        Y = 16'd1000;
        k= X*Y;
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);
        X = 16'd12373;
        Y = 16'd12137;
        k= X*Y;
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);      
        X = 16'd2;
        Y = 16'd3;
        k= X*Y;
        #100;
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);     
        X = 16'd18;
        Y = 16'd7;
        k= X*Y;
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);
        X = 16'd19;
        Y = 16'd3;
        k= X*Y;
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);
        X = 16'd2;
        Y = 16'd12324;
        k= X*Y;
        #100; 
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k);
        X = 16'h0fff;
        Y = 16'h0fff;
        k= X*Y;
        #100;
        $display ("Y = %d, X = %d, result = %d, expected result=%d", Y, X, result, k); 
    end
endmodule