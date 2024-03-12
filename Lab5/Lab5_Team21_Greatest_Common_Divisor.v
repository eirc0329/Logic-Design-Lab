`timescale 1ns/1ps

module Greatest_Common_Divisor (clk, rst_n, start, a, b, done, gcd);
input clk, rst_n;
input start;
input [15:0] a;
input [15:0] b;
output done;
output [15:0] gcd;

parameter WAIT = 2'b00;
parameter CAL = 2'b01;
parameter FINISH = 2'b10;

reg [1:0]state;
reg [1:0]next_state;
reg done;
reg [15:0] gcd;
reg [15:0] cal_a;
reg [15:0] cal_b;
reg [15:0] ans;
reg [1:0]  count;
always @(posedge clk)begin   
    if(!rst_n)
        state <= WAIT;
    else
        state <= next_state;
end

always @(posedge clk)begin//sub once for one cycle
    if(state == CAL)begin
        if(cal_a > cal_b)
            cal_a <= cal_a - cal_b; 
        else
            cal_b <= cal_b - cal_a;
    end
end

always @(posedge clk)begin//count for two cycle
    if(state == FINISH)begin
        count <= count + 2'b1;
    end
end

always @(*)begin   
    case(state)   
    WAIT:begin
         gcd  = 16'd0;
         done = 1'b0;
         count      = 2'b0;//for FINISH to ouput gcd 2 cycles
         cal_a = a;        //for CAL to do the substraction
         cal_b = b;
         if(start==1'b1)
             next_state = CAL;
         else
             next_state = WAIT;
         end
    CAL:begin
        gcd  = 16'd0;
        done = 1'b0;
        if(cal_a == 16'd0)begin
            ans = cal_b;
            next_state = FINISH;
        end
        else if(cal_b == 16'd0)begin
            ans = cal_a;
            next_state = FINISH;
        end
        else begin
        
        end
        end
    default:begin//FINISH
            gcd = ans;
            done = 1'b1;
            if(count == 2'd1)
                next_state = WAIT;
            else 
                next_state = FINISH;
            end
    endcase


end

endmodule
