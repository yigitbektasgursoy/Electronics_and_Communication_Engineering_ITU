module Compressor_42
(
    input [31:0] X1,
    input [31:0] X2,
    input [31:0] X3,
    input [31:0] X4,
    input [31:0] Cin,
    output [31:0]Cout,
    output [31:0] CARRY,
    output [31:0] SUM
);
    wire [31:0] fa_sum1;
    
    FULL_ADDER_32 FA1(.X1(X1), .X2(X2), .X3(X3), .Cin(0), .SUM(fa_sum1), .Cout(Cout));
    FULL_ADDER_32 FA2(.X1(Cin), .X2(fa_sum1), .X3(X4), .Cin(0), .SUM(SUM), .Cout(CARRY));

endmodule