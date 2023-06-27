module Controller_tb;
    
    // Inputs
    reg START;
    reg [1:0] S_S;
    reg CLK;
    reg RST;
    
    // Outputs
    wire [7:0] C_S;
    wire Done;
    
    // Instantiate the Unit Under Test (UUT)
    Controller uut (
        .START(START), 
        .S_S(S_S), 
        .CLK(CLK), 
        .RST(RST), 
        .C_S(C_S), 
        .Done(Done)
    );
    
    initial begin
        // Initialize inputs
        START = 0;
        S_S = 2'b00;
        CLK = 0;
        RST = 0;
        
        // Wait for a few clock cycles
        #10;
        
        // Reset the controller
        RST = 1;
        #10;
        RST = 0;
        
        // Wait for a few clock cycles
        #10;
        
        // Test case 1: START signal is low, S_S = 00
        START = 0;
        S_S = 2'b00;
        #10;
        $display("C_S = %b, DONE = %d", C_S, Done);
        
        // Test case 2: START signal is high, S_S = 00
        START = 1;
        S_S = 2'b00;
        #10;
        $display("C_S = %b, DONE = %d", C_S, Done);
        
        // Test case 3: START signal is high, S_S = 01
        START = 1;
        S_S = 2'b01;
        #10;
        $display("C_S = %b, DONE = %d", C_S, Done);
        
        // Test case 4: START signal is high, S_S = 11
        START = 1;
        S_S = 2'b11;
        #10;
        $display("C_S = %b, DONE = %d", C_S, Done);
        
        // Terminate the simulation
        #10;
        $finish;
    end
    
    // Toggle the clock every 5ns
    always #5 CLK = ~CLK;
    
endmodule
