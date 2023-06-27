module ShiftRegister #(parameter k = 16)
(
    input wire clk, 
    input wire reset,
    input wire load,
    input wire shift,
    input wire [k-1:0] shift_in,
    output reg [k-1:0] shift_out
);

    always @(posedge clk, posedge reset)
    begin
        if(reset) 
            begin
                shift_out <= 0;
            end
        else if(load)
            begin
                shift_out <= shift_in;
            end
        else if(shift)
            begin
                shift_out <= {shift_out[k-2:0], shift_out[k-1]};
            end
    end
endmodule

