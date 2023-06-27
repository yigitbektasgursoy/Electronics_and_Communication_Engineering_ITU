`timescale 1ns / 1ps

module ADD(
    input [7:0] a, b,
    output [7:0] r, 
    output cout
    );
    wire[6:0] c;

    fulladd a1(a[0],b[0],0,r[0],c[0]);
    fulladd a2(a[1],b[1],c[0],r[1],c[1]);
    fulladd a3(a[2],b[2],c[1],r[2],c[2]);
    fulladd a4(a[3],b[3],c[2],r[3],c[3]);
    fulladd a5(a[4],b[4],c[3],r[4],c[4]);
    fulladd a6(a[5],b[5],c[4],r[5],c[5]);
    fulladd a7(a[6],b[6],c[5],r[6],c[6]);
    fulladd a8(a[7],b[7],c[6],r[7],cout);
    
endmodule

module fulladd(a, b, cin, sum, cout);
input a;
input b;
input cin;
output sum;
output cout;

assign sum=(a^b^cin);
assign cout=((a&b)|(b&cin)|(a&cin));

endmodule
