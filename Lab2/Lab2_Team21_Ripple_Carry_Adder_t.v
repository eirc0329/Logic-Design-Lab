`timescale 1ns / 1ps

module Ripple_Carry_Adder_t;
reg [7:0] a = 8'b0000000;
reg [7:0] b = 8'b00000000;
reg cin=1'b0;
wire cout;
wire [7:0] sum;

Ripple_Carry_Adder RCA(a,b,cin,cout,sum);

initial begin
    repeat(2 ** 17) begin
        #1 {a,b,cin}={a,b,cin}+1'b1;
    end
    #1 $finish;
end
endmodule
