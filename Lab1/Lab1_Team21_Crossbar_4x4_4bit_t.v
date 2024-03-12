`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/29 16:07:49
// Design Name: 
// Module Name: Lab1_TeamX_Crossbar_4x4_4bit_t
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


module Lab1_TeamX_Crossbar_4x4_4bit_t;
reg [3:0] in1=4'b0000;
reg [3:0] in2=4'b0000;
reg [3:0] in3=4'b0000;
reg [3:0] in4=4'b0000;
reg [4:0] control=5'b00000;
wire [3:0] out1, out2, out3, out4;

Crossbar_4x4_4bit CB1(in1, in2, in3, in4, out1, out2, out3, out4,control);

initial begin
    repeat(2**5) begin
        #1 control=control+5'b1;
        repeat(2**4) begin
            #1 in1=in1+4'b1;
            repeat(2**4) begin
                #1 in2=in2+4'b1;
                repeat(2**4) begin
                    #1 in3=in3+4'b1;
                    repeat(2**4) begin
                        #1 in4=in4+4'b1;
                    end
                end
            end
        end
    end
end
                    

    
endmodule
