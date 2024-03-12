`timescale 1ns/1ps

module FIFO_8(clk, rst_n, wen, ren, din, dout, error);
input clk;
input rst_n;
input wen, ren;
input [7:0] din;
output [7:0] dout;
output error;

parameter capacity = 8;
reg [7:0] Quene[7:0];
reg [2:0]front=3'b000;
reg [2:0]rear=3'b000;
reg [7:0] dout;
reg error=1'b0;
reg empty=1'b1;
reg full=1'b0;

reg [2:0]next_rear=1;
reg [2:0]next_front=1;
always@(*)
next_rear=rear+1;
always@(*)
next_front=front+1;

always @(posedge clk)
begin
    if(rst_n ==1'b0)
    begin
        Quene[0] <=8'b0000_0000;
        Quene[1] <=8'b0000_0000;
        Quene[2] <=8'b0000_0000;
        Quene[3] <=8'b0000_0000;
        Quene[4] <=8'b0000_0000;
        Quene[5] <=8'b0000_0000;
        Quene[6] <=8'b0000_0000;
        Quene[7] <=8'b0000_0000;
        dout <=8'b0;
        error <=1'b0;
        front <=3'b000;
        rear <=3'b000;
        empty<=1'b1;
        full<=1'b0;
    end
    else    
    begin
        if(ren == 1'b1)
        begin
            if(empty!=1'b1)
            begin
                full<=1'b0;
                front<=next_front;
                dout <= Quene[next_front];
                error <=1'b0; 
                if(next_front==rear)
                    empty<=1'b1;
                else
                    empty<=1'b0;
            end
            else
                error <= 1'b1;
        end
        else if (ren==1'b0 && wen==1'b1)
        begin         
            if(full!=1'b1)
                begin
                empty<=1'b0;
                rear<=next_rear;
                Quene[next_rear] <= din;
                error <=1'b0; 
                if(next_rear==front)
                    full<=1'b1;
                else
                    full<=1'b0;
                end
            else
                begin
                error <=1'b1; 
                end
        end
        else
            begin
            error <= 1'b0;
            dout <= 8'b00000000;
            end
            
      end
end 


endmodule
