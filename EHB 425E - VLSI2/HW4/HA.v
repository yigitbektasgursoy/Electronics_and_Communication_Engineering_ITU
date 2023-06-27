module HA(
    input X,
    input Y,
    
    output COUT,
    output S
    );
    
    assign COUT = X & Y; //CARRY
    assign S = X ^ Y ; //SUM
    
endmodule