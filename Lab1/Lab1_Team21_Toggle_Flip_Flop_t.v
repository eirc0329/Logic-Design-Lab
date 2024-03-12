`timescale 1ns/1ps
module Toggle_Flip_Flop_t;

reg clk = 1'b0;
reg t = 1'b1;
reg rst_n =1'b0;
wire q;

always#(1) clk = ~clk;

Toggle_Flip_Flop T1(clk, q, t, rst_n);
initial begin
    #3 rst_n =1'b1;
    @(negedge clk) t = 1'b1;
    @(negedge clk) t = 1'b0;
    @(negedge clk) t = 1'b1;
    @(negedge clk) $finish;
end

endmodule