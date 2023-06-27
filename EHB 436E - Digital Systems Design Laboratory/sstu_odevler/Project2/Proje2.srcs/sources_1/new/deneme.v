module fsm_0110 (
  input wire clk,
  input wire rst,
  input wire [3:0] in,
  output reg found
);

// state registers
reg [1:0] state;

// next-state logic
always @ (posedge clk) begin
  if (rst) begin
    state <= 2'b00;
  end else begin
    case (state)
      2'b00: state <= in == 4'b0110 ? 2'b01 : 2'b00;
      2'b01: state <= in == 4'b0110 ? 2'b10 : 2'b00;
      2'b10: state <= in == 4'b0110 ? 2'b11 : 2'b00;
      2'b11: state <= 2'b11;
      default: state <= 2'b00;
    endcase
  end
end

// output logic
always @ (posedge clk) begin
  found <= state == 2'b11;
end

endmodule
