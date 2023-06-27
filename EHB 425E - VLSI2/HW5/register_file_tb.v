module register_file_tb;

    // Parameters
    localparam WIDTH = 32;
    localparam DEPTH = 32;

    // Inputs
    reg clk, rst;
    reg [$clog2(DEPTH)-1:0] rd_addr0, wr_addr0, rd_addr1;
    reg [WIDTH-1:0] wr_din0;
    reg we0;

    // Outputs
    wire [WIDTH-1:0] rd_dout0, rd_dout1;

    // Instantiate the register file module
    register_file #(WIDTH, DEPTH) dut (
        .clk(clk),
        .rst(rst),
        .rd_addr0(rd_addr0),
        .wr_addr0(wr_addr0),
        .rd_addr1(rd_addr1),
        .wr_din0(wr_din0),
        .we0(we0),
        .rd_dout0(rd_dout0),
        .rd_dout1(rd_dout1)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;
        wr_addr0 = 1;
        wr_din0 = 1234;
        we0 = 1;

        // Wait for a few clock cycles for the reset to take effect
        #10;
        rst = 1;

        // Write a value to register 1
        wr_addr0 = 1;
        wr_din0 = 1234;
        we0 = 1;
        #10;
        we0 = 0;

        // Write a value to register 2
        wr_addr0 = 2;
        wr_din0 = 5678;
        we0 = 1;
        #10;
        we0 = 0;

        // Read the values from register 1 and 2
        rd_addr0 = 1;
        rd_addr1 = 2;
        #10;
        if (rd_dout0 !== 1234) begin
            $display("Error: rd_dout0 = %d", rd_dout0);
        end
        if (rd_dout1 !== 5678) begin
            $display("Error: rd_dout1 = %d", rd_dout1);
        end
        
        #10 rd_addr1 = 0;
        // Write a value to the zero register
        wr_addr0 = 0;
        wr_din0 = 4321;
        we0 = 1;
        #10;
        we0 = 0;

        // Read the value from the zero register
        rd_addr0 = 0;
        #10;
        if (rd_dout0 !== 0) begin
            $display("Error: rd_dout0 = %d", rd_dout0);
        end

        $display("Testbench completed");
        $finish;
    end

    always #5 clk = ~clk;

endmodule
