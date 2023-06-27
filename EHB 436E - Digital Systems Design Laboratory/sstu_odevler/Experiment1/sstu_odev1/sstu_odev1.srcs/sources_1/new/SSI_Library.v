`timescale 1ns / 1ps

/* AND GATE */
module AND_gate (
    input  I1,
    input  I2,
    output  O
);
    assign O = I1 & I2;
endmodule

/* OR GATE */
module OR_gate (
    input  I1,
    input  I2,
    output O
);
    assign O = I1 | I2;
endmodule

/* NOT GATE */
module NOT_gate (
    input I,
    output O
);
    assign O = ~I;
endmodule

//NAND GATE
module NAND_gate (
    input I1,
    input I2,
    output reg  O
);
    always@*
    begin
        O = ~( I1 & I2);      
    end
endmodule

/* NOR gate */
module NOR_gate (
    input I1,
    input I2,
    output reg O
);
    always@*
    begin
        O = ~( I1 | I2);      
    end
endmodule

//EXOR GATE
module EXOR_gate(
    input I1, 
    input I2,
    output O
    );
    
    LUT2 #(
    .INIT ( 4'b0110 ) 
	) EXOR
	(
    .I0( I1 ),
    .I1( I2 ),
    .O ( O )
    );
endmodule

//EXNOR GATE
module EXNOR_gate(
    input I1, 
    input I2,
    output O
    );
    
    LUT2 #(
    .INIT ( 4'b1001 ) 
	) EXOR
	(
    .I0( I1 ),
    .I1( I2 ),
    .O ( O )
    );
endmodule

//TRI
module TRI(
    input I,
    input E,
    output O
    );
    assign O = ( E == 1'b1) ? I : 1'bZ;
endmodule


