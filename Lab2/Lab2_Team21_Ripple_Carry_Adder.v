`timescale 1ns/1ps

module Ripple_Carry_Adder(a, b, cin, cout, sum);
input [7:0] a, b;
input cin;
output cout;
output [7:0] sum;
    
wire [6:0] w;

Full_Adder FA_1(a[0],b[0],cin,w[0],sum[0]);
Full_Adder FA_2(a[1],b[1],w[0],w[1],sum[1]);
Full_Adder FA_3(a[2],b[2],w[1],w[2],sum[2]);
Full_Adder FA_4(a[3],b[3],w[2],w[3],sum[3]);
Full_Adder FA_5(a[4],b[4],w[3],w[4],sum[4]);
Full_Adder FA_6(a[5],b[5],w[4],w[5],sum[5]);
Full_Adder FA_7(a[6],b[6],w[5],w[6],sum[6]);
Full_Adder FA_8(a[7],b[7],w[6],cout,sum[7]);
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


module AND(out,in1,in2);
input in1, in2;
output out;

wire w;

nand NAND1(w,in1,in2);
nand NAND2(out,w,w);

endmodule

module OR(out,in1, in2);
input in1,in2;
output out;

wire w1,w2;
nand NAND1(w1,in1,in1);
nand NAND2(w2,in2,in2);
nand NAND3(out,w1,w2);

endmodule

module NOT(out,in);
input in;
output out;

nand NAND1(out,in,in);

endmodule

module XOR(out,in1,in2);
input in1,in2;
output out;

wire [2:0] w;

nand NAND1(w[0],in1,in2);
nand NAND2(w[1],in1,w[0]);
nand NAND3(w[2],in2,w[0]);
nand NAND4(out,w[1],w[2]);
endmodule

module XNOR(out,in1,in2);
input in1,in2;
output out;

wire [3:0]w;

nand NAND1(w[0],in1,in2);
nand NAND2(w[1],in1,in1);
nand NAND3(w[2],in2,in2);
nand NAND4(w[3],w[1],w[2]);
nand NAND5(out,w[0],w[3]);
endmodule