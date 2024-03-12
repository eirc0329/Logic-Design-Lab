`timescale 1ns/1ps

module Scan_Chain_Design_t;
reg clk=1'b1;
reg rst_n=1'b0;
reg scan_in;
reg scan_en=1'b0;
wire scan_out;
parameter cyc=4'd10;

Scan_Chain_Design scd(clk, rst_n, scan_in, scan_en, scan_out);

always #(cyc/2) clk=~clk;

//caption here: a[3:0]=1011;  b[3:0]=1010;
//b0~b3 and a0~a3 = 01011101
//The p0~p7 should be 0111011 (p=8'd110)
initial begin
#(cyc*3/2)
rst_n   = 1'b1;
scan_en = 1'b1;

     scan_in = 1'b0;//b0
#cyc scan_in = 1'b1;//b1
#cyc scan_in = 1'b0;//b2
#cyc scan_in = 1'b1;//b3
#cyc scan_in = 1'b1;//a0
#cyc scan_in = 1'b1;//a1
#cyc scan_in = 1'b0;//a2
#cyc scan_in = 1'b1;//a3
#cyc 
#(cyc/4) scan_en = 1'b0;//capture
#cyc     scan_en = 1'b1;
#(cyc*15)
//do again

$finish;
end

endmodule
