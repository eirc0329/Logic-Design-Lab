module Score(
    input clk, 
    input reset, 
    input [1:0]state,
    input jump,
    output reg [3:0] an, 
    output reg [6:0] seg,
    output [15:0] score
    );
    reg [26:0] one_second_counter;
    wire one_second_enable;
    reg [15:0] number;
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; 

    wire [1:0] LED_activating_counter; 
    assign score = number;
    always @(posedge clk or posedge reset)
    begin
        if(reset==1)
            one_second_counter <= 0;
        else begin
            if(one_second_counter>=99999999) 
                 one_second_counter <= 0;
            else
                one_second_counter <= one_second_counter + 1;
        end
    end 
    assign one_second_enable = (one_second_counter==99999999)?1:0;
    always @(posedge clk or posedge reset)
    begin
        if(reset==1)
            number <= 0;
        else if(state == 2'b00 && jump==1'b0)
            number <= number;
        else if(state == 2'b00 && jump==1'b1)
            number <= 0;
        else if(one_second_enable==1)
            number <= number + 1;
    end
    always @(posedge clk or posedge reset)
    begin 
        if(reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];

    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            an = 4'b0111; 
            LED_BCD = number/1000;
              end
        2'b01: begin
            an = 4'b1011; 
            LED_BCD = (number % 1000)/100;
              end
        2'b10: begin
            an = 4'b1101; 
            LED_BCD = ((number % 1000)%100)/10;
                end
        2'b11: begin
            an = 4'b1110; 
            LED_BCD = ((number % 1000)%100)%10;
               end
        endcase
    end

    always @(*)
    begin
        case(LED_BCD)
        4'b0000: seg = 7'b0000001;  
        4'b0001: seg = 7'b1001111; 
        4'b0010: seg = 7'b0010010; 
        4'b0011: seg = 7'b0000110; 
        4'b0100: seg = 7'b1001100; 
        4'b0101: seg = 7'b0100100;
        4'b0110: seg = 7'b0100000;
        4'b0111: seg = 7'b0001111; 
        4'b1000: seg = 7'b0000000;   
        4'b1001: seg = 7'b0000100; 
        default: seg = 7'b0000001;
        endcase
    end
 endmodule