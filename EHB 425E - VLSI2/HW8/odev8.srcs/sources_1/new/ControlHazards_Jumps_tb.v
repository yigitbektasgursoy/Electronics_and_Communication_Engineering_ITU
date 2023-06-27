module ControlHazards_Jumps_tb;

  reg clk;
  reg rst;
  reg [31:0] inst_i;
  wire [31:0] result;
  

  ControlHazards_Jumps dut (
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
    
    // Branch instructions
    inst_i = 32'bxxxxxxxxxxxxxxxxx000xxxxx1100011; // beq
    #10;
    
    inst_i = 32'b0000000xxxxxxxxxx000xxxxx0110011; // add
    #10;
    
    inst_i = 32'bxxxxxxxxxxxxxxxxx001xxxxx1100011; // bne
    #10;
    
    inst_i = 32'b0100000xxxxxxxxxx000xxxxx0110011; // sub
    #10;
    
    inst_i = 32'b0100000xxxxxxxxxx000xxxxx0110011; // sub
    #10;
    
    inst_i = 32'bxxxxxxxxxxxxxxxxx100xxxxx1100011; // blt
    #10;
    
    inst_i = 32'b0000000xxxxxxxxxx000xxxxx0110011; // add
    #10;
    
    inst_i = 32'bxxxxxxxxxxxxxxxxx101xxxxx1100011; // bge
    #10;
    
    inst_i = 32'bxxxxxxxxxxxxxxxxx110xxxxx1100011; // bltu
    #10;
    
    inst_i = 32'bxxxxxxxxxxxxxxxxx111xxxxx1100011; // bgeu
    #10;
    
    // Jump instructions
    inst_i = 32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111; // jal
    #10;
    
    inst_i = 32'b0000000xxxxxxxxxx000xxxxx0110011; // add
    #10;
    
    inst_i = 32'bxxxxxxxxxxxxxxxxx000xxxxx1100111; // jalr
    #10;
    
    // Finish the simulation
    $finish;
  end
  
endmodule
