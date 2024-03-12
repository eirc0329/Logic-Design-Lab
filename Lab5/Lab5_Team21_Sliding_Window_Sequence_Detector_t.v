`timescale 1ns/1ps
module Sliding_Window_Sequence_Detector_t;
reg clk, rst_n;
reg in;
wire dec;

parameter cyc = 4'd10;
always #(cyc/2) clk=~clk;

Sliding_Window_Sequence_Detector swsd(clk, rst_n, in, dec);
initial  begin
clk=1'b1;
rst_n=1'b0;
#cyc
@(negedge clk)  
in=1'b0;
rst_n=1'b1;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b1;
//dec should be 1
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b1;
//dec should be 1
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b1;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b0;
@(negedge clk)  in=1'b1;
#(cyc*3)$finish;
end

endmodule 