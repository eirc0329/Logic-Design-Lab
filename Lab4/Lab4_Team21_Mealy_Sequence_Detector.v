`timescale 1ns/1ps

module Mealy_Sequence_Detector (clk, rst_n, in, dec);
input clk, rst_n;
input in;
output dec;

parameter S0 = 4'd0;
parameter S1 = 4'd1;
parameter S2 = 4'd2;
parameter S3 = 4'd3;
parameter S4 = 4'd4;
parameter S5 = 4'd5;
parameter S6 = 4'd6;
parameter S7 = 4'd7;
parameter S8 = 4'd8;
parameter S9 = 4'd9;
parameter S10 = 4'd10;

reg dec;
reg [3:0]state;
reg [3:0]next_state;


always @(posedge clk) begin
 if (!rst_n)
    state <= S0;
 else
    state <= next_state;
end

always @(*) begin
    case (state)
    S0:
        if (in == 1'b1) begin
        next_state = S4;
        dec = 1'b0;
        end
        else begin
        next_state = S1;
        dec = 1'b0;
        end
    S1:
        if (in == 1'b1) begin
        next_state = S2;
        dec = 1'b0;
        end
        else begin
        next_state = S9;
        dec = 1'b0;
        end
    S2:
        if (in == 1'b1) begin
        next_state = S3;
        dec = 1'b0;
        end
        else begin
        next_state = S10;
        dec = 1'b0;
        end  
    S3:
        if (in == 1'b1) begin
        next_state = S0;
        dec = 1'b1;
        end
        else begin
        next_state = S0;
        dec = 1'b0;
        end
    S4:
        if (in == 1'b1) begin
        next_state = S7;
        dec = 1'b0;
        end
        else begin
        next_state = S5;
        dec = 1'b0;
        end      
    S5:
        if (in == 1'b1) begin
        next_state = S10;
        dec = 1'b0;
        end
        else begin
        next_state = S6;
        dec = 1'b0;
        end
    S6:
        if (in == 1'b1) begin
        next_state = S0;
        dec = 1'b1;
        end
        else begin
        next_state = S0;
        dec = 1'b0;
        end  
    S7:
        if (in == 1'b1) begin
        next_state = S8;
        dec = 1'b0;
        end
        else begin
        next_state = S10;
        dec = 1'b0;
        end
    S8:
        if (in == 1'b1) begin
        next_state = S0;
        dec = 1'b0;
        end
        else begin
        next_state = S0;
        dec = 1'b1;
        end      
    S9:
        if (in == 1'b1) begin
        next_state = S10;
        dec = 1'b0;
        end
        else begin
        next_state = S10;
        dec = 1'b0;
        end      
    default://S10
        if (in == 1'b1) begin
        next_state = S0;
        dec = 1'b0;
        end
        else begin
        next_state = S0;
        dec = 1'b0;
        end
    endcase
end


endmodule
