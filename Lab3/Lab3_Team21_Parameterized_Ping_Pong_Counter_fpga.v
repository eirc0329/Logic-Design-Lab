`timescale 1ns/1ps
module Parameterized_Ping_Pong_Counter_fpga(clk,SW,rst_n,flip,out,an);
input clk;
input [15:7]SW;//switch
input rst_n;//button
input flip;//button
output [6:0]out;//cathode
output [3:0]an;//anode

wire direction;
wire [3:0]num;
wire flip_db,flip_op;
wire rst_n_db,rst_n_op;
wire refresh_clk;
wire counter_clock_signal;

//generate two clock
Clock_Divider #(4999) CD1(clk,refresh_clk);
Clock_Divider #(27499999) CD2(clk,counter_clock_signal);

//generate one-pulse of rst_n
debounce de1(rst_n_db, rst_n, counter_clock_signal);
onepulse one1(rst_n_db, counter_clock_signal, rst_n_op);

//generate one-pulse of  flip
debounce de2(flip_db, flip, counter_clock_signal);
onepulse one2(flip_db,counter_clock_signal, flip_op);

//output num &direction
Parameterized_Ping_Pong_Counter par(counter_clock_signal,~rst_n_op, SW[15], flip_op, SW[14:11], SW[10:7], direction, num);

//display
Seven_Segment_display SS(refresh_clk,num,direction,out,an);
endmodule

//7-segment display
module Seven_Segment_display(
input wire refresh_clk,
input wire [3:0] num,
input wire direction,
output wire [6:0]out,
output wire [3:0]an);

wire [1:0] digit_counter;
wire [3:0] now_digit;

//generate 7 segment
Digit_Counter count(refresh_clk,digit_counter);
Anode_Control anode(digit_counter,an);
Digit_Control dig(num,direction,digit_counter,now_digit);
Cathode_Control cathode(now_digit,out);

endmodule

//digit_control
module Digit_Control(num,direction,count,now_digit);
input [3:0] num;
input direction;
input [1:0] count;
output reg[3:0] now_digit=0;

reg [3:0] tens,digits,dir_sign;
always@(*)begin
    if(direction==1'b1)dir_sign=10;
    else               dir_sign=11;
end
always@(*)begin
    if(num > 4'd9)begin
        tens   = 4'd1;
        digits = num-4'd10;
    end
    else begin
        tens   = 4'd0;
        digits = num;
    end
end
always@(count)begin
    case(count)
    2'b00:now_digit=dir_sign;//rightmost digit
    2'b01:now_digit=dir_sign;
    2'b10:now_digit=digits;
    2'b11:now_digit=tens;//leftmost digit
    default:now_digit=dir_sign;//default if wrong then d3
    endcase
end
endmodule


//Cathode_control
module Cathode_Control(input [3:0]bcd,output reg [6:0] out=0);
always @(bcd)
    begin
        case (bcd) //case statement
            0 : out = 7'b0000001;
            1 : out = 7'b1001111;
            2 : out = 7'b0010010;
            3 : out = 7'b0000110;
            4 : out = 7'b1001100;
            5 : out = 7'b0100100;
            6 : out = 7'b0100000;
            7 : out = 7'b0001111;
            8 : out = 7'b0000000;
            9 : out = 7'b0000100;
            10: out = 7'b0011101;//up_sign
            11: out = 7'b1100011;//down_sign
            default : out = 7'b0000000; 
        endcase
    end
    
endmodule


//clock_divider
module Clock_Divider #(parameter div=4999)(input wire clk,output reg dclk=0);

integer counter=0;
always@(posedge clk)begin
    if(counter==div)
    counter<=0;
    else
    counter<=counter+1;
end
always@(posedge clk)begin
    if(counter==div)
        dclk<=~dclk;
    else
        dclk<=dclk;
end
endmodule


//Anode_Control
module Anode_Control(input [1:0]count,output reg [3:0]an=0);
always@(count)begin
    case(count)
    2'b00:an=4'b1110;
    2'b01:an=4'b1101;
    2'b10:an=4'b1011;
    2'b11:an=4'b0111;
    default:an=4'b1101;//default if wrong then 3
    endcase
end
endmodule


//digit counter
module Digit_Counter(input dclk,output reg[1:0] count=0);
always @(posedge dclk)count<=count+1;
endmodule


// One-pulse circuit
module onepulse (PB_debounced, CLK, PB_one_pulse);
 input PB_debounced;
 input CLK;
 output PB_one_pulse;
 reg PB_one_pulse;
 reg PB_debounced_delay;
 always @(posedge CLK) begin
 PB_one_pulse <= PB_debounced & (! PB_debounced_delay);
 PB_debounced_delay <= PB_debounced;
 end
endmodule


//debounce
module debounce (pb_debounced, pb, clk);
 output pb_debounced; // signal of a pushbutton after being debounced
 input pb; // signal from a pushbutton 
 input clk; 
 
 reg [1:0] DFF; // use shift_reg to filter pushbutton bounce 
 always @(posedge clk) 
 begin
 DFF[1] <= DFF[0];
 DFF[0] <= pb;
 end
 assign pb_debounced = ((DFF == 2'b11) ? 1'b1 : 1'b0);
endmodule


//module
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