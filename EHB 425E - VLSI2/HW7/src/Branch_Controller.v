module Branch_Controller(
    input [2:0] Branch_sel, 
    input Z,
    input N,
    output reg MPC,
    output reg JALR
);

    always @(*)
    begin
        JALR = Branch_sel[2] & Branch_sel[1] & Branch_sel[0];

        case (Branch_sel)
            3'b000: MPC = 1'b0;
            3'b001: MPC = Z;
            3'b010: MPC = ~Z;
            3'b011: MPC = N;
            3'b100: MPC = ~N;
            3'b101: MPC = 1'b1;
            3'b110: MPC = 1'b1;
            default: MPC = 1'b0;
        endcase
    end

endmodule
