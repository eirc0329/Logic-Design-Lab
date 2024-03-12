`timescale 1ns / 1ps



module Multiplier_4bit_t;
reg [3:0] a=4'b0000;
reg [3:0] b=4'b0000;
wire [7:0] p;

Multiplier_4bit M1(a,b,p);

initial begin
    repeat(2**8) begin
        #1 {a,b}={a,b}+1'b1;
    end
    #1 $finish;
end
endmodule
