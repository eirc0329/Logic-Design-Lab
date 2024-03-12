`timescale 1ns/1ps
module Built_In_Self_Test_t;
reg clk;
reg rst_n;
reg scan_en;
wire scan_in;
wire scan_out;
parameter cyc=4'd10;

Built_In_Self_Test bist(clk, rst_n, scan_en, scan_in, scan_out);

always #(cyc/2) clk=~clk;

initial begin
clk=1'b1;
rst_n   = 1'b0;
scan_en=1'b1;
@(negedge clk)
rst_n   = 1'b1;
#(cyc*8)
#(cyc/4) scan_en = 1'b0;//capture
#cyc     scan_en = 1'b1;
#(cyc*15)
//do again

$finish;
end


endmodule

