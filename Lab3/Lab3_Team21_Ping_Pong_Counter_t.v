`timescale 1ns / 1ps


module Ping_Pong_Counter_t;
reg clk=1'b1;
reg rst_n=1'b1;
reg enable=1'b0;
wire direction;
wire [3:0] out;
   
parameter cyc=10;

always #(cyc/2) clk = !clk;

Ping_Pong_Counter PPC(clk, rst_n, enable, direction, out);

initial 
    begin
    @(negedge clk)
    rst_n=1'b0;
    @(negedge clk)
    rst_n=1'b1;
    @(negedge clk)
    # (cyc) enable=1'b1;
    #(cyc*60) $finish;
    end
endmodule
