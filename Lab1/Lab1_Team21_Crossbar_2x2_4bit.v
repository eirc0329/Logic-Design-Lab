`timescale 1ns/1ps

module Crossbar_2x2_4bit(in1, in2, control, out1, out2);
input [3:0] in1, in2;
input control;
output [3:0] out1, out2;

wire [3:0]w1,w2,w3,w4;
wire ncontrol;

not NControl(ncontrol,control);
Dmux_1x2_4bit Dmux1(in1,w1,w2,ncontrol);
Dmux_1x2_4bit Dmux2(in2,w3,w4,control);
mux_2x1_4bit Mux1(w1,w3,ncontrol,out1);
mux_2x1_4bit Mux2(w2,w4,control,out2);

endmodule

module Dmux_1x2_4bit(in, a, b, ctrl);
input [3:0]in;
input ctrl;
output [3:0] a,b;

Dmux_1x2_1bit DMux0(in[0],a[0],b[0],ctrl);
Dmux_1x2_1bit DMux1(in[1],a[1],b[1],ctrl);
Dmux_1x2_1bit DMux2(in[2],a[2],b[2],ctrl);
Dmux_1x2_1bit DMux3(in[3],a[3],b[3],ctrl);

endmodule

module Dmux_1x2_1bit(in, a, b, ctrl);
input in;
input  ctrl;
output a,b;

wire nctrl;

not NCtrl(nctrl,ctrl);
and And0(a,in,nctrl), And1(b,in, ctrl);

endmodule

module mux_2x1_4bit(a,b,ctrl,f);

input [3:0] a,b;
input ctrl;
output [3:0] f;

mux_2x1_1bit Mux0(a[0],b[0],ctrl,f[0]);
mux_2x1_1bit Mux1(a[1],b[1],ctrl,f[1]);
mux_2x1_1bit Mux2(a[2],b[2],ctrl,f[2]);
mux_2x1_1bit Mux3(a[3],b[3],ctrl,f[3]);

endmodule

module mux_2x1_1bit(a,b, ctrl,f);

input a, b;
input ctrl;
output f;

wire [1:0] w;
wire nctrl;

not NCtrl(nctrl, ctrl);
and And0(w[0],a,nctrl), And1(w[1],b,ctrl);
or OR(f,w[0],w[1]);

endmodule
