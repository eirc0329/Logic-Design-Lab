`timescale 1ns/1ps

module Carry_Look_Ahead_Adder_8bit(a, b, c0, s, c8);
input [7:0] a, b;
input c0;
output [7:0] s;
output c8;

wire p0,g0,p1,g1,p2,g2,p3,g3,p4,g4,p5,g5,p6,g6,p7,g7;
wire c1,c2,c3,c4,c5,c6,c7;
wire [3:0] p03,g03,p47,g47;

Full_Adder_v2 FA1(a[0],b[0],c0,p0,g0,s[0]);
Full_Adder_v2 FA2(a[1],b[1],c1,p1,g1,s[1]);
Full_Adder_v2 FA3(a[2],b[2],c2,p2,g2,s[2]);
Full_Adder_v2 FA4(a[3],b[3],c3,p3,g3,s[3]);
Full_Adder_v2 FA5(a[4],b[4],c4,p4,g4,s[4]);
Full_Adder_v2 FA6(a[5],b[5],c5,p5,g5,s[5]);
Full_Adder_v2 FA7(a[6],b[6],c6,p6,g6,s[6]);
Full_Adder_v2 FA8(a[7],b[7],c7,p7,g7,s[7]);

carry_look_ahead_gen_4bit CLAG1(c0,p0,g0,p1,g1,p2,g2,p3,g3,c1,c2,c3,p03,g03);
carry_look_ahead_gen_4bit CLAG2(c4,p4,g4,p5,g5,p6,g6,p7,g7,c5,c6,c7,p47,g47);

carry_look_ahead_gen_2bit CLAG3(c0,p03,g03,p47,g47,c4,c8);
endmodule

module universal_gate(out,in1,in2);
input in1,in2;
output out;
wire w;
not NOT(w,in2);
and AND(out,in1,w);
endmodule

module Full_Adder_v2 (a, b, cin, p, g, sum);
input a, b, cin;
output p, g, sum;

XOR Xor1(p,a,b);
XOR Xor2(sum,p,cin);
AND And1(g,a,b);
endmodule

module carry_look_ahead_gen_4bit(c0,p0,g0,p1,g1,p2,g2,p3,g3,c1,c2,c3,p03,g03);

input c0,p0,g0,p1,g1,p2,g2,p3,g3;
output c1,c2,c3;
output [3:0]p03,g03;

wire w1;
wire [3:0]w2;
wire [4:0] w3;

AND And_c1(w1,p0,c0);  //generate c1
OR Or_c1(c1,g0,w1);

AND And_c2_1(w2[0],p1,g0); //generate c2
AND And_c2_2(w2[1],p1,w1);
OR Or_c2_1(w2[3],g1,w2[0]);
OR Or_c2_2(c2,w2[3],w2[1]);

AND And_c3_1(w3[0],p2,g1); //generate c3
AND And_c3_2(w3[1],p2,w2[0]);
AND And_c3_3(w3[2],p2,w2[1]);
OR Or_c3_1(w3[3],g2,w3[0]);
OR Or_c3_2(w3[4],w3[3],w3[1]);
OR Or_c3_3(c3,w3[4],w3[2]);

AND And_g03_1(g03[0],g0,1'b1); //generate g03
AND And_g03_2(g03[1],g1,1'b1);
AND And_g03_3(g03[2],g2,1'b1);
AND And_g03_4(g03[3],g3,1'b1);

AND And_p03_1(p03[0],p0,1'b1); //generate p03
AND And_p03_2(p03[1],p1,1'b1);
AND And_p03_3(p03[2],p2,1'b1);
AND And_p03_4(p03[3],p3,1'b1);
endmodule

module carry_look_ahead_gen_2bit(c0,p03,g03,p47,g47,c4,c8);
input c0;
input [3:0] p03,g03,p47,g47;
output c4,c8;

wire w1,w2,w3,w4,w5,w6,w7,w8;
wire c1,c2,c3,c5,c6,c7;

AND And_c1(w1,p03[0],c0);  //generate c1
OR Or_c1(c1,g03[0],w1);

AND And_c2(w2,c1,p03[1]); //generate c2
OR Or_c2(c2,g03[1],w2);

AND And_c3(w3,c2,p03[2]); //generate c3
OR Or_c3_1(c3,g03[2],w3);

AND And_c4(w4,p03[3],c3);  //generate c4
OR Or_c4(c4,g03[3],w4);

AND And_c5(w5,c4,p47[0]); //generate c5
OR Or_c5(c5,g47[0],w5);

AND And_c6(w6,c5,p47[1]); //generate c6
OR Or_c6(c6,g47[1],w6);

AND And_c7(w7,c6,p47[2]); //generate c7
OR Or_c7(c7,g47[2],w7);

AND And_c8(w8,c7,p47[3]); //generate c8
OR Or_c8(c8,g47[3],w8);

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

module XOR(out,in1,in2);
input in1,in2;
output out;

wire w1,w2;
universal_gate G1(w1,in1,in2);
universal_gate G2(w2,in2,in1);
OR or1(out,w1,w2);
endmodule
