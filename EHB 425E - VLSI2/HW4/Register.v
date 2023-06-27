module Register
  #(parameter k = 16)
  (
    input wire clk,
    input wire reset,
    input wire load,
    input wire [k-1:0] data_in,
    output reg [k-1:0] data_out
  );

  always @(posedge clk or posedge reset)
  begin
    if (reset)  // reset
      data_out <= 0;
    else if (load)  // load
      data_out <= data_in;
  end

endmodule
