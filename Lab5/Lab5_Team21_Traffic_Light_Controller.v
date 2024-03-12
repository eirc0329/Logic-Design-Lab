`timescale 1ns/1ps

module Traffic_Light_Controller (clk, rst_n, lr_has_car, hw_light, lr_light);
input clk, rst_n;
input lr_has_car;
output [2:0] hw_light;//hw_light[2]==green , hw_light[1]==yellow , hw_light[0]==red;
output [2:0] lr_light;

parameter S0 = 3'd0;
parameter S1 = 3'd1;
parameter S2 = 3'd2;
parameter S3 = 3'd3;
parameter S4 = 3'd4;
parameter S5 = 3'd5;
parameter g_time = 10'd80;
parameter y_time = 10'd20;

reg [2:0] hw_light;
reg [2:0] lr_light;
reg [2:0] state;
reg [2:0] next_state;

reg [9:0] count;//counting the cycles that the green &&yellow light been
reg recount ;   

//COUNT 
always @(posedge clk) begin
    if (!rst_n) begin
        count <= 0;
    end else begin
        if(recount == 1'b1)
            count <= 0 ;
        else
            count <= count + 1'b1;
    end
end

//sequential 
always @(posedge clk) begin
    if(!rst_n)
        state <= S0;
    else
        state <= next_state;
end

//state calculation combinational
always @(*)begin
   case (state)
   S0:begin
      hw_light = 3'b100;
      lr_light = 3'b001;
      if(count >= (g_time -1)&& lr_has_car == 1'b1)begin
        recount = 1'b1;
        next_state = S1;
      end else begin
        recount = 1'b0;
        next_state = S0;
      end
   end
   S1:begin
      hw_light = 3'b010;
      lr_light = 3'b001;  
      if(count == (y_time-1))begin
        recount = 1'b1;
        next_state = S2;
      end else begin
        recount = 1'b0;
        next_state = S1;
      end 
   end 
   S2:begin
      hw_light = 3'b001;
      lr_light = 3'b001;
      recount = 1'b1;
      next_state = S3;
   end
   S3:begin
      hw_light = 3'b001;
      lr_light = 3'b100;   
      if(count == (g_time-1))begin
        recount = 1'b1;
        next_state = S4;
      end else begin
        recount = 1'b0;
        next_state = S3;
      end
   end 
 
   S4:begin
      hw_light = 3'b001;
      lr_light = 3'b010;  
      if(count == (y_time-1))begin
        recount = 1'b1;
        next_state = S5;
      end else begin
        recount = 1'b0;
        next_state = S4;
      end  
   end
   S5:begin
      hw_light = 3'b001;
      lr_light = 3'b001;  
      recount = 1'b1;
      next_state = S0; 
   end 
   default:begin
      hw_light = 3'b000;//dummy
      lr_light = 3'b000;  
      recount = 1'b1;
      next_state = S0; 
   end 
   endcase
end


endmodule