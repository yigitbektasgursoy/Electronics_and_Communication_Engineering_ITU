module Shifter #(parameter SIZE = 32)(
    input [SIZE-1:0] A,
    input [SIZE-1:0] B,
    input [4:0] shamt,
    input [1:0] shift_type,
    output reg [SIZE-1:0] SHIFT_OUT
);

    wire [SIZE-1:0] mux_out [5:0];
    
    always @(*) begin
        // SLL and SLLI
        if (shift_type == 2'b01)
        begin
            if (shamt)
                SHIFT_OUT = A << shamt;
            else
                SHIFT_OUT = A << B[4:0];                
        end
        // SRL and SRLI
        else if (shift_type == 2'b10)
        begin
            if (shamt)
                SHIFT_OUT = A >> shamt;
            else
                SHIFT_OUT = A >> B[4:0];
        end
         
        // SRA and SRAI
        else if (shift_type == 2'b11) 
        begin
            if (shamt)
               SHIFT_OUT = $signed(A) >>> shamt;
            else
               SHIFT_OUT = $signed(A) >>> B[4:0]; 
        end
        
        //default
        else begin
            SHIFT_OUT = A;
        end        
    end
endmodule    
