`timescale 1ns/1ps

module Crossbar_2x2_4bit(in1, in2, control, out1, out2,out1_cp,out2_cp);
input [3:0] in1, in2;
input control;
output [3:0] out1, out2,out1_cp,out2_cp;

wire control_n;
wire [3:0]T1,T2,T3,T4,T5,T6;

not N1(control_n,control);
Dmux_1x2_4bit D1(in1, control_n, T1, T2);
Dmux_1x2_4bit D2(in2, control, T3, T4);

Mux_2x1_4bit M1(T1, T3, control_n, out1);
Mux_2x1_4bit M2(T2, T4, control, out2);

not N2[3:0](T5,out1);
not N3[3:0](out1_cp,T5);
not N4[3:0](T6,out2);
not N5[3:0](out2_cp,T6);

endmodule


module Mux_2x1_4bit(in1, in2, sel, out);
input sel;
input [3:0] in1, in2;
output [3:0] out;

wire sel_n;
wire [3:0]T1,T2;

not N1(sel_n,sel);
and A1[3:0](T1,in1,sel_n);
and A2[3:0](T2,in2,sel);
or O1[3:0](out,T1,T2);

endmodule

module Dmux_1x2_4bit(in, sel, out1, out2);
input sel;
input [3:0] in;
output [3:0] out1, out2;

wire sel_n;

not N1(sel_n,sel);
and A1 [3:0](out1,in,sel_n);
and A2 [3:0](out2,in,sel);


endmodule