//module ALU#(parameter SIZE=32)(
//    input [SIZE-1:0] A,B,imm,pc,
//    input [3:0] GSel,
//    input [2:0] Branch_in,
//    input JAL,JALR,
//    input sub,
//    output reg [SIZE-1:0]G,
//    output reg Branch_out,
//    output wire  CO, V, C, N, Z
//);
//    wire [2:0] S; 
//    wire  Cin;
//    wire [SIZE-1:0]and_out,or_out,xor_out,CLA_out;
//    reg [SIZE-1:0]rs1,rs2,CLA_in1,CLA_in2;
    
//    assign {S,Cin} = GSel ;

//    /* FOR BRANCH */
//    always @(*)
//    begin
//        if ( Branch_in || JAL ) 
//        begin
//            CLA_in1 = pc;
//            CLA_in2 = imm;
//        end
//        else if ( JALR || Cin )    
//        begin
//            CLA_in1 = A;
//            CLA_in2 = imm;
//        end
//        else 
//        begin
//            CLA_in1 = A;
//            CLA_in2 = B;
//        end
//    end
    
//    /* FOR LOGICAL OPERATION */
      
//    always @(*)
//    begin
//        if( GSel[0] )
//        begin
//            rs1 = A;
//            rs2 = imm;    
//        end
//        else
//        begin
//            rs1 = A;
//            rs2 = B;    
//        end        
//    end
    
//    always @(*) 
//    begin
//        case (GSel [3:1]) 
//            3'b000:
//            begin //AND
//                G = and_out;
//                Branch_out = 0;        
//            end
//            3'b001:
//            begin //OR
//                G = or_out;
//                Branch_out = 0;
//            end
//            3'b010:
//            begin //XOR
//                G = xor_out;
//                Branch_out = 0;
//            end
            
//            3'b011:
//            begin
//                G = CLA_out; //ADDER
//                Branch_out = 0;
//            end
            
//            3'b100:
//            begin// unsigned branch
//                if (Branch_in == 3'b000)
//                begin
//                   Branch_out = (A <B) ?1'b1:1'b0;
//                   G = CLA_out;
//                end
//                else if (Branch_in ==3'b001)
//                begin
//                    Branch_out = (A >= B)?1'b1:1'b0;
//                    G = CLA_out;
//                end
//                else if (Branch_in == 3'b010)
//                begin
//                    Branch_out = (A == B) ? 1'b1 : 1'b0;
//                    G = CLA_out;
//                end
//                else if (Branch_in == 3'b011)
//                begin
//                    Branch_out = (A != B) ? 1'b1 : 1'b0;
//                    G = CLA_out;
//                end
//                else if (Branch_in == 3'b100)
//                begin 
//                    G = (rs1 < rs2) ? 32'd1 : 32'd0; 
//                    Branch_out = 1'b0;
//                end
//                else if(JAL || JALR)
//                begin
//                    Branch_out = 1'b1;
//                    G = CLA_out;
//                end
//                else 
//                begin
//                    Branch_out = 1'b0;
//                    G = CLA_out;
//                end
//            end
//            3'b101:
//            begin // signed branch
//                if (Branch_in == 3'b000)
//                begin
//                    Branch_out = ($signed(A) < $signed(B)) ? 1'b1 : 1'b0;
//                    G = CLA_out;
//                end
//                else if (Branch_in == 3'b001)
//                begin
//                    Branch_out = ($signed(A) >= $signed(B)) ? 1'b1 : 1'b0;
//                    G = CLA_out;
//                end
//                else
//                begin
//                    G = ($signed(rs1) < $signed(rs2)) ? 32'd1 : 32'd0;
//                    Branch_out = 1'b0;
//                end
//            end
//        endcase
//    end
    
//    AND AND( .I1(rs1), .I2(rs2), .O(and_out));
//    OR OR( .I1(rs1), .I2(rs2), .O(or_out));
//    XOR XOR( .I1(rs1), .I2(rs2), .O(xor_out));
//    CLA #(.size(32)) CLA(.x(CLA_in1),. y(CLA_in2), .ci(GSel[0]), .sub(sub), .cout(CO), .NF(N), .CF(C), .OF(V), .s(CLA_out));
//    ZERO_DETECT ZERO_DETECT( .ALU_OUT(G), .Z(Z));
//endmodule

`timescale 1ns / 1ps
module ALU #(parameter SIZE=32)(
    input [SIZE-1:0]A,
    input [SIZE-1:0]B,
    input Cin,
    input [2:0]S,
    output reg [SIZE-1:0]G,
    output C,V,N,Z
    );
    
    wire Cout;
    wire [SIZE-1:0] arithmetic_out;
    wire [SIZE-1:0] logic_out;

    ARITHMETIC_UNIT #(.SIZE(SIZE))  arithmetic_unit(
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S[1:0]),
    .G(arithmetic_out),
    .Cout(Cout),
    .C(C),
    .V(V),
    .N(N),
    .Z(Z)
    );
    
    LOGICAL_UNIT #(.SIZE(SIZE)) logical_unit(
    .A(A),
    .B(B),
    .S({Cin,S[0]}),
    .G(logic_out)
    );
    
    always @(*)
    begin
        if(S[2]) begin
            G = logic_out;
        end
        else begin
            G = arithmetic_out;
        end
    end
endmodule


module ARITHMETIC_UNIT #(parameter SIZE=32)(
    input [SIZE-1:0]A,
    input [SIZE-1:0]B,
    input Cin,
    input [1:0]S,
    output [SIZE-1:0]G,
    output Cout,
    output C,V,N,Z);
	
    wire sub,usign;
	assign sub = S[1] | S[0];
	assign usign = S[1] & S[0];
	
    CLA #(.SIZE(SIZE)) adder_substractor( 
        .x(A),
        .y(B),
        .ci(Cin),
        .sub (sub),
        .cout(Cout),
        .NF(N),
        .CF(C),
        .OF(V),
        .s(G));
    
endmodule


module LOGICAL_UNIT #(parameter SIZE=32)(
    input [SIZE-1:0]A,
    input [SIZE-1:0]B,
    input [1:0]S,
    output reg [SIZE-1:0]G);
    
    wire [SIZE-1:0] and_out,or_out,xor_out,CLA_out;
    
    AND AND( .I1(A), .I2(B), .O(and_out));
    OR OR( .I1(A), .I2(B), .O(or_out));
    XOR XOR( .I1(A), .I2(B), .O(xor_out));
    
    always @(*) 
    begin
        case (S[1:0]) 
            2'b00:
            begin //AND
                G = and_out;      
            end
            2'b01:
            begin //OR
                G = or_out;
            end
            2'b10:
            begin //XOR
                G = xor_out;
            end
            default:
            begin
                G = {SIZE{1'b0}};
            end
         endcase
     end
endmodule

    