`timescale 1ns/1ps
module displayhexa(SW,out,an);
input [10:0] SW;
output [6:0] out;
output [3:0] an;

wire [3:0]rd;
Decode_And_Execute DAE(SW[6:3], SW[10:7], SW[2:0], rd);

//assign out 0~6=a~g
assign out[0]=(~rd[3]&~rd[2]&~rd[1]&rd[0])|(~rd[3]&rd[2]&~rd[1]&~rd[0])|(rd[3]&rd[2]&~rd[1]&rd[0])|(rd[3]&~rd[2]&rd[1]&rd[0]);
assign out[1]=(~rd[3]&rd[2]&~rd[1]&rd[0])|(rd[2]&rd[1]&~rd[0])|(rd[3]&rd[1]&rd[0])|(rd[3]&rd[2]&~rd[0]);
assign out[2]=(~rd[3]&~rd[2]&rd[1]&~rd[0])|(rd[3]&rd[2]&rd[1])|(rd[3]&rd[2]&~rd[0]);
assign out[3]=(~rd[3]&~rd[2]&~rd[1]&rd[0])|(~rd[3]&rd[2]&~rd[1]&~rd[0])|(rd[3]&~rd[2]&rd[1]&~rd[0])|(rd[2]&rd[1]&rd[0]);
assign out[4]=(~rd[3]&rd[0])|(~rd[2]&~rd[1]&rd[0])|(~rd[3]&rd[2]&~rd[1]);
assign out[5]=(rd[3]&rd[2]&~rd[1]&rd[0])|(~rd[3]&~rd[2]&rd[0])|(~rd[3]&~rd[2]&rd[1])|(~rd[3]&rd[1]&rd[0]);
assign out[6]=(~rd[3]&rd[2]&rd[1]&rd[0])|(rd[3]&rd[2]&~rd[1]&~rd[0])|(~rd[3]&~rd[2]&~rd[1]);

assign an[3]=1'b1;
assign an[2]=1'b1;
assign an[1]=1'b1;
assign an[0]=1'b0;

endmodule



module Decode_And_Execute(rs, rt, sel, rd);
input [3:0] rs, rt;
input [2:0] sel;
output [3:0] rd;

wire [1:0]nouse;
wire [3:0]w1,w2,w3,w4,w5,w6,w7,w8;

Ripple_Carry_Adder_Subtractor RCAS1(rs,rt,1'b0,nouse[0],w1);
Ripple_Carry_Adder_Subtractor RCAS2(rs,rt,1'b1,nouse[1],w2);
AND And[3:0](w3,rs,rt);
OR Or[3:0](w4,rs,rt);
CIR_left_shift CIR_LS(w5,rs);
ARI_right_shift ARI_RS(w6,rt);
compare_eq C_EQ(w7,rs,rt);
compare_gt C_GT(w8,rs,rt);

Mux_4bit MUX_4bit(w1,w2,w3,w4,w5,w6,w7,w8,sel,rd);
endmodule

module universal_gate(out,in1,in2);
input in1,in2;
output out;
wire w;
not NOT(w,in2);
and AND(out,in1,w);
endmodule

module Mux(a,b,c,d,e,f,g,h,sel,out);

input a,b,c,d,e,f,g,h;
input [2:0] sel;
output out;

wire [2:0] nsel;
wire [7:0] w;

NOT NSEL[2:0](nsel,sel);
AND_4input And0(w[0],a,nsel[2],nsel[1],nsel[0]), And1(w[1],b,nsel[2],nsel[1],sel[0]), And2(w[2],c,nsel[2],sel[1],nsel[0]), And3(w[3],d,nsel[2],sel[1],sel[0]);
AND_4input And4(w[4],e,sel[2],nsel[1],nsel[0]), And5(w[5],f,sel[2],nsel[1],sel[0]), And6(w[6],g,sel[2],sel[1],nsel[0]), And7(w[7],h,sel[2],sel[1],sel[0]);
OR_8input orf(out,w[0],w[1],w[2],w[3],w[4],w[5],w[6],w[7]);

endmodule

module Mux_4bit(a,b,c,d,e,f,g,h,sel,out);
input [3:0]a,b,c,d,e,f,g,h;
input [2:0]sel;
output [3:0]out;

Mux MUX1(a[0],b[0],c[0],d[0],e[0],f[0],g[0],h[0],sel,out[0]);
Mux MUX2(a[1],b[1],c[1],d[1],e[1],f[1],g[1],h[1],sel,out[1]);
Mux MUX3(a[2],b[2],c[2],d[2],e[2],f[2],g[2],h[2],sel,out[2]);
Mux MUX4(a[3],b[3],c[3],d[3],e[3],f[3],g[3],h[3],sel,out[3]);
endmodule

module NOT(out,in);
input in;
output out;
universal_gate G1(out,1'b1,in);
endmodule

module AND(out,in1,in2);
input in1,in2;
output out;
wire w;
NOT Not1(w,in2);
universal_gate G1(out,in1,w);
endmodule

module OR(out, in1,in2);
input in1,in2;
output out;
wire [1:0]w;

NOT N1(w[0],in1);
universal_gate G1(w[1],w[0],in2);
NOT N2(out,w[1]);
endmodule

module AND_4input(out,in1,in2,in3,in4);
input in1,in2,in3,in4;
output out;
wire w1,w2;

AND and1(w1,in1,in2);
AND and2(w2,w1,in3);
AND and3(out,w2,in4);
endmodule

module OR_8input(out,in1,in2,in3,in4,in5,in6,in7,in8);
input in1,in2,in3,in4,in5,in6,in7,in8;
output out;
wire w1,w2,w3,w4,w5,w6;

OR or1(w1,in1,in2);
OR or2(w2,w1,in3);
OR or3(w3,w2,in4);
OR or4(w4,w3,in5);
OR or5(w5,w4,in6);
OR or6(w6,w5,in7);
OR or7(out,w6,in8);
endmodule

module XOR(out,in1,in2);
input in1,in2;
output out;

wire w1,w2;
universal_gate G1(w1,in1,in2);
universal_gate G2(w2,in2,in1);
OR or1(out,w1,w2);
endmodule

module XNOR(out,in1,in2);
input in1,in2;
output out;
wire w;

XOR Xor(w,in1,in2);
NOT Not(out,w);
endmodule

module Full_Adder (a, b, cin, cout, sum);
input a, b, cin;
output cout, sum;

wire ncin;
wire ncout;
wire w;

NOT not1(ncin,cin);
Majority majority1(a,b,cin,cout);
Majority majority2(a,b,ncin,w);
NOT not2(ncout,cout);
Majority majority3(ncout,cin,w,sum);

endmodule

module Majority(a, b, c, out);
input a, b, c;
output out;

wire [3:0]w;

AND and1(w[0],a,b);
AND and2(w[1],a,c);
AND and3(w[2],b,c);
OR or1(w[3],w[0],w[1]);
OR or2(out,w[3],w[2]);

endmodule

module Ripple_Carry_Adder_Subtractor(a, b, cin, cout, sum);
input [3:0] a, b;
input cin;
output cout;
output [3:0] sum;
    
wire [2:0] w;
wire [3:0] midwire;

XOR Xor0(midwire[0],b[0],cin);
XOR Xor1(midwire[1],b[1],cin);
XOR Xor2(midwire[2],b[2],cin);
XOR Xor3(midwire[3],b[3],cin);
Full_Adder FA_1(a[0],midwire[0],cin,w[0],sum[0]);
Full_Adder FA_2(a[1],midwire[1],w[0],w[1],sum[1]);
Full_Adder FA_3(a[2],midwire[2],w[1],w[2],sum[2]);
Full_Adder FA_4(a[3],midwire[3],w[2],cout,sum[3]);
endmodule

module CIR_left_shift(out,in);
input [3:0]in;
output [3:0]out;

AND And1(out[0],in[3],1'b1);
AND And2(out[1],in[0],1'b1);
AND And3(out[2],in[1],1'b1);
AND And4(out[3],in[2],1'b1);
endmodule

module ARI_right_shift(out,in);
input [3:0]in;
output [3:0]out;

AND And1(out[0],in[1],1'b1);
AND And2(out[1],in[2],1'b1);
AND And3(out[2],in[3],1'b1);
AND And4(out[3],in[3],1'b1);
endmodule

module compare_eq(out,in1,in2);
input [3:0] in1,in2;
output [3:0] out;
wire [3:0] w;
wire w1,w2;

AND And1(out[1],1'b1,1'b1);
AND And2(out[2],1'b1,1'b1);
AND And3(out[3],1'b1,1'b1);
XNOR Xnor[3:0](w,in1,in2);
AND And_a(w1,w[0],w[1]);
AND And_b(w2,w1,w[2]);
AND And_c(out[0],w2,w[3]);

endmodule

module compare_gt(out,in1,in2);
input [3:0]in1,in2;
output [3:0]out;
wire [3:0]nin2;
wire [2:0]w2;
wire [9:0]w3;
wire [1:0]w4;

NOT Not1(nin2[0],in2[0]);
NOT Not2(nin2[1],in2[1]);
NOT Not3(nin2[2],in2[2]);
NOT Not4(nin2[3],in2[3]);
XNOR Xnor1(w2[0],in1[1],in2[1]);
XNOR Xnor2(w2[1],in1[2],in2[2]);
XNOR Xnor3(w2[2],in1[3],in2[3]);
AND And1(w3[0],in1[3],nin2[3]);
AND And2(w3[1],in1[2],nin2[2]);
AND And3(w3[2],w3[1],w2[2]);
AND And4(w3[3],in1[1],nin2[1]);
AND And5(w3[4],w3[3],w2[2]);
AND And6(w3[5],w3[4],w2[1]);
AND And7(w3[6],in1[0],nin2[0]);
AND And8(w3[7],w3[6],w2[2]);
AND And9(w3[8],w3[7],w2[1]);
AND And10(w3[9],w3[8],w2[0]);
OR Or1(w4[0],w3[0],w3[2]);
OR Or2(w4[1],w4[0],w3[5]);
OR Or3(out[0],w4[1],w3[9]);

AND And11(out[1],1'b1,1'b1);
AND And12(out[2],1'b1,1'b0);
AND And13(out[3],1'b1,1'b1);
endmodule






