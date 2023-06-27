module ALU#(parameter SIZE=32)(
    input [SIZE-1:0] A,B,imm,pc,
    input [3:0] GSel,
    input [2:0] branch_in,
    input JAL,JALR,
    input sub,
    output reg [SIZE-1:0]G,
    output reg BRANCH_OUT,
    output wire  CO, V, C, N, Z
);
    wire [2:0] S; 
    wire  Cin;
    wire [SIZE-1:0]and_out,or_out,xor_out,cla_out;
    reg [SIZE-1:0]rs1,rs2,cla_in1,cla_in2;
    
    assign {S,Cin} = GSel ;

    /* FOR BRANCH */
    always @(*)
    begin
        if ( branch_in || JAL ) 
        begin
            cla_in1 = pc;
            cla_in2 = imm;
        end
        else if ( JALR || Cin )    
        begin
            cla_in1 = A;
            cla_in2 = imm;
        end
        else 
        begin
            cla_in1 = A;
            cla_in2 = B;
        end
    end
    
    /* FOR LOGICAL OPERATION */
      
    always @(*)
    begin
        if( GSel[0] )
        begin
            rs1 = A;
            rs2 = imm;    
        end
        else
        begin
            rs1 = A;
            rs2 = B;    
        end        
    end
    
    always @(*) 
    begin
        case (GSel [3:1]) 
            3'b000:
            begin //AND
                G = and_out;
                BRANCH_OUT = 0;        
            end
            3'b001:
            begin //OR
                G = or_out;
                BRANCH_OUT = 0;
            end
            3'b010:
            begin //XOR
                G = xor_out;
                BRANCH_OUT = 0;
            end
            
            3'b011:
            begin
                G = cla_out; //ADDER
                BRANCH_OUT = 0;
            end
            
            3'b100:
            begin// unsigned branch
                if (branch_in == 3'b000)
                begin
                   BRANCH_OUT = (A <B) ?1'b1:1'b0;
                   G = cla_out;
                end
                else if (branch_in ==3'b001)
                begin
                    BRANCH_OUT = (A >= B)?1'b1:1'b0;
                    G = cla_out;
                end
                else if (branch_in == 3'b010)
                begin
                    BRANCH_OUT = (A == B) ? 1'b1 : 1'b0;
                    G = cla_out;
                end
                else if (branch_in == 3'b011)
                begin
                    BRANCH_OUT = (A != B) ? 1'b1 : 1'b0;
                    G = cla_out;
                end
                else if (branch_in == 3'b100)
                begin 
                    G = (rs1 < rs2) ? 32'd1 : 32'd0; 
                    BRANCH_OUT = 1'b0;
                end
                else if(JAL || JALR)
                begin
                    BRANCH_OUT = 1'b1;
                    G = cla_out;
                end
                else 
                begin
                    BRANCH_OUT = 1'b0;
                    G = cla_out;
                end
            end
            3'b101:
            begin // signed branch
                if (branch_in == 3'b000)
                begin
                    BRANCH_OUT = ($signed(A) < $signed(B)) ? 1'b1 : 1'b0;
                    G = cla_out;
                end
                else if (branch_in == 3'b001)
                begin
                    BRANCH_OUT = ($signed(A) >= $signed(B)) ? 1'b1 : 1'b0;
                    G = cla_out;
                end
                else
                begin
                    G = ($signed(rs1) < $signed(rs2)) ? 32'd1 : 32'd0;
                    BRANCH_OUT = 1'b0;
                end
            end
        endcase
    end
    
    AND AND( .I1(rs1), .I2(rs2), .O(and_out));
    OR OR( .I1(rs1), .I2(rs2), .O(or_out));
    XOR XOR( .I1(rs1), .I2(rs2), .O(xor_out));
    CLA #(.size(32)) CLA(.x(cla_in1),. y(cla_in2), .ci(GSel[0]), .sub(sub), .cout(CO), .NF(N), .CF(C), .OF(V), .s(cla_out));
    ZERO_DETECT ZERO_DETECT( .ALU_OUT(G), .Z(Z));
endmodule

    