`timescale 1ns / 1ps
module game_1A2B(in,reset,start,enter,led,out1,out2,out3,out4,an,clk);

input clk;
input [3:0]in;
input reset,start,enter;
ouput [15:0]led;
ouput [6:0]out1,out2,out3,out4;
output [3:0]an;

reg [6:0]out4_buffer;

Cathode_Control CC(in ,out4_buffer);

parameter initial_state=1'b0;
parameter guessing=1'b1;


assign an=4'b0000;


reg guess_result;
reg next_state;
reg [15:0]led_buffer;

One_TO_Many_LFSR(clk, reset, led_buffer);

always @(posedge clk)
	state<=next_state;

always @(reset or state or start or guess_result)
	begin
	if(reset==1'b0)
	   begin
		next_state=initial_state;
		out1=7'b0000000;
		out2=7'b0000000;
		out3=7'b0000000;
		out4=7'b0000000;
		led=16'b1111111111111111;
		end
	else
		begin
		if(state==initial_state)
			begin
			if(start==1'b0)
				begin
				next_state=guessing;
				
				led=led_buffer;
				end
			else
			    begin
				next_state=initial_state;
				led=16'b1111_1111_1111_1111;
				end
			out1[2:1]=2'b00;
			out1[0]=1'b1;
			out1[6:3]=4'b1111;
			
			out2[3]=1'b1;
			out2[2:0]=3'b000;
			out2[6:4]=3'b000;

			out3[2]=1'b1;
			out3[5]=1'b1;
			out3[1:0]=2'b00;
			out3[4:3]=2'b00;
			out3[6]=1'b0;

			out4[1:0]=2'b11;
			out4[6:2]=5'b00000;

			end
		else
			begin
			if(guess_result==1'b1)
				next_state=initial_state;
			else
			    begin
				next_state=guessing;
                end
            out1=7'b0000000;
            out2=7'b0000000;
            out3=7'b0000000;
			out4=out4_buffer;
			led=16'b1111_1111_1111_1111;
	        end
        end
	end
	
endmodule
module One_TO_Many_LFSR(clk, rst_n, out);
input clk;
input rst_n;
output reg [15:0] out;

wire T1,T2,T3;
xor(T1,out[1],out[15]);
xor(T2,out[2],out[15]);
xor(T3,out[3],out[15]);
always@(posedge clk)begin
    if(!rst_n)begin
    out<=16'b1011_1111_1111_1101;
    end
    else begin
    out[0]<=out[15];
    out[1]<=out[0];
    out[2]<=T1;
    out[3]<=T2;
    out[4]<=T3;
    out[15:5]<=out[14:4];
    
    end
end
endmodule

module Cathode_Control(input [3:0]bcd,output reg [6:0] out=0);
always @(bcd)
    begin
        case (bcd) 
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
            default : out = 7'b0000000; 
        endcase
    end
    
endmodule
		

		
			


		
	

	

