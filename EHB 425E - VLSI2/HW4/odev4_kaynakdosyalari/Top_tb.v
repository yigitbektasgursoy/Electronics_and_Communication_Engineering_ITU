`timescale 1ns / 1ps

module Top_tb();

    parameter k = 16;
    reg clk;
    reg reset;
    reg [k-1:0] A;
    reg [k-1:0] B;
    wire [k-1:0] C;
    reg Start;
    wire Done;
    Top #(k) UUT(A, B, clk, reset,  Start, Done, C);

    integer file;
    integer out_file;
    integer expected_result;

    initial begin
        
        clk = 0;
        reset = 1;
        
        file = $fopen("C:/Users/yigit/Desktop/Okul/2023bahar/VLSI2/HW4/odev4/test_vectors.txt", "r");
        out_file = $fopen("C:/Users/yigit/Desktop/Okul/2023bahar/VLSI2/HW4/odev4/output.txt", "w");
        while(!$feof(file)) begin
            $fscanf(file, "%d\t%d\t%d\n", A, B, expected_result);
            Start = 0; #15;
            reset = 0;
            Start = 1;
            #545;
            if(Done) begin
                if(C == expected_result) begin
                    $fdisplay(out_file, "A: %d, B: %d, Result: %d, Expected Result: %d, Result is TRUE", A, B, C, expected_result);
                    #10;
                end
                else begin
                    $fdisplay(out_file, "A: %d, B: %d, Result: %d, Expected Result: %d, Result is FALSE", A, B, C, expected_result);
                    #10;
                end
            end
        end
        $fclose(file);
        $fclose(out_file);
        $finish;
    end

    always begin
        #5;
        clk = ~clk;
    end

endmodule
