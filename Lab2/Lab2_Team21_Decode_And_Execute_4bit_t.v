`timescale 1ns / 1ps

module Decode_And_Execute_4bit_t;
reg [3:0]rs=4'b0000;
reg [3:0]rt=4'b0000;
reg [2:0]sel=3'b000;
wire [3:0]rd;

Decode_And_Execute DAC(rs, rt, sel, rd);

initial begin
    repeat(2**11) begin
        #1 {rs,rt,sel}={rs,rt,sel}+1'b1;
    end
    #1 $finish;
end
endmodule
