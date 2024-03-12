`timescale 1ns / 1ps

module obtacle (
    input clk,
    input rst,
    input [1:0]state,
    input [15:0] score,
    output reg[9:0]obtacle_x,
    output reg[9:0]obtacle_y
    ); 
    reg [9:0]next_obtacle_x,next_obtacle_y;
    reg [21:0] count;
    reg move;
    reg [9:0]v;

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
        obtacle_x <=10'd900;
        obtacle_y <=10'd400;
    end else begin
        obtacle_x <= next_obtacle_x;
        obtacle_y <= next_obtacle_y;
    end    
end

always @(*)begin
    if(score >= 16'd10 &&score <16'd20)
        v = 10'd4;
    else if(score >= 16'd25)
        v = 10'd5;
    else
        v = 10'd3;

end
always @(*)begin
    if(move)begin
        if(obtacle_x - 1'b1  > 10'd0 )begin
            next_obtacle_x = obtacle_x  - v;
        end else begin
            next_obtacle_x = 10'd896;//640~1000
        end      
    end else begin
        next_obtacle_x = obtacle_x ;
    end
    next_obtacle_y = obtacle_y;
end
           
endmodule



