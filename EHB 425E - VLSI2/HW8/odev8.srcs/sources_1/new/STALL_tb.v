`timescale 1ns / 1ps

module STALL_tb;


  reg clk;
  reg rst;
  reg StallLoad;
  reg StallBranch;
  wire [5:0] stall;
  

  STALL stall_module (
    .rst(rst),
    .StallLoad(StallLoad),
    .StallBranch(StallBranch),
    .stall(stall)
  );
  

  always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
  end
  
  // Reset the STALL module initially
  initial begin
    rst = 1;
    StallLoad = 0;
    StallBranch = 0;
    #20;
    rst = 0;
  end

  initial begin
    // Scenario 1: No stall
    StallLoad = 0;
    StallBranch = 0;
    #10;
    
    // Scenario 2: Stall Load
    StallLoad = 1;
    StallBranch = 0;
    #10;
    
    // Scenario 3: Stall Branch
    StallLoad = 0;
    StallBranch = 1;
    #10;
    
    // Scenario 4: Stall Load and Branch
    StallLoad = 1;
    StallBranch = 1;
    #10;
    
    $finish;
  end
  
endmodule
