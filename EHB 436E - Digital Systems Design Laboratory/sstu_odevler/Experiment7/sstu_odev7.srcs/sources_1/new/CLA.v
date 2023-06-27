module CLG
(
    input [15:0] P,
    input [15:0] G,
    input ci,
    
    output [16:0] cout
);

    assign cout[0] = ci;
    
    genvar i;
    generate
        for(i = 0; i <= 15; i = i + 1)
        begin
            assign cout[i+1] = G[i] | (P[i] & cout[i]);
        end
    endgenerate

endmodule

module CLA
(
    input [15:0] x,
    input [15:0] y,
    input ci,
    
    output cout,
    output [15:0] s
);

    wire [15:0] P;
    wire [15:0] G;
    
    wire [16:0] C;

    assign P = x ^ y;
    assign G = x & y;
    
    CLG CLG
    (
        .P(P),
        .G(G),
        .ci(ci),
        
        .cout(C)
    );

    assign C[0] = ci;
    
    genvar i;
    generate
        for(i = 0; i <= 15; i = i + 1)
        begin
            assign s[i] = C[i] ^ P[i];
        end
    endgenerate
    
    assign cout = C[16];

endmodule


module Behav_Adder
    (
    input [15:0]A, 
    input [15:0]B, 
    output reg[15:0]sum
    );
    always@*
    begin
        sum <= A + B;
    end
endmodule