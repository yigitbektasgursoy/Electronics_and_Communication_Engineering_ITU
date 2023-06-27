module Datapath_tb;

  reg [15:0] A, B;
  reg [7:0] ControlSignals;
  reg clk, reset;
  
  wire [15:0] C;
  wire [1:0] StatusSignals;

  Datapath #(.k(16)) dut (
    .A(A),
    .B(B),
    .ControlSignals(ControlSignals),
    .clk(clk),
    .reset(reset),
    .C(C),
    .StatusSignals(StatusSignals)
  );

  integer i;
  
  initial begin
    // Apply reset for a few cycles
    reset = 1;
    clk = 0;
    ControlSignals = 0;
    #10 reset = 0;
    
    // Generate inputs and control signals randomly and simulate for 100 clock cycles
    for (i = 0; i < 100; i = i + 1) begin
      A = $random;
      B = $random;
      ControlSignals = $random;
      
      #1 clk = ~clk;
    end
    
    $finish;
  end

  always @(posedge clk) begin
    $display("A = %d, B = %d, ControlSignals = %d, C = %d, StatusSignals = %d", A, B, ControlSignals, C, StatusSignals);
  end
  
endmodule
