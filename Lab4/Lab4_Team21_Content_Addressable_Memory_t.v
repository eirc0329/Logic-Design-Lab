`timescale 1ns/1ps

module Content_Addressable_Memory_t;
reg clk=1'b0;
reg wen, ren;
reg [7:0] din;
reg [3:0] addr;
wire [3:0] dout;
wire hit;

Content_Addressable_Memory cam(clk, wen, ren, din, addr, dout, hit);

parameter cyc=10;
always #(cyc/2) clk=~clk;

initial begin
ren=1'b0;
wen=1'b1;
din=8'd50;
addr=4'd15;
#(cyc)
din=8'd2;
addr=4'd14;
#(cyc)
din=8'd2;
addr=4'd13;
#(cyc*3)
ren=1'b1;
din=8'd50;
#(cyc*2)
din=8'd2;
#(cyc*2)
din=8'd20;
#(cyc*2)
$finish;


end

endmodule
