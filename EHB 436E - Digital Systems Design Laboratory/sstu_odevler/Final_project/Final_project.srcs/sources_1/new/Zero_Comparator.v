`timescale 1ns / 1ps

module Zero_Comparator(
    input [7:0] a,
    output Z
    );
    
    assign Z = ~(a[0] || a[1] || a[2] || a[3] || a[4] || a[5] || a[6] || a[7]); 
    
endmodule
