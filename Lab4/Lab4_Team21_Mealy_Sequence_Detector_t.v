`timescale 1ns/1ps

module Mealy_Sequence_Detector_t;
reg clk   = 1'b1;
reg rst_n = 1'b0;
reg in    = 1'b0;
wire dec;
parameter cyc  =4'd10;
always #(cyc/2) clk = ~clk;

Mealy_Sequence_Detector  mealy(clk, rst_n, in, dec);

initial begin
//one cycle
@(negedge clk) 
    in =1'b0;
    rst_n =1'b1;
@(negedge clk) in =1'b1;
@(negedge clk) in =1'b1;
@(negedge clk) in =1'b1;
//one cycle
@(negedge clk) in =1'b0;
@(negedge clk) in =1'b1;
@(negedge clk) in =1'b1;
@(negedge clk) in =1'b0;
//one cycle
@(negedge clk) in =1'b1;
@(negedge clk) in =1'b0;
@(negedge clk) in =1'b0;
@(negedge clk) in =1'b1;
//one cycle
@(negedge clk) in =1'b0;
@(negedge clk) in =1'b1;
@(negedge clk) in =1'b0;
@(negedge clk) in =1'b0;
#(3*cyc)
$finish;
end
endmodule
