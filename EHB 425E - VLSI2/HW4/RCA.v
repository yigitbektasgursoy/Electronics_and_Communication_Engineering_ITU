module RCA #( parameter SIZE=32 )
    (
    input [SIZE-1:0]X,
    input [SIZE-1:0]Y,
    input CIN,
    
    output COUT,
    output [SIZE-1:0]S
    );
    
    wire [SIZE:0]signal;
 
    assign signal[0] = CIN;
 
    genvar i;
    generate
    for(i = 0; i < SIZE; i = i + 1)
        begin: generated_FA
        
        FA fulladder(
            X[i],
            Y[i],
            signal[i],
 
            signal[i+1],
            S[i]
            );
        end
    endgenerate
    
    assign COUT = signal[SIZE];
endmodule