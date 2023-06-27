module Datapath
#(parameter k = 16)
(
    input wire [k-1:0] A, B,
    input wire [7:0] ControlSignals,
    input wire clk,
    input wire reset,
    output wire [k-1:0] C,
    output wire [1:0] StatusSignals
);

    wire LoadA, LoadB, LoadC, LoadCoun,  ShiftB,  S_Coun;
    wire [1:0] S_C;
    wire [k-1:0] CounterInput, C_Input, ResultSUB1, ResultSQUARE, ResultMUL;
    wire [k-1:0] RegA, RegB, RegC, Counter;
    
    assign {LoadA, LoadCoun, LoadB, ShiftB, LoadC, S_Coun, S_C} = ControlSignals;
    assign StatusSignals[0] = RegB[k-1]; 
    assign CounterInput = (S_Coun == 0) ? (k) : ResultSUB1;
    assign C_Input = (S_C == 2'b00) ? 1 : ((S_C == 2'b01) ? ResultSQUARE : ((S_C == 2'b10) ? ResultMUL : 2'bxx ));
    assign StatusSignals[1] = (Counter == 0) ? 1 : 0;
    assign ResultSUB1 = Counter - 1;
    assign C = RegC;  
    
    Register #(.k(k)) reg_A(.clk(clk), .reset(reset), .load(LoadA), .data_in(A), .data_out(RegA));
    Register #(.k(k)) reg_Counter(.clk(clk), .reset(reset), .load(LoadCoun), .data_in(CounterInput), .data_out(Counter));
    
    ShiftRegister #(.k(k)) reg_B(.clk(clk), .reset(reset), .load(LoadB), .shift(ShiftB),.shift_in(B), .shift_out(RegB));
    ShiftRegister #(.k(k)) reg_C(.clk(clk), .reset(reset), .load(LoadC), .shift(1'b0),.shift_in(C_Input), .shift_out(RegC));
    
    MUL MUL1(.X(RegC), .Y(RegC), .result(ResultSQUARE));
    MUL MUL2(.X(RegC), .Y(RegA), .result(ResultMUL));
    

endmodule








