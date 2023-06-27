module MULTS_tb();
    reg [7:0] A;
    reg [7:0] X;
    wire [15:0] result;
    
    MULTS DUT
    (
    .A(A),
    .X(X),
    .result(result)
    );
 
    initial
    begin
        A=0; X=0;
        #10;
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=8; X=14; 
        #15 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
         
        A=13; X=6;
        #20 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
 
        A=2; X=11; 
        #10 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
 
        A=36; X=82; 
        #15 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
 
        A=4; X=75; 
        #20 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
 
        A=121; X=139; 
        #10 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        
        A=194; X=237;
        #15
        $write("A * X = %d * %d => Result = %d\n", A, X, result); 
        #10
        $finish;
    end
endmodule

module MULTS_signed_tb();
    reg signed [7:0] A;
    reg signed [7:0] X;
    wire signed [15:0] result;
    
    MULTS_signed DUT
    (
    .A(A),
    .X(X),
    .result(result)
    );
    
    initial
    begin
        A=0; X=-1;
        #5;
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=-13; X=6; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=-40; X=-9; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=12; X=-12; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=47; X=68; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=-31; X=-47; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=342; X=-19; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=-48; X=18; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=-36; X=-11; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        
        A=-150; X=-15; 
        #5 
        $write("A * X = %d * %d => Result = %d\n",A, X, result);
        $finish;
        end  
endmodule


module MULTB_tb();
    reg signed [7:0] A;
    reg signed [7:0] B;
    wire signed [15:0] result;
    
    MULTB DUT
    (
    .A(A),
    .B(B),
    .result(result)
    );
    
    initial
    begin
        A=45; B=87;
        #5;
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=19; B=78; 
        #5 
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=-40; B=17; 
        #5 
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=101; B=101; 
        #5 
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=34; B=103; 
        #5 
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=-13; B=-42; 
        #5 
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=12; B=-155; 
        #5 
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=-43; B=-19; 
        #5 
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=-61; B=43; 
        #5
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        
        A=-18; B=-18; 
        #5 
        $write("A * B = %d * %d => Result = %d\n",A, B, result);
        $finish;
        end
endmodule

module MAC_tb();
    reg clk, reset;
    reg signed [23:0] data;
    reg signed [23:0] weight;
    wire signed [15:0] result;
    
    MAC UUT
    (
    .clk(clk),
    .reset(reset),
    .data(data),
    .weight(weight),
    .result(result)
    );
    
    initial
    begin
        clk = 0;
        reset = 1; 
        data =   24'b00000000_00000100_00000000; // 0 4 0
        weight = 24'b11111111_11111111_11111111; // -1 -1 -1
        #3; 
        reset = 0;
         
        #8;
        data =   24'b00000001_00001000_00000000; // 1 8 0
        weight = 24'b11111111_00001000_11111111; // -1 8 -1
         
        #13;
        data =   24'b00000000_00000110_00000011; // 0 6 3
        weight = 24'b11111111_11111111_11111111; // -1 -1 -1
        #18;
        
        $write("Dataset = [0 4 0; 1 8 0; 0 6 3], Weights = [-1 -1 -1; -1 8 -1; -1 -1 -1]\n");
        $write("R11 = D11 * W11, R12 = D12 * W12, R13 = D13 * W13\n");
        $write("R21 = D21 * W21, R22 = D22 * W22, R23 = D23 * W23\n");
        $write("R31 = D31 * W31, R32 = D32 * W32, R33 = D33 * W33\n");
        $write("Result Matrix = [0 -4 0; -1 64 0; 0 -6 -3]\n");
        $write("Result = R11 + R12 + R13 + R21 + R22 + R23 + R31 + R32 + R33\n");
        $write("Result = %d\n", result);
        $finish;
    end
 
    always
    begin
        #7; clk = ~clk;
    end
endmodule


