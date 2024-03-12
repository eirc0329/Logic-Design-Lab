`timescale 1ns / 1ps

module dino (
    input clk,
    input rst,
    input jump_op,
    output reg[9:0]dino_x,
    output reg[9:0]dino_y
    ); 
    parameter minh = 10'd260;
    parameter ground = 10'd370;
    parameter g      = 10'd1;//accelaration
    parameter v_init = 10'd2;
    reg [9:0]next_dino_x,next_dino_y;
    reg [21:0] count;
    reg move;
    reg jump,next_jump;    // whether it's jumping now including falldown
    reg updown,next_updown;

always @(posedge clk) begin
  if(count[21] == 1'b1)begin//update rate of jumping
        move = 1'b1;
        count <= 21'd0;
  end else begin
        move = 1'b0;
        count <= count +1'b1;
  end
end
  
always @(posedge clk)begin
    if(rst)begin
        updown <=  1'b0;
        jump   <=  1'b0;
        dino_x <=  10'd30;
        dino_y <=  ground;
    end else begin
        updown <= next_updown;
        jump   <= next_jump  ;
        dino_x <= next_dino_x;
        dino_y <= next_dino_y;
    end    
end

//dino_x , dino_y calculation
always @(*)begin
    next_dino_x = dino_x;
    if(move == 1'b1 && jump == 1'b1)
        if(updown ==1'b0)
            next_dino_y = dino_y - 10'd5;
        else
            next_dino_y = dino_y + 10'd4;
    else
        next_dino_y = dino_y;
end

//jump calculation

always @(*)begin
    if(jump_op == 1'b1 && dino_y>=ground)begin
        next_jump = 1'b1;
        next_updown = 1'b0;
    end else begin
        if(dino_y <= minh)begin//reach the hightest point
            next_jump  = 1'b1;
            next_updown = 1'b1;        
        end else begin
            if(dino_y >= ground && updown ==1'b1)begin// falling on the ground 
                next_jump  = 1'b0;
                next_updown = 1'b0;
            end else begin//else remain 
                next_jump  = jump;
                next_updown = updown;           
            end
        end
    end
end

endmodule
