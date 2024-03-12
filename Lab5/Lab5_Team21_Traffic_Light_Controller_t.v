`timescale 1ns/1ps

module Traffic_Light_Controller_t();
reg clk, rst_n;
reg lr_has_car;
wire [2:0] hw_light;
wire [2:0] lr_light;
parameter cyc =4'd10;

always #5 clk = ~clk;
Traffic_Light_Controller tlc(clk, rst_n, lr_has_car, hw_light, lr_light);

initial begin
clk = 1'b1;
rst_n = 1'b1;
lr_has_car = 1'b0;
@(negedge clk)rst_n = 1'b0;
@(negedge clk)rst_n = 1'b1;
lr_has_car = 1'b1;



end
endmodule
