module CLG#(parameter SIZE=32)
(
    input [SIZE-1:0] P,
    input [SIZE-1:0] G,
    input ci,
    
    output [SIZE:0] cout
);

    assign cout[0] = ci;
    
    genvar i;
    generate
        for(i = 0; i <= SIZE; i = i + 1)
        begin
            assign cout[i+1] = G[i] | (P[i] & cout[i]);
        end
    endgenerate

endmodule
