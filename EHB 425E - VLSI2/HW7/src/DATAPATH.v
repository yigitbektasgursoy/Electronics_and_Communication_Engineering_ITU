`timescale 1ns / 1ps

module DATAPATH#(parameter SIZE = 32)(
    input clk,
    input reset,
    input we,
	input MuxB_sel,
	input MuxD_sel,
	input MuxR_sel,
	input [3:0] Sel, 
    input [$clog2(SIZE)-1 : 0] AA, 
	input [$clog2(SIZE)-1 : 0] BA,
	input [$clog2(SIZE)-1 : 0] DA,
	input [SIZE-1 : 0] PC_in,
	input [SIZE-1 : 0] Data_in,
	input [SIZE-1 : 0] Constant_in,
	output [SIZE-1 : 0] Addr_out,
	output [SIZE-1 : 0] Data_out,
	output C,
    output V,
    output N,
    output Z);
   

	wire [SIZE-1:0] A_data;
	wire [SIZE-1:0] B_data;
	reg [SIZE-1:0] MB_out;
	wire [SIZE-1:0] FU_out;
	reg [SIZE-1:0] Data_bus;
	reg [SIZE-1:0] Reg_in;
	
	assign Addr_out = FU_out;
	assign Data_out = B_data;
   
    register_file #(.WIDTH(SIZE), .DEPTH(SIZE)) register_file(
		.clk(clk),
		.reset(reset),
		.we0(we),
		.Rin(Reg_in),
		.rd_addr0(AA),
		.rd_addr1(BA),
		.wr_addr0(DA),
		.rd_dout0(A_data),
		.rd_dout1(B_data));
		
    FU #(.SIZE(SIZE)) FU(
		.A(A_data), 
		.B(MB_out), 
		.Sel(Sel), 
		.F(FU_out),
		.C(C),
		.V(V),
		.N(N),
		.Z(Z));

    //MUX B
	always @(*)
	begin
	   case (MuxB_sel)
	   1'b0:
	       begin
	           MB_out = B_data;
	       end
	   1'b1:
	       begin
	           MB_out = Constant_in;
	       end
	   endcase
    end
    
    //MUX D    
	always @(*)
	begin
	   case (MuxD_sel)
	   1'b0:
	       begin
	           Data_bus = Data_in;
	       end
	   1'b1:
	       begin
	           Data_bus = FU_out;
	       end
	   endcase
    end
    
	always @(*)
	begin
	   case (MuxR_sel)
	   1'b0:
	       begin
	           Reg_in = PC_in;
	       end
	   1'b1:
	       begin
	           Reg_in = Data_bus;
	       end
	   endcase
    end                   
	   

endmodule

