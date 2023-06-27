`timescale 10us / 1ps

module sliding_led_tb();

    reg clk=0,rst=0;
    reg [1:0] SW=0;
    wire [15:0] LED;

    sliding_leds
    #(500) UUT
    ( 
	  .clk(clk),
	  .rst(rst),
	  .SW(SW),
	  .LED(LED)
	);
    
    always #5 clk = ~clk;
    
    initial begin
    
        #5; rst=1;
        #10; rst=0;
        
        #30;
        SW=0;
        repeat(20*1000) @(posedge clk);
        
        #2;
        SW = 1;
        repeat(20*1000) @(posedge clk);
        #5; rst=1;
        
        #2;
        SW = 2;
        repeat(20*1000) @(posedge clk);
        rst=0;
        #2;
        SW = 3;
        repeat(20*1000) @(posedge clk);
        
        #2;
        SW=0;
        repeat(2) @(posedge clk);
        $finish();
        
    end

endmodule
