module CLA #(parameter SIZE=32)
(
     input [SIZE-1:0] x,
     input [SIZE-1:0] y,
     input ci,
     input sub,
    
     output cout,
     output NF,
     output reg CF,
     output reg OF,
     output [SIZE-1:0] s
);

     wire [SIZE-1:0] P;
     wire [SIZE-1:0] G;
     wire [SIZE:0] C;
     wire [SIZE-1:0] y_inverted;
     wire [SIZE-1:0] y_inverted2;
     wire [SIZE-1:0] y_final;
     wire carry_in;

     // Invert y when subtracting
     assign y_inverted = ~y;
     assign carry_in = sub ? 1'b1 : 1'b0;
     assign y_inverted2 = y_inverted + carry_in;

     // Select inverted or original y based on 'sub' signal
     genvar j;
     generate
         for (j = 0; j < SIZE; j = j + 1) begin
             assign y_final[j] = sub ? y_inverted2[j] : y[j];
         end
     endgenerate

     assign P = x ^ y_final;
     assign G = x & y_final;

     CLG #(.SIZE(32)) CLG
     (
         .P(P),
         .G(G),
         .ci(ci),
         .cout(C)
     );

     assign C[0] = ci;

     genvar i;
     generate
         for(i = 0; i < SIZE; i = i + 1) begin
             assign s[i] = C[i] ^ P[i];
         end
     endgenerate

     assign cout = C[SIZE];
     assign NF = s[SIZE-1]; // negative flag
     
     always @(*) begin
         if (sub) begin
             OF = (x[SIZE-1] == y_final[SIZE-1]) && (x[SIZE-1] != s[SIZE-1]);
             CF = 1'b0;
         end else begin
             OF = 1'b0;
             CF = cout; // Carry flag is equal to the carry out during addition
         end
     end
endmodule

