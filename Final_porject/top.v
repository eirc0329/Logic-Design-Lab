module top(
   input clk,
   input rst,
   input jump,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue,
   output hsync,
   output vsync,
   output pmod_1,
   output pmod_2,
   output pmod_4,
   output  [3:0]an,
   output  [6:0]seg
    );
    parameter BEAT_FREQ = 32'd8;	//one beat=0.125sec
    parameter DUTY_BEST = 10'd512;	//duty cycle=50%

    wire [31:0] freq;
    wire [7:0] ibeatNum;
    wire beatFreq;
    wire [1:0]state;//0 => start 1=>game 
    wire clk_25MHz;
    wire clk_22;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    wire [9:0] dino_x,dino_y,obtacle_x,obtacle_y,bird_x,bird_y;//din_x = left 
                                                 //din_y = top
    wire  jump_op,jump_db,rst_op,rst_db;   
    wire dead;
    wire [15:0] score;
                                      
    onepulse op1(jump_db, jump_op, clk);
    debounce db1(jump, jump_db, clk);
    onepulse op2(rst_db, rst_op, clk);
    debounce db2(rst, rst_db, clk);
    
  assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;
    FSM fs(
    .clk(clk),
    .rst(rst_op),
    .jump_op(jump_op),
    .dead(dead),
    .state(state)
    );
     clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk22(clk_22)
    );
     dino di(
    .clk(clk),
    .rst(rst_op),
    .jump_op(jump_op),
    .dino_x(dino_x),
    .dino_y(dino_y)
    ); 
    
    obtacle obt (
    .clk(clk),
    .rst(rst_op),
    .state(state),
    .score(score),
    .obtacle_x(obtacle_x),
    .obtacle_y(obtacle_y)
    ); 

    bird bir (
    .clk(clk),
    .rst(rst_op),
    .state(state),
    .bird_x(bird_x),
    .bird_y(bird_y)
    ); 

       
    draw dr(
      .clk(clk_25MHz),
      .rst(rst_op),
      .dino_x(dino_x),
      .dino_y(dino_y),   
      .obtacle_x(obtacle_x),
      .obtacle_y(obtacle_y),  
      .bird_x(bird_x),
      .bird_y(bird_y), 
      .x(h_cnt),
      .y(v_cnt),     
      .state(state),
      .pixel(pixel),
      .dead(dead)
    ); 

    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst_op),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
    
//seven-segment
Score s(
    clk, 
    rst,
    state,
    jump_op,
    an, 
    seg,
    score
    ); 
    
//Music
assign pmod_2 = 1'd1;	//no gain(6dB)
assign pmod_4 = 1'd1;	//turn-on

//Generate beat speed
PWM_gen btSpeedGen ( .clk(clk), 
					 .reset(rst),
					 .freq(BEAT_FREQ),
					 .duty(DUTY_BEST), 
					 .PWM(beatFreq)
);
	
//manipulate beat
PlayerCtrl playerCtrl_00 ( .clk(beatFreq),
						   .reset(rst),
						   .ibeat(ibeatNum)
);	
	
//Generate variant freq. of tones
Music music00 ( .ibeatNum(ibeatNum),
				.tone(freq)
);

// Generate particular freq. signal
PWM_gen toneGen ( .clk(clk), 
				  .reset(rst), 
				  .freq(freq),
				  .duty(DUTY_BEST), 
				  .PWM(pmod_1)
);
endmodule


module onepulse(s, s_op, clk);
	input s, clk;
	output reg s_op;
	reg s_delay;
	always@(posedge clk)begin
		s_op <= s&(!s_delay);
		s_delay <= s;
	end
endmodule

module debounce(s, s_db, clk);
	input s, clk;
	output s_db;
	reg [3:0] DFF;
	
	always@(posedge clk)begin
		DFF[3:1] <= DFF[2:0];
		DFF[0] <= s;
	end
	assign s_db = (DFF == 4'b1111)? 1'b1 : 1'b0;
endmodule
