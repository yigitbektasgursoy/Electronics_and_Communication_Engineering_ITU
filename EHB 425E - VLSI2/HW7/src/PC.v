module ProgramCounter#(parameter SIZE = 32)(
    input clk, 
    input reset,
    input MPC, // Branch/Jump control
    input JALR, // Jump and link register control
    input [SIZE-1:0] IMM, // Immediate offset for branch
    input [SIZE-1:0] IMM_rs, // Immediate offset for JALR
    output [SIZE-1:0] PC_out // Output Program Counter
);

    wire[SIZE-1:0] PC_new_out, PC_out_four;
    reg [SIZE-1:0] PC_new_val; // Holds new PC value

    CLA #(.SIZE(SIZE)) adder1
    (.x(PC_new_val),
     .y(IMM),
     .sub(1'b0),
     .ci(1'b0),
     .s(PC_new_out));
     
    CLA #(.SIZE(SIZE)) adder2
    (.x(PC_new_val),
     .y(4'd4), // increment by 4 for the next instruction
     .sub(1'b0),
     .ci(1'b0),
     .s(PC_out_four));
    
    // Calculate new PC value based on MPC and JALR
    always @(posedge clk or posedge reset)
    begin
      if (reset)
        PC_new_val = 32'h0000_0000; // Reset to the initial PC address
      else if (JALR)
        PC_new_val = IMM_rs; // JALR case
      else if (MPC)
        PC_new_val = PC_new_out; // Branch case
      else
        PC_new_val = PC_out_four; // Count up case
    end
    
    assign PC_out = PC_new_val;
endmodule
