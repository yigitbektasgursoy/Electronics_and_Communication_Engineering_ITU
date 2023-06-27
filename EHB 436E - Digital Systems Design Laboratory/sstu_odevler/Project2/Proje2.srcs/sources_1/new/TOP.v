`timescale 1ns / 1ps

module PROJECT2(
    input res,
    input clk,
    input x,
    
    output reg Z
    );
    
    wire [7:0] Q;
    reg [7:0] q;
    wire detected_a, detected_b, lock_state_a, lock_state_b, z;
    
    // KARNAUGH MAP ASSIGN
    assign Q[0] = ~x || ( q[1] & ~q[0] ) ;
    assign Q[1] =  x & (q[1] ^ q[0]) ;
    
    assign Q[2] = ( ~x & ~q[3] & ~q[2] ) || ( x & q[3] & ~q[2] ) || ( ~x & q[3] & q[2] ) ;
    assign Q[3] = ( ~x & ~q[3] & q[2] ) || ( q[3] & ~q[2] ) ;
    
    assign Q[4] = ( detected_a & ~q[5] & ~q[4]) || ( ~detected_a & q[4] ) ;
    assign Q[5] = ( detected_a & q[4] ) || q[5] ;
    
    assign Q[6] = ( detected_b & ~q[7] & ~q[6]) || ( ~detected_b & q[6] ) ;
    assign Q[7] = ( detected_b & q[6] ) || q[7] ;
    
    // DETECTED ASSIGN FOR A AND B
    assign detected_a = x & q[1] & q[0] ;
    assign detected_b = x & q[3] & q[2] ;
    
    // LOCK STATE ASSIGN
    assign lock_state_a = q[5];
    assign lock_state_b = q[7];
    
    // OUTPUT ASSIGN
    assign z = lock_state_a || lock_state_b || detected_a || detected_b;
    
    always@ (posedge clk or posedge res)
    begin
        if (res)
        begin
            q[7:0] <= 8'b0000_0000;
        end
        
        else
        begin
            q[0] <= Q[0];
            q[1] <= Q[1];
            q[2] <= Q[2];
            q[3] <= Q[3];
            q[4] <= Q[4];
            q[5] <= Q[5];
            q[6] <= Q[6];
            q[7] <= Q[7];
            Z <= z;
        end
    end               
    
endmodule
