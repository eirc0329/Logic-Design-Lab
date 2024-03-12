`timescale 1ns / 1ps


module Carry_Look_Ahead_Adder_8bit_t;
reg [7:0] a=8'b00000000;
reg [7:0] b=8'b00000000;
reg c0=1'b0;
wire [7:0]s;
wire c8;

Carry_Look_Ahead_Adder_8bit CLAA(a,b,c0,s,c8);

initial begin
    repeat(2**17) begin
        #1 {a,b,c0}={a,b,c0}+1'b1;
    end
    #1 $finish;
end
endmodule
