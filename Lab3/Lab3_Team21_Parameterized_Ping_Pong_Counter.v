`timescale 1ns/1ps

module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
input clk, rst_n;
input enable;
input flip;
input [3:0] max;
input [3:0] min;
output direction;
output [3:0] out;

reg [3:0]out;
reg direction;
reg next_dir;
reg [3:0]next_out;

always @(*)begin
    if((enable==1'b1)&&(max>min)&&(out>=min)&&(out<=max))begin
        if(flip==1'b1||((out==max)&&direction==1'b1)||((out==min)&&direction==1'b0))
           next_dir=~direction;
        else
            next_dir=direction;
            
        if(next_dir==1'b1)
            next_out=out+1'b1;
        else
            next_out=out-1'b1;
        
    end
    else begin
    next_out=out;
    next_dir=direction;
    end
end

always @(posedge clk)begin
    if(rst_n==1'b0)begin
        direction<=1'b1;
        out<=min;
    end
    else begin
        direction<=next_dir; 
        out<=next_out;
    end
end


endmodule