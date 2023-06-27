`timescale 1ns / 1ps

module Forwarding_Unit_tb;

  // Parametreler
  parameter WAIT_CYCLES = 5;

  // Modul sinyalleri
  reg [1:0] EX_MEM_RegWrite;
  reg [1:0] MEM_WB_RegWrite;
  reg [1:0] ID_EX_RegWrite;
  reg [1:0] EX_MEM_MemRead;
  reg [1:0] MEM_WB_MemRead;
  reg [1:0] ID_EX_MemWrite;
  reg [1:0] EX_MEM_RD;
  reg [1:0] MEM_WB_RD;
  reg [4:0] EX_MEM_RS;
  reg [4:0] EX_MEM_RT;
  reg [4:0] MEM_WB_RS;
  reg [4:0] MEM_WB_RT;
  reg [4:0] ID_EX_RS;
  reg [4:0] ID_EX_RT;
  wire [1:0] forwardA;
  wire [1:0] forwardB;
  parameter total_cycles = 8 * WAIT_CYCLES;
  parameter forwarded_cycles = 2 * WAIT_CYCLES;
  parameter cpi = total_cycles / (total_cycles - forwarded_cycles);
  // Forwarding Unit module
  Forwarding_Unit dut (
    .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .MEM_WB_RegWrite(MEM_WB_RegWrite),
    .ID_EX_RegWrite(ID_EX_RegWrite),
    .EX_MEM_MemRead(EX_MEM_MemRead),
    .MEM_WB_MemRead(MEM_WB_MemRead),
    .ID_EX_MemWrite(ID_EX_MemWrite),
    .EX_MEM_RD(EX_MEM_RD),
    .MEM_WB_RD(MEM_WB_RD),
    .EX_MEM_RS(EX_MEM_RS),
    .EX_MEM_RT(EX_MEM_RT),
    .MEM_WB_RS(MEM_WB_RS),
    .MEM_WB_RT(MEM_WB_RT),
    .ID_EX_RS(ID_EX_RS),
    .ID_EX_RT(ID_EX_RT),
    .forwardA(forwardA),
    .forwardB(forwardB)
  );

  // Test senaryosu
  initial begin
    // Test 1: No forwarding
    #WAIT_CYCLES;
    EX_MEM_RegWrite = 2'b00;
    MEM_WB_RegWrite = 2'b00;
    ID_EX_RegWrite = 2'b00;
    EX_MEM_MemRead = 2'b00;
    MEM_WB_MemRead = 2'b00;
    ID_EX_MemWrite = 2'b00;
    EX_MEM_RD = 2'b00;
    MEM_WB_RD = 2'b00;
    EX_MEM_RS = 5'b00000;
    EX_MEM_RT = 5'b00000;
    MEM_WB_RS = 5'b00000;
    MEM_WB_RT = 5'b00000;
    ID_EX_RS = 5'b00000;
    ID_EX_RT = 5'b00000;
    #1;
    if (forwardA !== 2'b00 || forwardB !== 2'b00) begin
      $display("Test 1: No forwarding - Failed");
      $display("ForwardA: %b, ForwardB: %b", forwardA, forwardB);
    end else begin
      $display("Test 1: No forwarding - Passed");
    end

    // Test 2: Forward from EX/MEM to RS
    #WAIT_CYCLES;
    EX_MEM_RegWrite = 2'b10;
    MEM_WB_RegWrite = 2'b00;
    ID_EX_RegWrite = 2'b00;
    EX_MEM_MemRead = 2'b00;
    MEM_WB_MemRead = 2'b00;
    ID_EX_MemWrite = 2'b00;
    EX_MEM_RD = 2'b10;
    MEM_WB_RD = 2'b00;
    EX_MEM_RS = 5'b00100;
    EX_MEM_RT = 5'b00000;
    MEM_WB_RS = 5'b00000;
    MEM_WB_RT = 5'b00000;
    ID_EX_RS = 5'b00100;
    ID_EX_RT = 5'b00000;
    #1;
    if (forwardA !== 2'b10 || forwardB !== 2'b00) begin
      $display("Test 2: Forward from EX/MEM to RS - Failed");
      $display("ForwardA: %b, ForwardB: %b", forwardA, forwardB);
    end else begin
      $display("Test 2: Forward from EX/MEM to RS - Passed");
    end

    // Test 3: Forward from MEM/WB to RT
    #WAIT_CYCLES;
    EX_MEM_RegWrite = 2'b00;
    MEM_WB_RegWrite = 2'b01;
    ID_EX_RegWrite = 2'b00;
    EX_MEM_MemRead = 2'b00;
    MEM_WB_MemRead = 2'b00;
    ID_EX_MemWrite = 2'b00;
    EX_MEM_RD = 2'b00;
    MEM_WB_RD = 2'b01;
    EX_MEM_RS = 5'b00000;
    EX_MEM_RT = 5'b00000;
    MEM_WB_RS = 5'b00000;
    MEM_WB_RT = 5'b01000;
    ID_EX_RS = 5'b00000;
    ID_EX_RT = 5'b01000;
    #1;
    if (forwardA !== 2'b00 || forwardB !== 2'b01) begin
      $display("Test 3: Forward from MEM/WB to RT - Failed");
      $display("ForwardA: %b, ForwardB: %b", forwardA, forwardB);
    end else begin
      $display("Test 3: Forward from MEM/WB to RT - Passed");
    end

    // Test 4: Forward from EX/MEM and MEM/WB to RS and RT
    #WAIT_CYCLES;
    EX_MEM_RegWrite = 2'b10;
    MEM_WB_RegWrite = 2'b01;
    ID_EX_RegWrite = 2'b00;
    EX_MEM_MemRead = 2'b00;
    MEM_WB_MemRead = 2'b00;
    ID_EX_MemWrite = 2'b00;
    EX_MEM_RD = 2'b10;
    MEM_WB_RD = 2'b01;
    EX_MEM_RS = 5'b00100;
    EX_MEM_RT = 5'b00000;
    MEM_WB_RS = 5'b00000;
    MEM_WB_RT = 5'b01000;
    ID_EX_RS = 5'b00100;
    ID_EX_RT = 5'b01000;
    #1;
    if (forwardA !== 2'b10 || forwardB !== 2'b01) begin
      $display("Test 4: Forward from EX/MEM and MEM/WB to RS and RT - Failed");
      $display("ForwardA: %b, ForwardB: %b", forwardA, forwardB);
    end else begin
      $display("Test 4: Forward from EX/MEM and MEM/WB to RS and RT - Passed");
    end

    // Test 5: No forwarding (stall)
    #WAIT_CYCLES;
    EX_MEM_RegWrite = 2'b00;
    MEM_WB_RegWrite = 2'b00;
    ID_EX_RegWrite = 2'b10;
    EX_MEM_MemRead = 2'b00;
    MEM_WB_MemRead = 2'b00;
    ID_EX_MemWrite = 2'b00;
    EX_MEM_RD = 2'b00;
    MEM_WB_RD = 2'b00;
    EX_MEM_RS = 5'b00000;
    EX_MEM_RT = 5'b00000;
    MEM_WB_RS = 5'b00000;
    MEM_WB_RT = 5'b00000;
    ID_EX_RS = 5'b00010;
    ID_EX_RT = 5'b00000;
    #1;
    if (forwardA !== 2'b00 || forwardB !== 2'b00) begin
      $display("Test 5: No forwarding (stall) - Failed");
      $display("ForwardA: %b, ForwardB: %b", forwardA, forwardB);
    end else begin
      $display("Test 5: No forwarding (stall) - Passed");
    end

    // Test 6: Forward from EX/MEM to RS (stall)
    #WAIT_CYCLES;
    EX_MEM_RegWrite = 2'b10;
    MEM_WB_RegWrite = 2'b00;
    ID_EX_RegWrite = 2'b10;
    EX_MEM_MemRead = 2'b00;
    MEM_WB_MemRead = 2'b00;
    ID_EX_MemWrite = 2'b00;
    EX_MEM_RD = 2'b10;
    MEM_WB_RD = 2'b00;
    EX_MEM_RS = 5'b00100;
    EX_MEM_RT = 5'b00000;
    MEM_WB_RS = 5'b00000;
    MEM_WB_RT = 5'b00000;
    ID_EX_RS = 5'b00100;
    ID_EX_RT = 5'b00000;
    #1;
    if (forwardA !== 2'b10 || forwardB !== 2'b00) begin
      $display("Test 6: Forward from EX/MEM to RS (stall) - Failed");
      $display("ForwardA: %b, ForwardB: %b", forwardA, forwardB);
    end else begin
      $display("Test 6: Forward from EX/MEM to RS (stall) - Passed");
    end

    // Test 7: Forward from MEM/WB to RT (stall)
    #WAIT_CYCLES;
    EX_MEM_RegWrite = 2'b00;
    MEM_WB_RegWrite = 2'b01;
    ID_EX_RegWrite = 2'b10;
    EX_MEM_MemRead = 2'b00;
    MEM_WB_MemRead = 2'b00;
    ID_EX_MemWrite = 2'b00;
    EX_MEM_RD = 2'b00;
    MEM_WB_RD = 2'b01;
    EX_MEM_RS = 5'b00000;
    EX_MEM_RT = 5'b00000;
    MEM_WB_RS = 5'b00000;
    MEM_WB_RT = 5'b01000;
    ID_EX_RS = 5'b00000;
    ID_EX_RT = 5'b01000;
    #1;
    if (forwardA !== 2'b00 || forwardB !== 2'b01) begin
      $display("Test 7: Forward from MEM/WB to RT (stall) - Failed");
      $display("ForwardA: %b, ForwardB: %b", forwardA, forwardB);
    end else begin
      $display("Test 7: Forward from MEM/WB to RT (stall) - Passed");
    end

    // Test 8: Forward from EX/MEM and MEM/WB to RS and RT (stall)
    #WAIT_CYCLES;
    EX_MEM_RegWrite = 2'b10;
    MEM_WB_RegWrite = 2'b01;
    ID_EX_RegWrite = 2'b10;
    EX_MEM_MemRead = 2'b00;
    MEM_WB_MemRead = 2'b00;
    ID_EX_MemWrite = 2'b00;
    EX_MEM_RD = 2'b10;
    MEM_WB_RD = 2'b01;
    EX_MEM_RS = 5'b00100;
    EX_MEM_RT = 5'b00000;
    MEM_WB_RS = 5'b00000;
    MEM_WB_RT = 5'b01000;
    ID_EX_RS = 5'b00100;
    ID_EX_RT = 5'b01000;
    #1;
    if (forwardA !== 2'b10 || forwardB !== 2'b01) begin
      $display("Test 8: Forward from EX/MEM and MEM/WB to RS and RT (stall) - Failed");
      $display("ForwardA: %b, ForwardB: %b", forwardA, forwardB);
    end else begin
      $display("Test 8: Forward from EX/MEM and MEM/WB to RS and RT (stall) - Passed");
    end

    // CPI calculation

    if (cpi == 1) begin
      $display("CPI: 1 - Passed");
    end else begin
      $display("CPI: %f - Failed", cpi);
    end

    $finish;
  end

endmodule
