`timescale 1ns / 1ps

module data_memory_tb;

    // Parameters
    parameter WIDTH = 32;
    parameter DEPTH = 128;

    // Signals
    reg clk;
    reg rst;
    reg [$clog2(DEPTH)-1:0] rd_addr0;
    reg [$clog2(DEPTH)-1:0] wr_addr0;
    reg [WIDTH-1:0] wr_din0;
    reg [3:0] wr_strb;
    reg we0;
    wire [WIDTH-1:0] rd_dout0;

    // Instantiate DUT
    data_memory #(.WIDTH(WIDTH), .DEPTH(DEPTH)) dut (
        .clk(clk),
        .rst(rst),
        .rd_addr0(rd_addr0),
        .wr_addr0(wr_addr0),
        .wr_din0(wr_din0),
        .wr_strb(wr_strb),
        .we0(we0),
        .rd_dout0(rd_dout0)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        // Reset
        clk = 0;
        rst = 0;
        #10 rst = 1;

        // Write some data
        wr_strb = 4'b0111; // Word write
        we0 = 1;
        wr_addr0 = 0;
        wr_din0 = 32'h12345678;
        #10;
        we0 = 0;

        // Read the data back
        rd_addr0 = 0;
        #10;
        if (rd_dout0 !== 32'h12345678) $display("ERROR: Unexpected data read");

        // Write some more data with byte write strobes
        wr_strb = 4'b0001; // Byte write
        we0 = 1;
        wr_addr0 = 1;
        wr_din0 = 8'haa;
        #10;
        wr_strb = 4'b0010; // Byte write
        wr_addr0 = 1;
        wr_din0 = 8'hbb;
        #10;
        wr_strb = 4'b0011; // Byte write
        wr_addr0 = 1;
        wr_din0 = 8'hcc;
        #10;
        wr_strb = 4'b0100; // Byte write
        wr_addr0 = 1;
        wr_din0 = 8'hdd;
        #10;
        we0 = 0;

        // Read the data back
        rd_addr0 = 1;
        #10;
        if (rd_dout0 !== 32'hddccbbaa) $display("ERROR: Unexpected data read");

        // Write some more data with half-word write strobes
        wr_strb = 4'b0101; // Half-word write
        we0 = 1;
        wr_addr0 = 2;
        wr_din0 = 16'h1234;
        #10;
        wr_strb = 4'b0110; // Half-word write
        wr_addr0 = 2;
        wr_din0 = 16'h5678;
        #10;
        we0 = 0;

        // Read the data back
        rd_addr0 = 2;
        #10;
        if (rd_dout0 !== 32'h56781234) $display("ERROR: Unexpected data read");

        // Finish simulation
        #10 $finish;
    end

endmodule
