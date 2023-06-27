`timescale 1ns / 1ps

module arithmetic_circuits();
endmodule

module HA(
    input X,
    input Y,
    
    output COUT,
    output S
    );
    
    assign COUT = X & Y; //CARRY
    assign S = X ^ Y ; //SUM
    
endmodule

module FA(
    input X,
    input Y,
    input CIN,
    
    output COUT,
    output S
    );
    wire signal_1;
    wire signal_2;
    wire signal_3;
 
    HA halfadder1 ( .X(X), 
                    .Y(Y), 
                    
                    .COUT(signal_1), 
                    .S(signal_2) 
                    );
    HA halfadder2 ( .X(signal_2), 
                    .Y(CIN),
                     
                    .COUT(signal_3), 
                    .S(S) 
                    );
    assign COUT = signal_3 | signal_1;               
endmodule

module RCA(
    input [3:0]X,
    input [3:0]Y,
    input CIN,
    
    output COUT,
    output [3:0]S
    );
    (* dont_touch = "true" *)wire c1,c2,c3,c4;
 
    FA fulladder1(
        .X(X[0]),
        .Y(Y[0]),
        .CIN(CIN),
        
        .COUT(c1),
        .S(S[0])
        );
        
    FA fulladder2(
        .X(X[1]),
        .Y(Y[1]),
        .CIN(c1),
        
        .COUT(c2),
        .S(S[1])
        );
        
    FA fulladder3(
        .X(X[2]),
        .Y(Y[2]),
        .CIN(c2),
        
        .COUT(c3),
        .S(S[2])
        );
        
    FA fulladder4(
        .X(X[3]),
        .Y(Y[3]),
        .CIN(c3),
        
        .COUT(COUT),
        .S(S[3])
        );
                
endmodule

module parametric_RCA #( parameter SIZE=8 )
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

module CGA ( //carry , generate , propagate
            input [3:0]P,
            input [3:0]G,
            input CIN,
            
            output [3:0]COUT
            );
            
    assign COUT[0] = G[0] | (P[0] & CIN);
    assign COUT[1] = G[1] | (G[0] & P[1]) | (P[1] & P[0] & CIN);
    assign COUT[2] = G[2] | (G[1] & P[2]) | (G[0] & P[2] & P[1]) | ( P[2] & P[1] & P[0] & CIN);
    assign COUT[3] = G[3] | (G[2] & P[3]) | (G[1] & P[3] & P[2]) | (G[0] & P[3] & P[2] & P[1]) | (P[3] & P[2] & P[1] & P[0] & CIN);
endmodule
            
module CLA (
            input [15:0]X,
            input [15:0]Y,
            input CIN,
            
            output COUT,
            output [15:0]S
            );
            
    wire [15:0]P;
    wire [15:0]G;
    wire [15:0]C;
    
    assign P = X ^ Y;
    assign G = X & Y;
    
    CGA CGA(
            .P(P),
            .G(G),
            
            .CIN(CIN),
            .COUT(C)
            );
                    
    assign COUT = C[15];
    
    assign S[0] = P[0] ^ CIN;
    assign S[1] = P[1] ^ C[0];
    assign S[2] = P[2] ^ C[1];
    assign S[3] = P[3] ^ C[2];
      
endmodule            

module ADD_SUB
    (
    input [3:0]A,
    input [3:0]B,
    input CIN,
    
    output [3:0]SUM,
    output COUT,
    output V
    );
    wire fa1_in, fa2_in, fa3_in, fa4_in;
    wire fa1_cout, fa2_cout, fa3_cout;
 
    assign fa1_in = CIN ^ B[0];
    assign fa2_in = CIN ^ B[1];
    assign fa3_in = CIN ^ B[2];
    assign fa4_in = CIN ^ B[3];
    FA FA1
    (
    .X(A[0]),
    .Y(fa1_in),
    .CIN(CIN),
    
    .COUT(fa1_cout),
    .S(SUM[0])
    );
    
    FA FA2
    (
    .X(A[1]),
    .Y(fa2_in),
    .CIN(fa1_cout),
    
    .COUT(fa2_cout),
    .S(SUM[1])
    );
    
    FA FA3
    (
    .X(A[2]),
    .Y(fa3_in),
    .CIN(fa2_cout),
    
    .COUT(fa3_cout),
    .S(SUM[2])
    );
    
    FA FA4
    (
    .X(A[3]),
    .Y(fa4_in),
    .CIN(fa3_cout),
    
    .COUT(COUT),
    .S(SUM[3])
    );
    
    assign V = fa3_cout ^ COUT;
          
endmodule