`timescale 1ns / 1ps

module bird (
    input clk,
    input rst,
    input [1:0]state,
    output reg[9:0]bird_x,
    output reg[9:0]bird_y
    ); 
    reg [9:0]next_bird_x,next_bird_y;
    reg [21:0] count;
    reg move;

always @(posedge clk) begin
  if(count[20] == 1'b1)begin
        move <= 1'b1;
        count <= 21'd0;
  end else begin
        move <= 1'b0;
        count <= count +1'b1;
  end
end
  
always @(posedge clk)begin
    if(rst || state == 2'b00)begin//if(state == 0)then stop until jump is pushed
        bird_x <=10'd800;
        bird_y <=10'd260;
    end else begin
        bird_x <= next_bird_x;
        bird_y <= next_bird_y;
    end    
end

always @(*)begin
    if(move)begin
        if(bird_x - 1'b1  > 10'd0 )begin
            next_bird_x = bird_x  - 2'd2;
        end else begin
            next_bird_x = 10'd896;//640~1000
        end      
    end else begin
        next_bird_x = bird_x ;
    end
    next_bird_y = bird_y;
end

           
endmodule



