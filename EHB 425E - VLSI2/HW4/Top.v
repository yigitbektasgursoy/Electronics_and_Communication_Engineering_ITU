module Top #(parameter k = 16)
(
    input wire [k-1:0] A, B,
    input wire clk,
    input wire reset,
    input wire Start,
    output wire Done,
    output wire [k-1:0] C 
);

    wire [7:0] ControlSignals;
    wire [1:0] StatusSignals;

    Controller Controller(.START(Start), 
                          .S_S(StatusSignals),
                          .CLK(clk), 
                          .RST(reset), 
                          .C_S(ControlSignals), 
                          .Done(Done));
                          
     Datapath #(.k(k)) Datapath(.A(A), 
                                .B(B), 
                                .ControlSignals(ControlSignals), 
                                .clk(clk), 
                                .reset(reset), 
                                .C(C), 
                                .StatusSignals(StatusSignals));

endmodule
