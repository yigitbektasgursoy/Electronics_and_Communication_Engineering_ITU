`timescale 1ns / 1ps

module CU_tb;
    parameter SIZE = 32;
    
    reg clk;
    reg reset;
    reg [SIZE-1:0] instruction;
    reg [SIZE-1:0] IMM_rs;
    reg Z;
    reg N;
    
    wire [SIZE-1:0] PC_Addr;
    wire [SIZE-1:0] IMM;
    wire [2:0] Mem_type_sel;
    wire [$clog2(SIZE)-1 : 0] AA;
    wire [$clog2(SIZE)-1 : 0] BA;
    wire [$clog2(SIZE)-1 : 0] DA;
    wire we;
    wire MR;
    wire MD;
    wire MB;
    wire [3:0] FS;
    
    // Instantiate the Controller
    Controller #(SIZE) dut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .IMM_rs(IMM_rs),
        .Z(Z),
        .N(N),
        .PC_Addr(PC_Addr),
        .IMM(IMM),
        .Mem_type_sel(Mem_type_sel),
        .AA(AA),
        .BA(BA),
        .DA(DA),
        .we(we),
        .MR(MR),
        .MD(MD),
        .MB(MB),
        .FS(FS)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        instruction = 0;
        IMM_rs = 0;
        Z = 0;
        N = 0;
        
        // Wait for two clock cycles
        #20;
        
        // Clear reset and apply some inputs
        reset = 0;
        instruction = 32'hABD0_1201;
        IMM_rs = 32'h0000_0002;
        Z = 1;
        N = 1;
        
        // Wait for one clock cycle
        #10;
        
        // Modify inputs
        instruction = 32'h0000_0003;
        IMM_rs = 32'h0000_0004;
        Z = 0;
        N = 0;
        
        // Continue simulation as desired...
    end

    // Clock generation
    always #5 clk = ~clk;

    // Monitor the output
    initial begin
        $monitor("At time %0dns, PC_Addr = %h, IMM = %h, Mem_type_sel = %b, AA = %h, BA = %h, DA = %h, we = %b, MR = %b, MD = %b, MB = %b, FS = %b",
                $time, PC_Addr, IMM, Mem_type_sel, AA, BA, DA, we, MR, MD, MB, FS);
    end
endmodule
