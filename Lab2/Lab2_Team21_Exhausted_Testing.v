`timescale 1ns/1ps

module Exhausted_Testing(a, b, cin, error, done);
output [3:0] a, b;
output cin;
output error;
output done;

// input signal to the test instance.
reg [3:0] a = 4'b0000;
reg [3:0] b = 4'b0000;
reg cin = 1'b0;
reg error = 1'b0;
reg done = 1'b0;

// output from the test instance.
wire [3:0] sum;
wire cout;

// instantiate the test instance.
Ripple_Carry_Adder rca(
    .a (a), 
    .b (b), 
    .cin (cin),
    .cout (cout),
    .sum (sum)
);

initial begin
    repeat(2**9) begin
        #1 if({cout,sum}==a+b+cin) begin
               assign error=1'b0;
           end
           else begin
               assign error=1'b1;  
           end
        #4 {a,b,cin}={a,b,cin}+1'b1;
    end
    assign done=1'b1;
    $finish;
end 

endmodule