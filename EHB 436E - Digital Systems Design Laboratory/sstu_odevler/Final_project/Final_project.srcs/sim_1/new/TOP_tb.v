`timescale 1ns / 1ps

module TOP_tb( );
    reg clk, reset, Start; 
    reg [7:0] InA, InB;
    wire Busy;
    wire [7:0]Out;

    TOP DUT (
        .clk(clk), 
        .reset(reset), 
        .Start(Start), 
        .InA(InA), 
        .InB(InB),
        .Busy(Busy),
        .Out(Out)
        );
    
    always
    begin
        clk = ~clk; #10;
    end 
    
    initial begin 
        clk = 0; reset = 1; #10; reset = 0; 
        InA = 8'd0; InB = 8'd0; #19;
        Start = 1; #10 Start = 0; #200;
        
        reset = 1; #10 reset = 0; 
        InA = 8'd0; InB = 8'd1; #20;
        Start = 1; #10Start = 0; #200;
        
        reset = 1; #10; reset = 0; 
        InA = 8'd0; InB = 8'd2; #19;
        Start = 1; #10 Start = 0; #200;
        
        reset = 1; #10 reset = 0; 
        InA = 8'd0; InB = 8'd3; #20;
        Start = 1; #10Start = 0; #200;
        
        reset = 1; #10 reset = 0; 
        InA = 8'd1; InB = 8'd0; #19;
        Start = 1; #10 Start = 0; #200;
        
        reset = 1; #10 reset = 0; 
        InA = 8'd1; InB = 8'd1; #20;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10; reset = 0; 
        InA = 8'd1; InB = 8'd2; #19;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10 reset = 0; 
        InA = 8'd1; InB = 8'd3; #20;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10 reset = 0;
        InA = 8'd2; InB = 8'd0; #19;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10 reset = 0; 
        InA = 8'd2; InB = 8'd1; #20;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10; reset = 0; 
        InA = 8'd2; InB = 8'd2; #19;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10 reset = 0; 
        InA = 8'd2; InB = 8'd3; #20;
        Start = 1; #10Start = 0; #200
        
                
        reset = 1; #10 reset = 0; 
        InA = 8'd3; InB = 8'd0; #19;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10 reset = 0; 
        InA = 8'd3; InB = 8'd1; #20;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10; reset = 0; 
        InA = 8'd3; InB = 8'd2; #19;
        Start = 1; #10 Start = 0; #200
        
        reset = 1; #10 reset = 0; 
        InA = 8'd3; InB = 8'd3; #20;
        Start = 1; #10Start = 0; #200;
    end
endmodule