module Conv_tb();
 reg clk, reset;
 reg signed [23:0] data;
 reg signed [23:0] weight;
 wire signed [15:0] result;
 
     Conv DUT
     (
     .clk(clk),
     .reset(reset),
     .data(data),
     .weight(weight),
     .result(result)
     );
    initial
    begin
        clk = 0;
        reset = 1;
        data =24'b10000000_10000000_10000000; weight = 24'b11111111_11111111_11111111; #8;
        reset = 0; #10;
        data = 24'b11111111_11111111_10000000; weight = 24'b11111111_00001000_11111111; #15;
        data = 24'b11111111_11111111_10000000; weight= 24'b11111111_11111111_11111111; #10;
        $write("Result(11) = %d\n",result);
        
        reset = 1;
        data = 24'b10000000_10000000_10000000; weight =24'b11111111_11111111_11111111; #10;
        reset = 0; #10
        data = 24'b11111111_10000000_11111111; weight = 24'b11111111_00001000_11111111; #10     
        data = 24'b11111111_10000000_11111111;weight = 24'b11111111_11111111_11111111; #10;
        $write("Result(12) = %d\n", result);
        
        reset = 1;
        data = 24'b10000000_10000000_10000000; weight =24'b11111111_11111111_11111111; #10;
        reset = 0; #10
        data =24'b10000000_11111111_11111111; weight =24'b11111111_00001000_11111111; #10;
        data =24'b10000000_11111111_11111111; weight =24'b11111111_11111111_11111111; #10;
        $write("Result(13) = %d\n",result);
        
        reset = 1;
        data = 24'b11111111_11111111_10000000; weight =24'b11111111_11111111_11111111; #10;
        reset = 0; #10
        data =24'b11111111_11111111_10000000; weight = 24'b11111111_00001000_11111111; #10;
        data = 24'b11111111_11111111_10000000; weight = 24'b11111111_11111111_11111111; #10;
        $write("Result(21) = %d\n",result);
        
        reset = 1;
        data = 24'b11111111_10000000_11111111; weight = 24'b11111111_11111111_11111111; #10;
        reset = 0; #10
        data = 24'b11111111_10000000_11111111; weight =24'b11111111_00001000_11111111; #10;
        data = 24'b11111111_10000000_11111111; weight = 24'b11111111_11111111_11111111; #10;
        $write("Result(22) = %d\n",result);
        
        
        reset = 1;
        data =24'b10000000_11111111_11111111; weight =24'b11111111_11111111_11111111; #10;
        reset = 0; #10
        data =24'b10000000_11111111_11111111; weight =24'b11111111_00001000_11111111; #10;
        data =24'b10000000_11111111_11111111; weight =24'b11111111_11111111_11111111; #10;
        $write("Result(23) = %d\n", result);
        
        
        reset = 1;
        data =24'b11111111_11111111_10000000; weight =24'b11111111_11111111_11111111; #10;
        reset = 0; #10
        data = 24'b11111111_11111111_10000000; weight = 24'b11111111_00001000_11111111; #10;
        data =24'b11111111_11111111_10000000; weight =24'b11111111_11111111_11111111; #10;
        $write("Result(31) = %d\n",result);
        
        reset = 1;
        data =24'b11111111_10000000_11111111; weight =24'b11111111_11111111_11111111; #10;
        reset = 0; #10
        data =24'b11111111_10000000_11111111; weight =24'b11111111_00001000_11111111; #10;
        data =24'b11111111_10000000_11111111; weight =24'b11111111_11111111_11111111; #10;
        $write("Result(32) = %d\n",result);
        
        reset = 1;
        data =24'b10000000_11111111_11111111; weight =24'b11111111_11111111_11111111; #10;
        reset = 0; #10
        data =24'b10000000_11111111_11111111; weight =24'b11111111_00001000_11111111; #10;
        data =24'b10000000_11111111_11111111; weight =24'b11111111_11111111_11111111; #7;
        $write("Result(33) = %d\n",result);
        
        $finish;
     end
 
    always
    begin
        #5; clk = ~clk;
    end
endmodule