`timescale 1ns/1ps

module Multiplier_4bit(a, b, p);
input [3:0] a, b;
output [7:0] p;
wire w6;
wire [1:0] w1,w5;
wire [2:0] w2;
wire [3:0] w3,w4;
wire p2_cin,p3_cin_1,p3_cin_2,p4_cin_1,p4_cin_2,p4_cin_3,p5_cin_1,p5_cin_2,p5_cin_3,p6_cin_1,p6_cin_2;
wire sum_p2_1,sum_p3_1,sum_p3_2,sum_p4_1,sum_p4_2,sum_p5_1;

AND And_p0_1(p[0],a[0],b[0]); //generate p0

AND And_p1_1(w1[0],a[1],b[0]); //generate p1
AND And_p1_2(w1[1],a[0],b[1]);
Full_Adder FA_p1_1(w1[0],w1[1],1'b0,p2_cin,p[1]);

AND And_p2_1(w2[0],a[2],b[0]); //generate p2
AND And_p2_2(w2[1],a[1],b[1]);
AND And_p2_3(w2[2],a[0],b[2]);
Full_Adder FA_p2_1(w2[0],w2[1],p2_cin,p3_cin_1,sum_p2_1);
Full_Adder FA_p2_2(sum_p2_1,w2[2],1'b0,p3_cin_2,p[2]);

AND And_p3_1(w3[0],a[3],b[0]); //generate p3
AND And_p3_2(w3[1],a[2],b[1]);
AND And_p3_3(w3[2],a[1],b[2]);
AND And_p3_4(w3[3],a[0],b[3]);
Full_Adder FA_p3_1(w3[0],w3[1],p3_cin_1,p4_cin_1,sum_p3_1);
Full_Adder FA_p3_2(sum_p3_1,w3[2],p3_cin_2,p4_cin_2,sum_p3_2);
Full_Adder FA_p3_3(sum_p3_2,w3[3],1'b0,p4_cin_3,p[3]);

AND And_p4_1(w4[0],a[3],b[1]);  //generate p4
AND And_p4_2(w4[1],a[2],b[2]);
AND And_p4_3(w4[2],a[1],b[3]);
Full_Adder FA_p4_1(1'b0,w4[0],p4_cin_1,p5_cin_1,sum_p4_1);
Full_Adder FA_p4_2(sum_p4_1,w4[1],p4_cin_2,p5_cin_2,sum_p4_2);
Full_Adder FA_p4_3(sum_p4_2,w4[2],p4_cin_3,p5_cin_3,p[4]);

AND And_p5_1(w5[0],a[3],b[2]); //generate p5
AND And_p5_2(w5[1],a[2],b[3]);
Full_Adder FA_p5_1(p5_cin_1,w5[0],p5_cin_2,p6_cin_1,sum_p5_1);
Full_Adder FA_p5_2(sum_p5_1,w5[1],p5_cin_3,p6_cin_2,p[5]);

AND And_p6_1(w6,a[3],b[3]);
Full_Adder FA_p6_1(p6_cin_1,w6,p6_cin_2,p[7],p[6]);

endmodule



module universal_gate(out,in1,in2);
input in1,in2;
output out;
wire w;
not NOT(w,in2);
and AND(out,in1,w);
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





