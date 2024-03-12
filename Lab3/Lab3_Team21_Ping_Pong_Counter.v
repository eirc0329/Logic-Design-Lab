`timescale 1ns/1ps

module Ping_Pong_Counter (clk, rst_n, enable, direction, out);
input clk, rst_n;
input enable;
output direction;
output [3:0] out;
reg direction;
reg [3:0] out;

always @(posedge clk)
    begin
    if(rst_n==1'b0)
        begin
        out <=4'b0;
        direction <=1'b1;
        end
    else
        begin 
        if(enable==1'b1)
            begin
            if( (out < 4'b1111  && direction==1'b1) || (out == 4'b0000 && direction==1'b0) )
                begin
                out <= out + 1'b1;
                direction <= 1'b1;
                end
            else 
                begin
                out <= out - 1'b1;
                direction <= 1'b0;
                end
            
            end
        else 
        begin
        out <= out;
        direction <=direction;
        end
        end
    end
endmodule
