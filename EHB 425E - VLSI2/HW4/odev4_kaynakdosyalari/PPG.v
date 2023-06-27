module PPG
    (
    input wire [15:0] X,
    input wire [15:0] Y,
    output wire [31:0] PP0,
    output wire [31:0] PP1,
    output wire [31:0] PP2,
    output wire [31:0] PP3,
    output wire [31:0] PP4,
    output wire [31:0] PP5,
    output wire [31:0] PP6,
    output wire [31:0] PP7,
    output wire [31:0] PP8,
    output wire [31:0] PP9,
    output wire [31:0] PP10,
    output wire [31:0] PP11,
    output wire [31:0] PP12,
    output wire [31:0] PP13,
    output wire [31:0] PP14,
    output wire [31:0] PP15
    );
    
    wire [31:0]PP[15:0];
 
    genvar i;
    generate
        for(i = 0; i <= 15; i = i + 1)
        begin: PP_LOOP //PARTIAL PRODUCT
            assign PP[i][31:0] = (X[i] * Y) << i;
        end
    endgenerate
    
    assign PP0 = PP[0];
    assign PP1 = PP[1];
    assign PP2 = PP[2];
    assign PP3 = PP[3];
    assign PP4 = PP[4];
    assign PP5 = PP[5];
    assign PP6 = PP[6];
    assign PP7 = PP[7];
    assign PP8 = PP[8];
    assign PP9 = PP[9];
    assign PP10 = PP[10];
    assign PP11 = PP[11];
    assign PP12 = PP[12];
    assign PP13 = PP[13];
    assign PP14 = PP[14];
    assign PP15 = PP[15];   
 endmodule