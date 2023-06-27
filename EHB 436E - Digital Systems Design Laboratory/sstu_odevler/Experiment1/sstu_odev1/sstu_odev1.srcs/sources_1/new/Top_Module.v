module Top_Module(
    input [14:0]IN,
    output [7:0]OUT
    );
    
    AND_gate U1(
    .I1(IN[0]),
    .I2(IN[1]),
    .O(OUT[0]));
    
    OR_gate U2(
    .I1(IN[2]),
    .I2(IN[3]),
    .O(OUT[1]));
    
    NOT_gate U3(
    .I(IN[4]),
    .O(OUT[2]));
    
    NAND_gate U4(
    .I1(IN[5]),
    .I2(IN[6]),
    .O(OUT[3]));
    
    NOR_gate U5(
    .I1(IN[7]),
    .I2(IN[8]),
    .O(OUT[4]));
    
    EXOR_gate U6(
    .I1(IN[9]),
    .I2(IN[10]),
    .O(OUT[5]));
    
    EXNOR_gate U7(
    .I1(IN[11]),
    .I2(IN[12]),
    .O(OUT[6]));
    
    TRI U8(
    .I(IN[13]),
    .E(IN[14]),
    .O(OUT[7]));    
    
    endmodule

