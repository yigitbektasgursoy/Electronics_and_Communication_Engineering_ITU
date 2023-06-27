`timescale 1ns / 1ps

module experiment5();
endmodule

module SR_LATCH(
       input S,
       input R,
       
       output Q,
       output Qn
        );
        
NAND_gate nand1(
          .I1(S),
          .I2(Qn),
          .O(Q)
          );
NAND_gate nand2(
          .I1(R),
          .I2(Q),
          .O(Qn)
          );
        
endmodule

module D_FLIP_FLOP(
       input D,
       input CLK,
       
       output Q,
       output Qn
        );
        
wire [1:0]signal;
        
NAND_gate nand1(
          .I1(D),
          .I2(CLK),
          
          .O(signal[0])
          );
         
NAND_gate nand2(
          .I1(~D),
          .I2(CLK),
          
          .O(signal[1])
          );

NAND_gate nand3(
          .I1(signal[0]),
          .I2(Qn),
          
          .O(Q)
          );
NAND_gate nand4(
          .I1(signal[1]),
          .I2(Q),
          
          .O(Qn)
          );
                    
endmodule

module MASTER_SLAVE_DFF(
       input D,
       input CLK,
       
       output Qs,
       output Qs_NOT
       );
       
wire Qm,Qm_not;  
     
       D_FLIP_FLOP master(
                   .D(D),
                   .CLK(CLK),
                   
                   .Q(Qm),
                   .Qn(Qm_not)
                   );
                        
       D_FLIP_FLOP slave(
                   .D(Qm),
                   .CLK(~CLK),
                   
                   .Q(Qs),
                   .Qn(Qs_NOT)
                   );
                        
endmodule

module BEHAVIORAL_DFF(
       input D,
       input CLK,
       
       output Q,
       output Qn
       );
       
    reg FF;
    always @ (posedge CLK)
    begin
        FF <= D;
    end
    
    assign Q = FF;
    assign Qn = ~FF;
        
endmodule

module REGISTER(
       input [7:0]IN,
       input CLK,
       input CLEAR,
       
       output reg [7:0]OUT
        );
        
    always @ (posedge CLK or posedge CLEAR)
    begin
        if (CLEAR)
            OUT <= 8'h00;
        else
            OUT <= IN;    
    end
endmodule

module REGISTER2 (
       input [31:0]IN,
       input CLK,
       input CLEAR,
       
       output [31:0]OUT
       );
       
       REGISTER R1(
                .IN(IN[7:0]),
                .CLK(CLK),
                .CLEAR(CLEAR),
                
                .OUT(OUT[7:0])
                );
       REGISTER R2(
                .IN(IN[15:8]),
                .CLK(CLK),
                .CLEAR(CLEAR),
                
                .OUT(OUT[15:8])
                );
       REGISTER R3(
                .IN(IN[23:16]),
                .CLK(CLK),
                .CLEAR(CLEAR),
                
                .OUT(OUT[23:16])
                );                
       REGISTER R4(
                .IN(IN[31:24]),
                .CLK(CLK),
                .CLEAR(CLEAR),
                
                .OUT(OUT[31:24])
                );       
       
endmodule
       
module RAM(
       input clka,
       input wea,
       input [3:0] addra,
       
       output [7:0]douta
       );
       wire [7:0]dina;
       BLOCK_RAM RAM(
                 .dina(dina),
                 .clka(clka),
                 .wea(wea),
                 .addra(addra),
                 
                 .douta(douta)
                 );

endmodule       
