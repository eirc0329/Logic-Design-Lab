`timescale 1ns/1ps

module Dmux_1x4_4bit(in, a, b, c, d, sel);
input [3:0] in;
input [1:0] sel;
output [3:0] a, b, c, d;

Dmux_1x4_1bit DMux0(in[0],a[0],b[0],c[0],d[0],sel);
Dmux_1x4_1bit DMux1(in[1],a[1],b[1],c[1],d[1],sel);
Dmux_1x4_1bit DMux2(in[2],a[2],b[2],c[2],d[2],sel);
Dmux_1x4_1bit DMux3(in[3],a[3],b[3],c[3],d[3],sel);

endmodule

module Dmux_1x4_1bit(in, a, b, c, d, sel);
input in;
input [1:0] sel;
output a,b,c,d;

wire nsel0, nsel1;

not NSel0(nsel0,sel[0]), NSel1(nsel1,sel[1]);
and And1(a,in,nsel0,nsel1), And2(b,in,nsel1,sel[0]), And3(c,in,sel[1],nsel0), And(d,in,sel[0],sel[1]);

endmodule
