module Controller(
    input wire START,
    input wire [1:0] S_S,
    input wire CLK,
    input wire RST,
    output reg [7:0] C_S,
    output wire Done
    );
    
    reg [2:0] state_reg;
    reg [2:0] state_next;
    
    localparam [2:0] Step1 = 3'b000,
                     Step2 = 3'b001,
                     Step3 = 3'b010,
                     Step4 = 3'b011,
                     Step5 = 3'b100;
                     
    always @(posedge CLK or posedge RST)
    begin
        if(RST)
            state_reg <= Step1;
        else
            state_reg <= state_next;
    end
    
    always @(*)
    begin
        case(state_reg)
            Step1:
            begin 
                if(START) 
                begin
                    C_S = 8'b1110_1000;
                    state_next = Step2;
                end
                else 
                begin
                    C_S = 8'b0000_1x00;
                    state_next = Step1;
                end
            end
            Step2:
            begin
                if(S_S[1] == 1'b0) 
                begin
                    C_S = 8'b0100_1101;
                    state_next = Step3;
                end
                else if(S_S[1] == 1'b1)
                begin
                    C_S = 8'b0100_01xx;
                    state_next = Step1;
                end
            end
            Step3:
            begin
                C_S = 8'b0000_0xxx;
                state_next = Step4;
            end
            Step4:
            begin
                if(S_S[0] == 1'b0) 
                begin
                    C_S = 8'b0001_0xxx;
                    state_next = Step2;
                end
                else if(S_S[0] == 1'b1)
                begin
                    C_S = 8'b0001_1x10;
                    state_next = Step5;
                end
            end
            Step5:
            begin
                if(S_S[1] == 1'b0)
                    begin
                        C_S = 8'b0000_0xxx;
                        state_next = Step2;
                    end
            end
        endcase
    end
    
    assign Done = (state_reg == Step2 & S_S[1] == 1) ? 1 : 0;
endmodule



