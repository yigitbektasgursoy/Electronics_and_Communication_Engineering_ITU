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