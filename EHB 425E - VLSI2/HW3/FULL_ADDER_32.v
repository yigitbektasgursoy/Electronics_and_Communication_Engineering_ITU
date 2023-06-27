module FULL_ADDER_32(
    input wire [31:0] X1,
    input wire [31:0] X2,
    input wire [31:0] X3,
    input wire [31:0] Cin,
    output reg [31:0] SUM,
    output reg [31:0] Cout
);
    always @(*) 
        begin
        {Cout, SUM} = X1 + X2 + X3 + Cin;
        end
endmodule
