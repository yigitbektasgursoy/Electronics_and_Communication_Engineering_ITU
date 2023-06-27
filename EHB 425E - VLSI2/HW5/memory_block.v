module memory_block #(parameter WIDTH=8, DEPTH=32) (
    input clk, rst,
    input [$clog2(DEPTH)-1:0] rd_addr0, wr_addr0,
    input [WIDTH-1:0] wr_din0,
    input we0,
    output wire [WIDTH-1:0] rd_dout0
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];
    integer i;
    always @(posedge clk, negedge rst) begin
        if (~rst) 
        begin
        // Reset the memory to 0
            for (i = 0; i < DEPTH; i = i + 1) 
            begin
                mem[i] <= 0;
            end
        end  // Write operation
        else if (we0) 
        begin
            mem[wr_addr0] <= wr_din0;
        end
    end
    assign rd_dout0 = mem[rd_addr0];
endmodule
