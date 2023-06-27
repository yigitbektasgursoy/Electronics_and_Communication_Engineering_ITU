`timescale 1ns / 1ps
`default_nettype none

module detector(
    input wire x, 
    input wire clk,
    output reg z,
    output reg [2:0] q
    );

    initial begin
        q = 3'b000;
    end
    parameter   NOPATTERN = 3'b000,
                FIRST_ONE = 3'b001,
                FIRST_ZERO = 3'b010,
                SECOND_ONE = 3'b011,
                SECOND_ZERO = 3'b100,
                FINISH = 3'b111;
    reg o0;
    reg o1;

    always @ (posedge clk) begin
        case (q)
            NOPATTERN: begin 
                case (x)
                    0: begin q <= NOPATTERN; z <= 0; o0 <= 0; o1 <= 0; end
                    1: begin q <= FIRST_ONE; z <= 0; o0 <= 0; o1 <= 0; end
                endcase
            end
            FIRST_ONE: begin
                case (x)
                    0: begin q <= FIRST_ZERO; z <= 0; end
                    1: begin q <= FIRST_ONE; z <= 0; end
                endcase
            end
            FIRST_ZERO: begin
                case (x)
                    0: begin
                        case (o0)
                            0: begin q <= SECOND_ZERO; o0 <= 1; o1 <= 0; end
                            1: begin q <= FINISH; z <= 1; o0 <= 0; o1 <= 0; end
                        endcase
                    end
                    1: begin 
                        case (o1)
                            0: begin q <= SECOND_ONE; z <= 0; o1 <= 1; o0 <= 0; end
                            1: begin q <= FINISH; z <= 1; o0 <= 0; o1 <= 0; end
                        endcase
                    end
                endcase
            end
            SECOND_ONE: begin
                case (x)
                    0: q <= FIRST_ZERO;
                    1: q <= FIRST_ONE;
                endcase
            end
            SECOND_ZERO: begin
                case (x)
                    0: begin q <= NOPATTERN; z <= 0; o0 <= 0; o1 <= 0; end
                    1: q <= FIRST_ONE;
                endcase
            end
            FINISH: begin
                q <= FINISH; z <= 1; o0 <= 0; o1 <= 0;
            end
            default: begin
                q <= NOPATTERN; z <= 0; o0 <= 0; o1 <= 0; 
            end
        endcase
    end
endmodule