`timescale 1ns/1ps

module Built_In_Self_Test(clk, rst_n, scan_en, scan_in, scan_out);
input clk;
input rst_n;
input scan_en;
output scan_in;
output scan_out;

wire out,in;
Scan_Chain_Design SCD(clk, rst_n,scan_in, scan_en, scan_out);
Many_To_One_LFSR  Lfsr(clk, rst_n,scan_in);


endmodule

//LFSR 1-bit
module Many_To_One_LFSR(clk, rst_n, MSB);
input clk;
input rst_n;
output MSB;
reg [7:0] out;
wire next_in;
wire T1,T2;

assign MSB=out[7];
xor(T1,out[1],out[2]);
xor(T2,out[3],out[7]);
xor(next_in,T1,T2);

always @(posedge clk)begin
    if(!rst_n)begin
        out<=8'b10111101;
    end
    else begin
        out[7:1]<=out[6:0];
        out[0] <= next_in;
    end

end

endmodule





module Scan_Chain_Design(clk, rst_n, scan_in, scan_en, scan_out);
input clk;
input rst_n;
input scan_in;
input scan_en;
output scan_out;

wire [3:0]a,b;
wire [7:0]p;


SDFF S1(p[7],scan_in,a[3],scan_en,rst_n,clk);
SDFF S2(p[6],a[3],a[2],scan_en,rst_n,clk);
SDFF S3(p[5],a[2],a[1],scan_en,rst_n,clk);
SDFF S4(p[4],a[1],a[0],scan_en,rst_n,clk);
SDFF S5(p[3],a[0],b[3],scan_en,rst_n,clk);
SDFF S6(p[2],b[3],b[2],scan_en,rst_n,clk);
SDFF S7(p[1],b[2],b[1],scan_en,rst_n,clk);
SDFF S8(p[0],b[1],b[0],scan_en,rst_n,clk);
Multiplier m1(a,b,p);

assign  scan_out = b[0];
endmodule

//Scan DFF
//sequential circuit
module SDFF(data,scan_in,Q,scan_en,rst_n,clk);
input scan_en;
input scan_in;
input data;
input rst_n;
input clk;
output reg Q;

always@ (posedge clk)begin
    if(!rst_n)
        Q<=1'b0;
    else begin
        if(scan_en == 1'b1)
            Q<=scan_in;
        else 
            Q<=data;
    end
end
endmodule

//Multiplier 
//combinational circuit
module Multiplier(a,b,p);
input [3:0]a,b;
output [7:0]p;

wire [3:0]m0;
wire [4:0]m1;
wire [5:0]m2;
wire [6:0]m3;
wire [7:0]s1,s2,s3;

assign m0 = {4{a[0]}} & b[3:0];
assign m1 = {4{a[1]}} & b[3:0];
assign m2 = {4{a[2]}} & b[3:0];
assign m3 = {4{a[3]}} & b[3:0];

assign s1 = m0 + (m1<<1);
assign s2 = s1 + (m2<<2);
assign s3 = s2 + (m3<<3);
assign p  = s3; 
endmodule