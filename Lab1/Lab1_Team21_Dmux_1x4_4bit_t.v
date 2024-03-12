`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/29 13:13:47
// Design Name: 
// Module Name: Lab1_TeamX_Dmux_1x4_4bit_t
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Dmux_1x4_4bit_t;
reg [3:0] in = 4'b0000;
reg [1:0] sel = 2'b00;
wire [3:0] a,b,c,d;

Dmux_1x4_4bit DM1(in,a,b,c,d,sel);

initial begin
    repeat(2**2) begin
        #1 sel=sel+2'b1;
        repeat(2**4) begin
            #1 in=in+4'b1;
        end
    end
    #1 $finish;
end

endmodule
