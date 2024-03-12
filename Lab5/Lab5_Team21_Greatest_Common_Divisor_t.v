`timescale 1ns/1ps

module Greatest_Common_Divisor_t;
reg clk, rst_n;
reg start;
reg [15:0] a;
reg [15:0] b;
wire done;
wire [15:0] gcd;

parameter cyc =4'd10;
always #(cyc/2) clk = ~clk;

Greatest_Common_Divisor GCD(clk, rst_n, start, a, b, done, gcd);
initial  begin   
    clk = 1'b1;
    rst_n = 1'b0;
    @(negedge clk) 
    rst_n = 1'b1;
    start = 1'b0;
    a     = 16'd100;
    b     = 16'd50 ;
    @(negedge clk)
    a     = 16'd6;
    b     = 16'd9;
    start = 1'b1;
    #(cyc*6)
    a     = 16'd0;
    b     = 16'd5;
    #(cyc*6)
    $finish;
    
end

endmodule
