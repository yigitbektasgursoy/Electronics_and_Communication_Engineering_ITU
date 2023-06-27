module MUL(
    input wire [15:0] X,
    input wire [15:0] Y,
    output wire [31:0] result 
);

wire [31:0] PP0, PP1, PP2, PP3, PP4, PP5, PP6, PP7, PP8, PP9, PP10, PP11, PP12, PP13, PP14, PP15, COUT, CARRY, SUM;

PPG PPG(.X(X), .Y(Y), .PP0(PP0), .PP1(PP1), .PP2(PP2), .PP3(PP3), .PP4(PP4), .PP5(PP5), .PP6(PP6), .PP7(PP7),
        .PP8(PP8), .PP9(PP9), .PP10(PP10), .PP11(PP11), .PP12(PP12), .PP13(PP13), .PP14(PP14), .PP15(PP15));
        
PPA PPA(.PP0(PP0), .PP1(PP1), .PP2(PP2), .PP3(PP3), .PP4(PP4), .PP5(PP5), .PP6(PP6), .PP7(PP7), .PP8(PP8),
        .PP9(PP9), .PP10(PP10), .PP11(PP11), .PP12(PP12), .PP13(PP13), .PP14(PP14), .PP15(PP15), .CARRY(CARRY), .SUM(SUM));

RCA #(.SIZE(32)) RCA(.X(CARRY), .Y(SUM), .CIN(0), .COUT(COUT), .S(result));
endmodule