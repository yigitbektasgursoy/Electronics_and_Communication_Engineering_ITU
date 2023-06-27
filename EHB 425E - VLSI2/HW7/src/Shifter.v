module Shifter #(parameter SIZE = 32)(
    input [SIZE-1:0] A,
    input [4:0] shamt,
    input [1:0] shift_type,
    output reg [SIZE-1:0] SHIFT_OUT
);
   
    always @(*) begin
        case (shift_type)
            // SLL and SLLI
            2'b01:    
                begin
                    SHIFT_OUT = A << shamt;
                end
            // SRL and SRLI
            2'b10:
                begin
                    SHIFT_OUT = A >> shamt;
                end
            2'b11:
                // SRA and SRAI
                begin
                    SHIFT_OUT = $signed(A) >>> shamt;
                end
        endcase           
    end
endmodule    
