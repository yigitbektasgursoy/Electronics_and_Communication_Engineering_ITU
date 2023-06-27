//`timescale 1ns / 1ps

//module CLA_tb;
//    reg [31:0] x;
//    reg [31:0] y;
//    reg ci;
////    reg sub;
//    wire [31:0] s;
//    wire cout;
//    wire NF;
//    wire CF;

//    // Instantiate the CLA module
//    CLA #(.SIZE(32)) cla_inst
//    (
//        .x(x),
//        .y(y),
//        .ci(ci),
//        .sub(sub),
//        .cout(cout),
//        .NF(NF),
//        .CF(CF),
//        .s(s)
//    );

//    initial begin
//        // Test subtraction
//        x = 32'd100;
//        y = 32'd20;
//        ci = 1'b0;
////        sub = 1'b1;
        
//        #10; // Wait for 10 time units
//        x = 32'hF000_0000;
//        y = 32'hF000_0000;
//        ci = 1'b1;
////        sub = 1'b0;
        
//        #10; // Wait for 10 time units
//        x = 32'hF000_0000;
//        y = 32'hF000_0000;
//        ci = 1'b1;
////        sub = 1'b1; 
//        #10; // Wait for 10 time units
//        x = 32'hF000_0000;
//        y = 32'h1000_0000;
//        ci = 1'b1;
////        sub = 1'b0; 
//        #10; // Wait for 10 time units
//        $finish;
//    end
//endmodule


//`timescale 1ns / 1ps

//module CLA_testbench;

//    reg [31:0] x;
//    reg [31:0] y;
//    reg ci;
//    reg sub;
    
//    wire [31:0] s;
//    wire cout;
//    wire NF;
//    wire CF;
//    wire OF;

//    // Instantiate the CLA module
//    CLA #(.SIZE(32)) CLA_inst
//    (
//        .x(x),
//        .y(y),
//        .ci(ci),
//        .sub(sub),
//        .cout(cout),
//        .NF(NF),
//        .CF(CF),
//        .OF(OF),
//        .s(s)
//    );

//    // Stimuli
//    initial begin
//        $monitor("x=%h, y=%h, ci=%b, sub=%b, s=%h, cout=%b, NF=%b", x, y, ci, sub, s, cout, NF);

//        x = 32'h0000000A;
//        y = 32'h00000014;
//        ci = 1'b0;
//        sub = 1'b0;
//        #10;

//        x = 32'h0000000A;
//        y = 32'h00000014;
//        ci = 1'b0;
//        sub = 1'b1;
//        #10;

//        x = 32'hF000000A;
//        y = 32'hF0000014;
//        ci = 1'b1;
//        sub = 1'b0;
//        #10;

//        x = 32'h80000000;
//        y = 32'h00000001;
//        ci = 1'b0;
//        sub = 1'b1;
//        #10;

//        x = 32'h80000000;
//        y = 32'h00000001;
//        ci = 1'b0;
//        sub = 1'b0;
//        #10;

//        $finish;
//    end

//endmodule

`timescale 1ns / 1ps

module CLA_testbench;

    reg [31:0] x;
    reg [31:0] y;
    reg ci;
    reg sub;
    wire [31:0] s;
    wire cout;
    wire NF;
    wire OF; // Added overflow flag

    // Instantiate the CLA module
    CLA #(.SIZE(32)) CLA_inst
    (
        .x(x),
        .y(y),
        .ci(ci),
        .sub(sub),
        .cout(cout),
        .NF(NF),
        .OF(OF), // Connected overflow flag
        .s(s)
    );

    // Stimuli
    initial begin
        $monitor("x=%h, y=%h, ci=%b, sub=%b, s=%h, cout=%b, NF=%b, OF=%b", x, y, ci, sub, s, cout, NF, OF);

        // Addition (no overflow)
        x = 32'h0000000A;
        y = 32'h00000014;
        ci = 1'b0;
        sub = 1'b0;
        #10;

        // Subtraction (no overflow)
        x = 32'h0000000A;
        y = 32'h00000014;
        ci = 1'b0;
        sub = 1'b1;
        #10;

        // Addition with carry_in (no overflow)
        x = 32'h0000000A;
        y = 32'h00000014;
        ci = 1'b1;
        sub = 1'b0;
        #10;

        // Subtraction with overflow (positive)
        x = 32'h80000000;
        y = 32'h00000001;
        ci = 1'b0;
        sub = 1'b1;
        #10;

        // Addition (no overflow)
        x = 32'h80000000;
        y = 32'h00000001;
        ci = 1'b0;
        sub = 1'b0;
        #10;

        // Subtraction with overflow (negative)
        x = 32'h7FFFFFFF;
        y = 32'hFFFFFFFF;
        ci = 1'b0;
        sub = 1'b0;
        #10;

        $finish;
    end

endmodule

