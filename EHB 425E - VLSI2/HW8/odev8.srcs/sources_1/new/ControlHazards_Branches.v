module ControlHazards_Branches (
  // Inputs and outputs of the processor module
  input         clk,
  input         rst,
  input  [31:0] inst_i,
  output [31:0] result
);
  
  // Pipeline stages
  reg [31:0] inst1, inst2, inst3;
  reg [4:0]  stage;
  
  // Control signals
  wire        isBranch;
  reg         flush;
  
  // Instruction execution logic
  always @(posedge clk) begin
    if (rst) begin
      // Reset all pipeline stages and control signals
      inst1 <= 32'b0;
      inst2 <= 32'b0;
      inst3 <= 32'b0;
      stage <= 0;
      flush <= 0;
    end
    else begin
      // Fetch stage
      if (stage == 0) begin
        if (flush) begin
          // Flush the fetch stage
          inst1 <= 32'b0;
        end
        else begin
          // Fetch the instruction
          inst1 <= inst_i;
        end
        stage <= 1;
      end
      // Decode stage
      else if (stage == 1) begin
        if (flush) begin
          // Flush the decode stage
          inst2 <= 32'b0;
        end
        else begin
          // Decode the instruction
          inst2 <= inst1;
        end
        stage <= 2;
      end
      // Execute stage
      else if (stage == 2) begin
        if (flush) begin
          // Flush the execute stage
          inst3 <= 32'b0;
        end
        else begin
          // Execute the instruction
          inst3 <= inst2;
        end
        stage <= 0;
      end
    end
  end
  
  // Branch detection logic
  assign isBranch = (inst_i[6:0] == 7'b1100011)? 1'b1: 1'b0;
  
  // Flushing logic
  always @(posedge clk) begin
    if (rst) begin
      flush <= 0;
    end
    else begin
      if (isBranch) begin
        flush <= 1;
      end
      else begin
        flush <= 0;
      end
    end
  end
  
  assign result = inst3; 
endmodule