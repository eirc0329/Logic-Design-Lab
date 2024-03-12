`timescale 1ns / 1ps

module FSM (
    input clk,
    input rst,
    input jump_op,	
    input dead,
    output reg[1:0]state
    ); 
    reg [1:0]next_state;

always@(posedge clk)begin
    if(rst)
        state <= 2'b00;
    else
        state <= next_state;
end

always@(*)begin
    if(state == 2'b00 && jump_op == 1'b1)begin
        next_state = 2'b01;
    end else if(state == 2'b01&& dead ==1'd1)begin
        next_state = 2'b00;
    end else
        next_state = state;

end   


endmodule
