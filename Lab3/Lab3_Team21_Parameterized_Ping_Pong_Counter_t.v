`timescale 1ns / 1ps
module Parameterized_Ping_Pong_Counter_t;

reg clk=1'b0;
reg rst_n;
reg enable;
reg flip;
reg [3:0] max;
reg [3:0] min;
wire direction;
wire [3:0] out;
   
parameter cyc=10;
always #(cyc/2) clk = !clk;
Parameterized_Ping_Pong_Counter P1(clk, rst_n, enable, flip, max, min, direction, out);

initial begin

 rst_n = 1'b0;
 enable = 1'b1;
 min = 4'd0;
 max = 4'd4;
 flip=1'b0;
 @(negedge clk) rst_n = 1'b1;
 #(cyc*3) 
 repeat(2) begin
@(negedge clk) flip=1'b1;
@(negedge clk) flip = 1'b0;
 end
 #(cyc*4) 
 max=1;
 #(cyc*4) 
 max=5;
 min=7;
 #(cyc*4) 

 @(negedge clk) $finish;
end
endmodule
