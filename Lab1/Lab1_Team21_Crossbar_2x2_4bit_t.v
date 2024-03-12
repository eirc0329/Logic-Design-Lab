`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/29 15:25:34
// Design Name: 
// Module Name: Lab1_TeamX_Crossbar_2x2_4bit_t
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


module Lab1_TeamX_Crossbar_2x2_4bit_t;
reg [3:0] in1=4'b0000;
reg [3:0] in2=4'b0000;
reg control = 1'b0;
wire [3:0] out1,out2;

Crossbar_2x2_4bit Cb1(in1, in2, control, out1, out2);

initial begin
    repeat(2) begin
        #1 control=control+1'b1;
        repeat(2**4) begin
            #1 in1=in1+4'b1;
            repeat(2**4) begin
            #1 in2=in2+4'b1;
            end
        end
     end
#1 $finish;
end

 
endmodule
