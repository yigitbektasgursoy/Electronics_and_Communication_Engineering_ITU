`timescale 1ns / 1ps
module DATAPATH_tb;
    // Declare your parameters, inputs, and outputs
    parameter SIZE = 32;
    reg clk;
    reg reset;
    reg we;
	reg MuxB_sel;
	reg MuxD_sel;
	reg MuxR_sel;
	reg [3:0] Sel; 
    reg [$clog2(SIZE)-1 : 0] AA; 
	reg [$clog2(SIZE)-1 : 0] BA;
	reg [$clog2(SIZE)-1 : 0] DA;
	reg [SIZE-1 : 0] PC_in;
	reg [SIZE-1 : 0] Data_in;
	reg [SIZE-1 : 0] Constant_in;
	wire [SIZE-1 : 0] Addr_out;
	wire [SIZE-1 : 0] Data_out;
    wire C;
    wire V;
    wire N;
    wire Z;
    // Instantiate your modules
    DATAPATH #(SIZE) DUT(
        .clk(clk),
        .reset(reset),
        .we(we),
        .MuxB_sel(MuxB_sel),
        .MuxD_sel(MuxD_sel),
        .MuxR_sel(MuxR_sel),
        .Sel(Sel),
        .AA(AA),
        .BA(BA),
        .DA(DA),
        .PC_in(PC_in),
        .Data_in(Data_in),
        .Constant_in(Constant_in),
        .Addr_out(Addr_out),
        .Data_out(Data_out),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z)
    );

    // Instantiate data_memory
    data_memory #(32, 128) mem(
        .clk(clk), 
        .rst(reset), 
        .rd_addr0(BA), // Read Address
        .wr_addr0(DA), // Write Address
        .wr_din0(Data_in), // Write Data
        .wr_strb(4'b0111), // Word Write Strobe
        .we0(we), // Write Enable
        .rd_dout0(Data_out) // Read Data
    );

    // Insert your test stimulus here
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        we = 0;
        MuxB_sel = 0;
        MuxD_sel = 0;
        MuxR_sel = 0;
        Sel = 0;
        AA = 0;
        BA = 0;
        DA = 0;
        PC_in = 0;
        Data_in = 0;
        Constant_in = 0;

        // Reset 
        #10 reset = 0;
        //ADDI C=1
        we = 1;
        MuxR_sel = 0;
        MuxD_sel = 0;
        MuxB_sel = 1;
        Sel = 4'b0000;
        AA = 5'b00001;
        BA = 5'b00001;
        DA = 0;
        PC_in = 0;
        Data_in = 0;
        Constant_in = 1;
        
        //SLLI C=2C
        we = 1;
        MuxB_sel = 0;
        MuxD_sel = 0;
        MuxR_sel = 1;
        Sel = 4'b1x00;
        AA = 0;
        BA = 0;
        DA = 0;
        PC_in = 0;
        Data_in = 0;
        Constant_in = 0;
        
        
        // Make sure to adjust the delay to match your clock speed
        #10;
    end

    // Clock Generation
    always #5 clk = ~clk;
endmodule
