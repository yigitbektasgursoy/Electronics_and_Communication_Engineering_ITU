module memory_block_tb;

  // Parameters
  parameter WIDTH = 32;
  parameter DEPTH = 128;
  parameter initFile = "C:/Users/yigit/Desktop/Okul/2023bahar/VLSI2/HW5/odev5/odev5.srcs/sources_1/new/machine_code.txt";

  // Inputs
  reg clk, rst;
  reg [$clog2(DEPTH)-1:0] rd_addr0, wr_addr0;
  reg [WIDTH-1:0] wr_din0;
  reg we0;

  // Outputs
  wire [WIDTH-1:0] rd_dout0;

  // Instantiate memory block
  memory_block #(.WIDTH(WIDTH), .DEPTH(DEPTH)) dut (
    .clk(clk),
    .rst(rst),
    .rd_addr0(rd_addr0),
    .wr_addr0(wr_addr0),
    .wr_din0(wr_din0),
    .we0(we0),
    .rd_dout0(rd_dout0)
  );

  // Clock generation
  always #10 clk = ~clk;

  // Reset generation
  initial begin
    clk = 0;
    rst = 0;
    we0 = 0;
    #10 rst = 1;
    we0 = 1;

  end
  reg [WIDTH-1:0] test_memory [0:DEPTH-1];
  integer i;
  integer j;
  // Load instructions into memory
  initial begin
    $readmemb(initFile, test_memory);
    // Initialize memory inside the memory_block module
    for (i = 0; i < DEPTH; i = i+1) begin
      wr_addr0 = i;
      wr_din0 = test_memory[i];
      #20;
    end
  end
  
  // Display contents of memory after loading data file
  initial begin
    #10
    $display("Contents of memory after reading data file:");
    for (j =0; j < DEPTH; j = j+1) 
    begin
      rd_addr0 = j ;
      #20; 
      $display("%d: MachineCode Hexadecimal:%h MachineCode Binary:%b", rd_addr0, rd_dout0, rd_dout0);  
    end
  end



endmodule