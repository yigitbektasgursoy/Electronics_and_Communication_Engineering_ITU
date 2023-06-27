module data_memory #(parameter WIDTH=32, DEPTH=128) (
    input clk, rst,
    input [$clog2(DEPTH)-1:0] rd_addr0, wr_addr0,
    input [WIDTH-1:0] wr_din0,
    input [3:0] wr_strb, // write strobe
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
        end  
        else if (we0) 
        begin
            case (wr_strb)
                4'b0001: mem[wr_addr0][7:0] <= wr_din0[7:0]; // byte write
                4'b0010: mem[wr_addr0][15:8] <= wr_din0[7:0]; // byte write
                4'b0011: mem[wr_addr0][23:16] <= wr_din0[7:0]; // byte write
                4'b0100: mem[wr_addr0][31:24] <= wr_din0[7:0]; // byte write
                4'b0101: mem[wr_addr0][15:0] <= wr_din0[15:0]; // half-word write 
                4'b0110: mem[wr_addr0][31:16] <= wr_din0[15:0]; // half-word write 
                4'b0111: mem[wr_addr0] <= wr_din0[31:0]; // word write
                default: mem[wr_addr0] <= 0; // default: do nothing
            endcase
        end
    end
    assign rd_dout0 = mem[rd_addr0];
endmodule
