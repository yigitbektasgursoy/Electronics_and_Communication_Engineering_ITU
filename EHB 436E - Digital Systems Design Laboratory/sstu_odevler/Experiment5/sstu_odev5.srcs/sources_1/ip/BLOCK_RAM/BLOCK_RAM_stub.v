// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Nov 21 23:22:31 2022
// Host        : YIGIT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/yigit/Desktop/Okul/2022guz/Sayisal Sistem Tasarim
//               Uygulamalari/sstu_odevler/Experiment5/sstu_odev5/sstu_odev5.srcs/sources_1/ip/BLOCK_RAM/BLOCK_RAM_stub.v}
// Design      : BLOCK_RAM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a50ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module BLOCK_RAM(clka, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[3:0],dina[7:0],douta[7:0]" */;
  input clka;
  input [0:0]wea;
  input [3:0]addra;
  input [7:0]dina;
  output [7:0]douta;
endmodule
