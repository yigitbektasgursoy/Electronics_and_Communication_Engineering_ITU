`timescale 1ns / 1ps

module ALU_tb;
    localparam SIZE=32;
    reg [SIZE-1:0] A,B,imm,pc;
    reg [3:0]GSel;
    reg [4:0] branch_in;
    reg sub, JAL, JALR;
    wire [SIZE-1:0]G;
    wire BRANCH_OUT, CO, V, C, N, Z;

    // Instantiate the ALU module
    ALU #(.SIZE(32))ALU(
        .A(A),
        .B(B),
        .imm(imm),
        .pc(pc),
        .GSel(GSel),
        .branch_in(branch_in),
        .JAL(JAL),
        .JALR(JALR),
        .sub(sub),
        .G(G),
        .BRANCH_OUT(BRANCH_OUT), .CO(CO), .V(V), .C(C), .N(N), .Z(Z)
    );
    
    // Stimulus process
    initial begin
        
        sub=1'b0; A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0; 
        branch_in = 0; JAL = 0; JALR = 0; GSel = 4'b0000; #20; //AND
       
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0; 
        branch_in = 0; JAL = 0; JALR = 0; GSel = 4'b0010; #20; //OR
       
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0; 
        branch_in = 0; JAL = 0; JALR = 0; GSel = 4'b0100; #20; //XOR
       
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0; 
        branch_in = 0; JAL = 0; JALR = 0; GSel = 4'b0110; #20; //ADDER
        
        sub=1'b1; A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0; 
        branch_in = 0; JAL = 0; JALR = 0; GSel = 4'b0110; #20; //SUBSTRACTOR
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 3'b000; JAL = 0; JALR = 0; GSel = 4'b1000; #20; //branch A<B
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 3'b001; JAL = 0; JALR = 0; GSel = 4'b1000; #20; //branch A>=B
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 3'b010; JAL = 0; JALR = 0; GSel = 4'b1000; #20; //branch A=B
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 3'b011; JAL = 0; JALR = 0; GSel = 4'b1000; #20; //branch A!=B
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 3'b100; JAL = 0; JALR = 0; GSel = 4'b1000; #20; //G = (rs1 < rs2) ? 32'd1 : 32'd0;
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 3'b100; JAL = 0; JALR = 0; GSel = 4'b1000; #20; //branch rs1<rs2 
                       
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 0; JAL = 1; JALR = 0; GSel = 4'b1000; #20; //branch rs1<rs2
         
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 0; JAL = 1; JALR = 0; GSel = 4'b1000; #20; //JAL||JALR 
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;
        branch_in = 3'b101; JAL = 0; JALR = 0; GSel = 4'b1000; #20; //branch
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;      
        branch_in = 3'b000; JAL = 0; JALR = 0; GSel = 4'b1010; #20; //$signed(A) < $signed(B)
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;      
        branch_in = 3'b001; JAL = 0; JALR = 0; GSel = 4'b1010; #20; //$signed(A) >= $signed(B)
        
        A = $urandom%-1; B = $urandom%-1; imm = $urandom%-1; pc = $urandom%-1; GSel[0] = 0;      
        branch_in = 3'b011; JAL = 0; JALR = 0; GSel = 4'b1010; #20; // G= ($signed(rs1) < $signed(rs2)) ? 32'd1 : 32'd0;
           
        #100;
        $finish;
        end
endmodule