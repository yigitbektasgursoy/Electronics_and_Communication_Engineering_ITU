module ControlHazards_Branches_tb;

  reg clk;
  reg rst;
  reg [31:0] inst_i;
  wire [31:0] result;
  

  ControlHazards_Branches dut (
    .clk(clk),
    .rst(rst),
    .inst_i(inst_i),
    .result(result)
  );
  

  always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
  end
  

  initial begin
    rst = 1;
    inst_i = 32'b0;  
    #20;
    rst = 0;
  end
  

  initial begin
    // Arbitrary arithmetic instruction
    inst_i = 32'b0000000xxxxxxxxxx000xxxxx0110011;
    #10;
    
    // Branch instruction (taken)
    inst_i = 32'bxxxxxxxxxxxxxxxxx000xxxxx1100011; // beq, predict taken
    #10;
    
    // Instructions executed after branch taken
    inst_i = 32'b0000000xxxxxxxxxx000xxxxx0110011;
    #10;
    
    // Branch instruction (not taken)
    inst_i = 32'bxxxxxxxxxxxxxxxxx000xxxxx1100011; // beq, predict not taken
    #10;
    
    // Instructions executed after branch not taken
    inst_i = 32'b0000000xxxxxxxxxx000xxxxx0110011;
    #10;
    
    inst_i = 32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111; // jal
    #10;
    // Finish the simulation
    $finish;
  end
  
endmodule
