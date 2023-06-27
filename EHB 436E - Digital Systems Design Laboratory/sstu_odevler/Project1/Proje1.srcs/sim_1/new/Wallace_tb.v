`timescale 1ns / 1ps
module Wallace_tb();
    
    reg [15:0] A;
    reg [15:0] B;
    wire [31:0] C;
    wire carry;
    
    integer status;
    wire [31:0]Expected;
    integer fin_ptr, fout_ptr;

    Wallace_Tree_Mult UUT (
        .A(A),
        .B(B),
        .C(C),
        .carry(carry)
        );
    
    initial begin
        fin_ptr = $fopen("C:/Users/yigit/Desktop/random_numbers.txt","r");
        fout_ptr = $fopen("C:/Users/yigit/Desktop/output.txt","w");

        while(!$feof(fin_ptr)) 
            begin
            $fscanf(fin_ptr,"%d %d %d\n", A, B, Expected); #10;
            $display("A=%b, %d / B=%b, %d / Expected=%b, %d", A, A, B, B, Expected, Expected);
            $display("Result=%b, %d / carry=%b || Expected Result=%b, %d || Status = %d \n ", C, C, carry, Expected, Expected, status );
            assign status = C === Expected ? 1'b1 : 1'b0;
            $fwrite(fout_ptr,"Result=%b, %d / carry=%b || Expected Result=%b, %d || Status= %d \n", C, C, carry, Expected, Expected, status);
        end        
        $finish();
    end

endmodule
