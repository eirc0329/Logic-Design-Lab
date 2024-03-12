`timescale 1ns/1ps

module Toggle_Flip_Flop(clk, q, t, rst_n);
input clk;
input t;
input rst_n;
output q;

wire T1,T2;

XOR X1(q,t,T1);
and A1(T2,T1,rst_n);
D_Flip_Flop D1(clk, T2, q);

endmodule


module XOR(A, B, q);
input A,B;
output q;

wire T1,T2,T3;
nand N1(T1,A,B);
nand N2(T2,A,T1);
nand N3(T3,T1,B);
nand N4(q,T2,T3);

endmodule



module D_Flip_Flop(clk, d, q);
input clk;
input d;
output q;

wire nclk;
wire midq;

not Not_clk(nclk,clk);
D_Latch Master(nclk,d,midq);
D_Latch Slave(clk,midq,q);

endmodule

module D_Latch(e, d, q);
input e;
input d;
output q;

wire nd;
wire w1,w2,nq;

not Notd(nd,d);
nand Nand1(w1,d,e), Nand2(w2,nd,e);
nand Notq(nq,w2,q);
nand Nand3(q,w1,nq);

endmodule