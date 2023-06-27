module Forwarding_Unit (
  input [1:0] EX_MEM_RegWrite,
  input [1:0] MEM_WB_RegWrite,
  input [1:0] ID_EX_RegWrite,
  input [1:0] EX_MEM_MemRead,
  input [1:0] MEM_WB_MemRead,
  input [1:0] ID_EX_MemWrite,
  input [1:0] EX_MEM_RD,
  input [1:0] MEM_WB_RD,
  input [4:0] EX_MEM_RS,
  input [4:0] EX_MEM_RT,
  input [4:0] MEM_WB_RS,
  input [4:0] MEM_WB_RT,
  input [4:0] ID_EX_RS,
  input [4:0] ID_EX_RT,
  output reg [1:0] forwardA,
  output reg [1:0] forwardB
);

  always @* begin
    // Forwarding for register A
    if (EX_MEM_RegWrite[0] && (EX_MEM_RD[0] != 0) && (EX_MEM_RD[0] == ID_EX_RS[0]))
      forwardA = 2'b10;  // Forward from EX/MEM pipeline register
    else if (MEM_WB_RegWrite[0] && (MEM_WB_RD[0] != 0) && (MEM_WB_RD[0] == ID_EX_RS[0]))
      forwardA = 2'b01;  // Forward from MEM/WB pipeline register
    else
      forwardA = 2'b00;  // No forwarding

    if (EX_MEM_RegWrite[1] && (EX_MEM_RD[1] != 0) && (EX_MEM_RD[1] == ID_EX_RS[0]))
      forwardA = 2'b10;  // Forward from EX/MEM pipeline register
    else if (MEM_WB_RegWrite[1] && (MEM_WB_RD[1] != 0) && (MEM_WB_RD[1] == ID_EX_RS[0]))
      forwardA = 2'b01;  // Forward from MEM/WB pipeline register
    else
      forwardA = 2'b00;  // No forwarding

    // Forwarding for register B
    if (EX_MEM_RegWrite[0] && (EX_MEM_RD[0] != 0) && (EX_MEM_RD[0] == ID_EX_RT[0]))
      forwardB = 2'b10;  // Forward from EX/MEM pipeline register
    else if (MEM_WB_RegWrite[0] && (MEM_WB_RD[0] != 0) && (MEM_WB_RD[0] == ID_EX_RT[0]))
      forwardB = 2'b01;  // Forward from MEM/WB pipeline register
    else
      forwardB = 2'b00;  // No forwarding

    if (EX_MEM_RegWrite[1] && (EX_MEM_RD[1] != 0) && (EX_MEM_RD[1] == ID_EX_RT[0]))
      forwardB = 2'b10;  // Forward from EX/MEM pipeline register
    else if (MEM_WB_RegWrite[1] && (MEM_WB_RD[1] != 0) && (MEM_WB_RD[1] == ID_EX_RT[0]))
      forwardB = 2'b01;  // Forward from MEM/WB pipeline register
    else
      forwardB = 2'b00;  // No forwarding
  end

endmodule

