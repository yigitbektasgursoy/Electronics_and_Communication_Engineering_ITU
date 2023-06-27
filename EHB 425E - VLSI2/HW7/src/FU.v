module FU#(parameter SIZE = 32)(
    input [SIZE-1:0] A, 
    input [SIZE-1:0] B, 
    input [3:0] Sel, 
    output reg [SIZE-1:0] F,
    output reg C,
    output reg V,
    output reg N,
    output reg Z);
    
    wire [SIZE-1:0]ALU_OUT, SHIFT_OUT;
    
    ALU #(.SIZE(SIZE)) ALU(
        .A(A),
        .B(B),
        .Cin(Sel[3]),
        .S(Sel[2:0]),
        .G(ALU_OUT),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z));
        
    Shifter #(.SIZE(SIZE))Shifter(
        .A(A),
        .B(B),
        .shamt(B[$clog2(SIZE)-1 :0]),
        .shift_type(Sel[1:0]),
        .SHIFT_OUT(SHIFT_OUT)
    );
    always @(*)
    begin
        case(Sel[3])
            1'b0:
            begin
                F=ALU_OUT;
            end
            1'b1:
            begin
                C = 0;
                V = 0;
                N = 0;
                Z = 0;
                F=SHIFT_OUT;
            end
        endcase     
    end
endmodule