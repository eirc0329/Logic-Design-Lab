`timescale 1ns / 1ps


module FIFO_8_t;
reg clk =1'b1;
reg rst_n=1'b1;
reg wen=1'b0;
reg ren=1'b0;
reg [7:0] din = 8'b00000000;
wire [7:0] dout;
wire error;

parameter cyc =10;

always #(cyc/2) clk=!clk;

FIFO_8 fifo(clk, rst_n, wen, ren, din, dout, error);

initial
    begin
    
    @(negedge clk)
    rst_n =1'b0;
    @(negedge clk)
    rst_n =1'b1;
    repeat(2)
        begin
        @(negedge clk)
        wen=1'b1;
        din=din+1'b1;
        end
    repeat(3)
        begin
        @(negedge clk)
        ren=1'b1;
        end
    ren=1'b0;
    repeat(9)
        begin
        @(negedge clk)
        wen=1'b1;
        din=din+1'b1;
        end
    
    #(cyc*2) $finish;    
    end

endmodule
