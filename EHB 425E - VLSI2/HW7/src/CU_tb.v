`timescale 1ns / 1ps

module CU_tb;
    reg clk;
    reg reset;
    reg [31:0] instruction;
    reg [31:0] IMM_rs;
    reg Z;
    reg N;
    
    wire [31:0] PC_Addr;
    wire [31:0] IMM;
    wire [2:0] Mem_type_sel;
    wire [4:0] AA;
    wire [4:0] BA;
    wire [4:0] DA;
    wire we;
    wire MR;
    wire MD;
    wire MB;
    wire [3:0] FS;
    
    Controller #(32) UUT(
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
        $dumpfile("CU_tb.vcd");
        $dumpvars(0, CU_tb);
        
        // Initialize signals
        clk = 0;
        reset = 0;
        instruction = 0;
        IMM_rs = 0;
        Z = 0;
        N = 0;

        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        #10;
        
        // Cycle through a set of test vectors
        // You would replace these values with your own
        instruction = 32'h00000000;
        #10;
        
        instruction = 32'h00000001;
        IMM_rs = 32'h00000001;
        Z = 1;
        N = 1;
        #10;
        
        instruction = 32'b0000000_00011_00100_000_00111_0110011;
        IMM_rs = 32'h00000010;
        Z = 0;
        N = 0;
        #10;
        instruction = 32'b0000000_00000_00000_000_00000_0010011; #10;
        IMM_rs = 32'h0110A010;
        Z = 0;
        N = 0;
        #10;
        // Add more test vectors as needed
        
        $finish;
    end
    
    // Generate clock signal
    always begin
        #5 clk = ~clk;
    end
endmodule
