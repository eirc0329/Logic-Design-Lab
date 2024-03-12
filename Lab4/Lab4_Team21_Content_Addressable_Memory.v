`timescale 1ns/1ps

module Content_Addressable_Memory(clk, wen, ren, din, addr, dout, hit);
input clk;
input wen, ren;
input [7:0] din;
input [3:0] addr;
output [3:0] dout;
output hit;

reg [7:0] CAM[15:0];
reg [3:0] dout;
reg [3:0] next_dout;
reg hit;
reg next_hit;

//compare
always @(*)begin
   next_hit=1'b1;
   if(CAM[15]==din)
        next_dout=4'd15;
   else if(CAM[14]==din)
        next_dout=4'd14;
   else if(CAM[13]==din)
        next_dout=4'd13;
   else if(CAM[12]==din)
        next_dout=4'd12;
   else if(CAM[11]==din)
        next_dout=4'd11;
   else if(CAM[10]==din)
        next_dout=4'd10;
   else if(CAM[9]==din)
        next_dout=4'd9;
   else if(CAM[8]==din)
        next_dout=4'd8;
   else if(CAM[7]==din)
        next_dout=4'd7;
   else if(CAM[6]==din)
        next_dout=4'd6;
   else if(CAM[5]==din)
        next_dout=4'd5;
   else if(CAM[4]==din)
        next_dout=4'd4;
   else if(CAM[3]==din)
        next_dout=4'd3;
   else if(CAM[2]==din)
        next_dout=4'd2;
   else if(CAM[1]==din)
        next_dout=4'd1;
   else if(CAM[0]==din)
        next_dout=4'd0;
   else begin
        next_hit =1'b0;
        next_dout=1'b0;
   end

end

always @(posedge clk)begin
    if(ren==1'b1)begin
        dout<=next_dout;
        hit<=next_hit;         
    end 
    else if(wen==1'b1)begin
        CAM[addr]<=din;
        dout<=1'b0;
    end
    else begin
        dout<=1'b0;
        hit <=1'b0;
    end

end

endmodule
