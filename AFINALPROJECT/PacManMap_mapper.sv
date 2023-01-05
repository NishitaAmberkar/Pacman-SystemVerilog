module PacManMap_mapper (
	input logic [9:0] DrawX, DrawY, BallX, BallY, Pink_BallX, Pink_BallY, Blue_BallX, Blue_BallY, Orange_BallX, Orange_BallY, Red_BallX, Red_BallY, Green_BallX, Green_BallY, Ball_size,
	input logic vga_clk, frame_clk, blank,
	input logic [3:0] ram_data_Out,
	output logic [3:0] red, green, blue,
	input logic [1:0] pac_direction, pac_left_num, 
	input logic [11:0] pacman_score_next,
	input logic [2:0] lives_remaining,
	input logic win, powerup_on, powerup_on2,
	input logic [1:0] state
);
logic [4:0] counter;

//logic [11:0] ram_write_address, ram_read_address;
//logic [3:0] ram_data_In, ram_data_Out;
logic we, ball_on, pink_on, blue_on, orange_on, red_on, green_on, char_on;

//start
logic [17:0] rom_address_start;
logic [4:0] rom_q_start;

logic [3:0] palette_red_start, palette_green_start, palette_blue_start;

assign rom_address_start = (DrawX*320/640) + (DrawY*240/480 * 320);

//game over
logic [15:0] rom_address_game_over;
logic [1:0] rom_q_game_over;

logic [3:0] palette_red_game_over, palette_green_game_over, palette_blue_game_over;

assign rom_address_game_over = (DrawX*160/640) + (DrawY*120/480 * 160);

//Pacman left 
logic [8:0] rom_address_pacman_left_1, rom_address_pacman_left_2, rom_address_pacman_left_3;
logic [1:0] rom_q_pacman_left_1, rom_q_pacman_left_2, rom_q_pacman_left_3;

logic [3:0] palette_red_pacman_left_1, palette_green_pacman_left_1, palette_blue_pacman_left_1, palette_red_pacman_left_2, palette_green_pacman_left_2, palette_blue_pacman_left_2, palette_red_pacman_left_3, palette_green_pacman_left_3, palette_blue_pacman_left_3 ;
assign rom_address_pacman_left_1 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);
assign rom_address_pacman_left_2 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);
assign rom_address_pacman_left_3 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);

//pacman right
logic [8:0] rom_address_pacman_right_1, rom_address_pacman_right_2, rom_address_pacman_right_3;
logic [1:0] rom_q_pacman_right_1, rom_q_pacman_right_2, rom_q_pacman_right_3;

logic [3:0] palette_red_pacman_right_1, palette_green_pacman_right_1, palette_blue_pacman_right_1, palette_red_pacman_right_2, palette_green_pacman_right_2, palette_blue_pacman_right_2, palette_red_pacman_right_3, palette_green_pacman_right_3, palette_blue_pacman_right_3 ;
assign rom_address_pacman_right_1 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);
assign rom_address_pacman_right_2 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);
assign rom_address_pacman_right_3 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);

//pacman up
logic [8:0] rom_address_pacman_up_1, rom_address_pacman_up_2, rom_address_pacman_up_3;
logic [1:0] rom_q_pacman_up_1, rom_q_pacman_up_2, rom_q_pacman_up_3;

logic [3:0] palette_red_pacman_up_1, palette_green_pacman_up_1, palette_blue_pacman_up_1, palette_red_pacman_up_2, palette_green_pacman_up_2, palette_blue_pacman_up_2, palette_red_pacman_up_3, palette_green_pacman_up_3, palette_blue_pacman_up_3 ;
assign rom_address_pacman_up_1 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);
assign rom_address_pacman_up_2 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);
assign rom_address_pacman_up_3 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);


//pacman down
logic [8:0] rom_address_pacman_down_1, rom_address_pacman_down_2, rom_address_pacman_down_3;
logic [1:0] rom_q_pacman_down_1, rom_q_pacman_down_2, rom_q_pacman_down_3;

logic [3:0] palette_red_pacman_down_1, palette_green_pacman_down_1, palette_blue_pacman_down_1, palette_red_pacman_down_2, palette_green_pacman_down_2, palette_blue_pacman_down_2, palette_red_pacman_down_3, palette_green_pacman_down_3, palette_blue_pacman_down_3 ;
assign rom_address_pacman_down_1 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);
assign rom_address_pacman_down_2 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);
assign rom_address_pacman_down_3 = (DrawX-BallX+8) + ((DrawY-BallY+8)* 16);


//Blue ghost
logic [8:0] rom_address_blue_ghost;
logic [2:0] rom_q_blue_ghost;

logic [3:0] palette_red_blue_ghost, palette_green_blue_ghost, palette_blue_blue_ghost;

assign rom_address_blue_ghost = (DrawX-Blue_BallX+8) + ((DrawY-Blue_BallY+8)* 16);

//green ghost
logic [8:0] rom_address_green_ghost;
logic [2:0] rom_q_green_ghost;

logic [3:0] palette_red_green_ghost, palette_green_green_ghost, palette_blue_green_ghost;

assign rom_address_green_ghost = (DrawX-Green_BallX+8) + ((DrawY-Green_BallY+8)* 16);

//red ghost
logic [8:0] rom_address_red_ghost;
logic [2:0] rom_q_red_ghost;

logic [3:0] palette_red_red_ghost, palette_green_red_ghost, palette_blue_red_ghost;

assign rom_address_red_ghost =  (DrawX-Red_BallX+8) + ((DrawY-Red_BallY+8)* 16);


//pink ghost
logic [8:0] rom_address_pink_ghost;
logic [2:0] rom_q_pink_ghost;

logic [3:0] palette_red_pink_ghost, palette_green_pink_ghost, palette_blue_pink_ghost;

assign rom_address_pink_ghost =  (DrawX-Pink_BallX+8) + ((DrawY-Pink_BallY+8)* 16);

//orange ghost

logic [8:0] rom_address_orange_ghost;
logic [2:0] rom_q_orange_ghost;

logic [3:0] palette_red_orange_ghost, palette_green_orange_ghost, palette_blue_orange_ghost;

assign rom_address_orange_ghost =  (DrawX-Orange_BallX+8) + ((DrawY-Orange_BallY+8)* 16);


//Food
logic [8:0] rom_address_food;
logic [1:0] rom_q_food;

logic [3:0] palette_red_food, palette_green_food, palette_blue_food;

assign rom_address_food = (DrawX[3:0]) + ((DrawY[3:0])*16);


//Cherries
logic [8:0] rom_address_cherries;
logic [2:0] rom_q_cherries;

logic [3:0] palette_red_cherries, palette_green_cherries, palette_blue_cherries;

assign rom_address_cherries = (DrawX[3:0]) + (DrawY[3:0]* 16);

//PowerUps
logic [8:0] rom_address_power;
logic [1:0] rom_q_power;

logic [3:0] palette_red_power, palette_green_power, palette_blue_power;

assign rom_address_power = (DrawX[3:0]) + (DrawY[3:0]* 16);

logic [8:0] rom_address_powerup2;
logic [1:0] rom_q_powerup2;

logic [3:0] palette_red_powerup2, palette_green_powerup2, palette_blue_powerup2;

assign rom_address_powerup2 = (DrawX[3:0]) + (DrawY[3:0]* 16);

//Lives
logic [8:0] rom_address_lives;
logic [1:0] rom_q_lives;

logic [3:0] palette_red_lives, palette_green_lives, palette_blue_lives;

assign rom_address_lives = (DrawX[3:0]) + (DrawY[3:0]* 16);

//win screen
logic [15:0] rom_address_win;
logic [2:0] rom_q_win;

logic [3:0] palette_red_win, palette_green_win, palette_blue_win;

assign rom_address_win = (DrawX*160/640) + (DrawY*120/480 * 160);

//Score
logic [7:0] fontrom_addr_ones,  fontrom_addr_tens, fontrom_addr_hunds, fontrom_addr_thous;
logic [15:0] fontrom_data, fontrom_data_ones, fontrom_data_tens, fontrom_data_hunds, fontrom_data_thous;
logic [3:0] ones, tens, hunds, thous;
logic pixel_ones, pixel_tens, pixel_hunds, pixel_thous;


//Frozen ghost orange
logic [8:0] rom_address_freeze_orange;
logic [2:0] rom_q_freeze_orange;

logic [3:0] palette_red_orange_freeze, palette_green_orange_freeze, palette_blue_orange_freeze;

assign rom_address_freeze_orange =(DrawX-Orange_BallX+8) + ((DrawY-Orange_BallY+8)* 16);
//pink freeze
logic [8:0] rom_address_freeze_pink;
logic [2:0] rom_q_freeze_pink;

logic [3:0] palette_red_pink_freeze, palette_green_pink_freeze, palette_blue_pink_freeze;

assign rom_address_freeze_pink =(DrawX-Pink_BallX+8) + ((DrawY-Pink_BallY+8)* 16);

//green freeze
logic [8:0] rom_address_freeze_green;
logic [2:0] rom_q_freeze_green;

logic [3:0] palette_red_green_freeze, palette_green_green_freeze, palette_blue_green_freeze;

assign rom_address_freeze_green =(DrawX-Green_BallX+8) + ((DrawY-Green_BallY+8)* 16);

//blue freeze
logic [8:0] rom_address_freeze_blue;
logic [2:0] rom_q_freeze_blue;

logic [3:0] palette_red_blue_freeze, palette_green_blue_freeze, palette_blue_blue_freeze;

assign rom_address_freeze_blue =(DrawX-Blue_BallX+8) + ((DrawY-Blue_BallY+8)* 16);


//red freeze
logic [8:0] rom_address_freeze_red;
logic [2:0] rom_q_freeze_red;

logic [3:0] palette_red_red_freeze, palette_green_red_freeze, palette_blue_red_freeze;

assign rom_address_freeze_red =(DrawX-Red_BallX+8) + ((DrawY-Red_BallY+8)* 16);


//frighten ghost orange
logic [8:0] rom_address_orange_ghost1;
logic [2:0] rom_q_orange_ghost1;

logic [3:0] palette_red_orange_ghost1, palette_green_orange_ghost1, palette_blue_orange_ghost1;

assign rom_address_orange_ghost1 =(DrawX-Orange_BallX+8) + ((DrawY-Orange_BallY+8)* 16);
//pink frighten
logic [8:0] rom_address_pink_ghost1;
logic [2:0] rom_q_pink_ghost1;

logic [3:0] palette_red_pink_ghost1, palette_green_pink_ghost1, palette_blue_pink_ghost1;

assign rom_address_pink_ghost1 =(DrawX-Pink_BallX+8) + ((DrawY-Pink_BallY+8)* 16);

//green frighten
logic [8:0] rom_address_green_ghost1;
logic [2:0] rom_q_green_ghost1;

logic [3:0] palette_red_green_ghost1, palette_green_green_ghost1, palette_blue_green_ghost1;

assign rom_address_green_ghost1 =(DrawX-Green_BallX+8) + ((DrawY-Green_BallY+8)* 16);

//blue frighten
logic [8:0] rom_address_blue_ghost1;
logic [2:0] rom_q_blue_ghost1;

logic [3:0] palette_red_blue_ghost1, palette_green_blue_ghost1, palette_blue_blue_ghost1;

assign rom_address_blue_ghost1 =(DrawX-Blue_BallX+8) + ((DrawY-Blue_BallY+8)* 16);


//red frighten
logic [8:0] rom_address_red_ghost1;
logic [2:0] rom_q_red_ghost1;

logic [3:0] palette_red_red_red_ghost1, palette_green_red_ghost1, palette_blue_red_ghost1;

assign rom_address_red_ghost1 =(DrawX-Red_BallX+8) + ((DrawY-Red_BallY+8)* 16);




assign ones = pacman_score_next % 10;
assign tens = (pacman_score_next / 10) % 10;
assign hunds = (pacman_score_next / 100) % 10;
assign thous = (pacman_score_next / 1000) % 10;

int DistX, DistY, Pink_DistX, Pink_DistY, Blue_DistX, Blue_DistY, Orange_DistX, Orange_DistY, Red_DistX, Red_DistY, Green_DistX, Green_DistY, Size;
assign DistX = DrawX - BallX;
assign DistY = DrawY - BallY;

assign Pink_DistX = DrawX - Pink_BallX;
assign Pink_DistY = DrawY - Pink_BallY;

assign Blue_DistX = DrawX - Blue_BallX;
assign Blue_DistY = DrawY - Blue_BallY;

assign Orange_DistX = DrawX - Orange_BallX;
assign Orange_DistY = DrawY - Orange_BallY;

assign Red_DistX = DrawX - Red_BallX;
assign Red_DistY = DrawY - Red_BallY;

assign Green_DistX = DrawX - Green_BallX;
assign Green_DistY = DrawY - Green_BallY;

assign Size = Ball_size;

//logic [7:0] fontrom_data_addr;

always_comb
  begin:Ball_on_proc
     if ( DistX<=Size && DistY<=Size && DistX>=-Size && DistY>=-Size ) 
            ball_on = 1'b1;
     else 
            ball_on = 1'b0;
     if ( Pink_DistX<=Size && Pink_DistY<=Size && Pink_DistX>=-Size && Pink_DistY>=-Size ) 
            pink_on = 1'b1;
     else 
            pink_on = 1'b0;
     if ( Blue_DistX<=Size && Blue_DistY<=Size && Blue_DistX>=-Size && Blue_DistY>=-Size ) 
            blue_on = 1'b1;
     else 
            blue_on = 1'b0;
     if ( Orange_DistX<=Size && Orange_DistY<=Size && Orange_DistX>=-Size && Orange_DistY>=-Size ) 
            orange_on = 1'b1;
     else 
            orange_on = 1'b0;
     if ( Red_DistX<=Size && Red_DistY<=Size && Red_DistX>=-Size && Red_DistY>=-Size ) 
            red_on = 1'b1;
     else 
            red_on = 1'b0;
		if ( Green_DistX<=Size && Green_DistY<=Size && Green_DistX>=-Size && Green_DistY>=-Size ) 
            green_on = 1'b1;
     else 
            green_on = 1'b0;
  end 
 always_ff @ (posedge frame_clk) begin
	counter<=counter+1;
 end

assign fontrom_addr_ones = ones*16 + DrawY[3:0];
assign pixel_ones = fontrom_data_ones[15 - DrawX[3:0]];

assign fontrom_addr_tens = tens*16 + DrawY[3:0];
assign pixel_tens = fontrom_data_tens[15 - DrawX[3:0]];

assign fontrom_addr_hunds = hunds*16 + DrawY[3:0];
assign pixel_hunds = fontrom_data_hunds[15 - DrawX[3:0]];

assign fontrom_addr_thous = thous*16 + DrawY[3:0];
assign pixel_thous = fontrom_data_thous[15 - DrawX[3:0]];

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;
	if(state == 2'b00) begin
		red <= palette_red_start;
		green <= palette_green_start;
		blue <= palette_blue_start;
		end
	else if (state == 2'b10) //GameOver
	begin
		red <= palette_red_game_over;
		green <= palette_green_game_over;
		blue <= palette_blue_game_over;
	end
	else if (state == 2'b11) //YouWin
	begin
		red <= palette_red_win;
		green <= palette_green_win;
		blue <= palette_blue_win;
	end
	else if (state == 2'b01) //Level
	begin			
		if (ball_on == 1'b1 && pac_direction == 2'b00 && palette_red_pacman_left_1[0] !=0) begin 
				 if(counter % 32 >= 0 && counter % 32 <= 7) begin
					red <= palette_red_pacman_left_1;
					green <= palette_green_pacman_left_1;
					blue <= palette_blue_pacman_left_1;
					end
				else if(counter % 32 >= 8 && counter % 32 <= 15) begin
					red <= palette_red_pacman_left_2;
					green <= palette_green_pacman_left_2;
					blue <= palette_blue_pacman_left_2;
					end
				else if(counter % 32 >= 16 && counter % 32 <= 23) begin
					red <= palette_red_pacman_left_3;
					green <= palette_green_pacman_left_3;
					blue <= palette_blue_pacman_left_3;
					end
				else begin
					red <= palette_red_pacman_left_2;
					green <= palette_green_pacman_left_2;
					blue <= palette_blue_pacman_left_2;
					end
			end
			
		else if (ball_on == 1'b1 && pac_direction == 2'b01 && palette_red_pacman_right_1[0] != 0 ) begin 
				if(counter % 32 >= 0 && counter % 32 <= 7) begin
					red <= palette_red_pacman_right_1;
					green <= palette_green_pacman_right_1;
					blue <= palette_blue_pacman_right_1;
					end
				else if(counter % 32 >= 8 && counter % 32 <= 15) begin
					red <= palette_red_pacman_right_2;
					green <= palette_green_pacman_right_2;
					blue <= palette_blue_pacman_right_2;
					end
				else if(counter % 32 >= 16 && counter % 32 <= 23) begin
					red <= palette_red_pacman_right_3;
					green <= palette_green_pacman_right_3;
					blue <= palette_blue_pacman_right_3;
					end
				else begin
					red <= palette_red_pacman_right_2;
					green <= palette_green_pacman_right_2;
					blue <= palette_blue_pacman_right_2;
					end
			end

		else if ((ball_on == 1'b1) && pac_direction ==2'b10 && palette_red_pacman_down_1[0] != 0 ) begin 
				if(counter % 32 >= 0 && counter % 32 <= 7) begin
					red <= palette_red_pacman_down_1;
					green <= palette_green_pacman_down_1;
					blue <= palette_blue_pacman_down_1;
					end
				else if(counter % 32 >= 8 && counter % 32 <= 15) begin
					red <= palette_red_pacman_down_2;
					green <= palette_green_pacman_down_2;
					blue <= palette_blue_pacman_down_2;
					end
				else if(counter % 32 >= 16 && counter % 32 <= 23) begin
					red <= palette_red_pacman_down_3;
					green <= palette_green_pacman_down_3;
					blue <= palette_blue_pacman_down_3;
					end
				else begin
					red <= palette_red_pacman_down_2;
					green <= palette_green_pacman_down_2;
					blue <= palette_blue_pacman_down_2;
					end
			end

		else if ((ball_on == 1'b1) && pac_direction ==2'b11 && palette_red_pacman_up_1[0] != 0 ) begin 
			if(counter % 32 >= 0 && counter % 32 <= 7) begin
					red <= palette_red_pacman_up_1;
					green <= palette_green_pacman_up_1;
					blue <= palette_blue_pacman_up_1;
					end
				else if(counter % 32 >= 8 && counter % 32 <= 15) begin
					red <= palette_red_pacman_up_2;
					green <= palette_green_pacman_up_2;
					blue <= palette_blue_pacman_up_2;
					end
				else if(counter % 32 >= 16 && counter % 32 <= 23) begin
					red <= palette_red_pacman_up_3;
					green <= palette_green_pacman_up_3;
					blue <= palette_blue_pacman_up_3;
					end
				else begin
					red <= palette_red_pacman_up_2;
					green <= palette_green_pacman_up_2;
					blue <= palette_blue_pacman_up_2;
					end
			end

	
		  else if((red_on == 1'b1) && palette_green_red_ghost != 4'b0 ) begin
				if(powerup_on) begin
					red <= palette_red_red_freeze;
					green <= palette_green_red_freeze;
					blue <= palette_blue_red_freeze;
				end
				else if(powerup_on2) begin
						red <= palette_red_red_ghost1;
						green <= palette_green_red_ghost1;
						blue <= palette_blue_red_ghost1;
					end
				else begin
					red <= palette_red_red_ghost;
					green <= palette_green_red_ghost;
					blue <= palette_blue_red_ghost;
				end
		  end
		  else if((blue_on == 1'b1) && palette_green_blue_ghost != 4'b0) begin
			  if(powerup_on) begin
						red <= palette_red_blue_freeze;
						green <= palette_green_blue_freeze;
						blue <= palette_blue_blue_freeze;
					end
					else if(powerup_on2) begin
						red <= palette_red_blue_ghost1;
						green <= palette_green_blue_ghost1;
						blue <= palette_blue_blue_ghost1;
					end
					else begin
						red <= palette_red_blue_ghost;
						green <= palette_green_blue_ghost;
						blue <= palette_blue_blue_ghost;
					end
		  end
		  else if((pink_on == 1'b1) && palette_green_pink_ghost != 4'b0) begin
			if(powerup_on) begin
					red <= palette_red_pink_freeze;
					green <= palette_green_pink_freeze;
					blue <= palette_blue_pink_freeze;
				end
				else if(powerup_on2) begin
					red <= palette_red_pink_ghost1;
					green <= palette_green_pink_ghost1;
					blue <= palette_blue_pink_ghost1;
				end
				else begin
					red <= palette_red_pink_ghost;
					green <= palette_green_pink_ghost;
					blue <= palette_blue_pink_ghost;
				end
		  end
		  else if((orange_on == 1'b1) && palette_green_orange_ghost != 4'b0 ) begin
			if(powerup_on) begin
					red <= palette_red_orange_freeze;
					green <= palette_green_orange_freeze;
					blue <= palette_blue_orange_freeze;
				end
				else if(powerup_on2) begin
						red <= palette_red_orange_ghost1;
						green <= palette_green_orange_ghost1;
						blue <= palette_blue_orange_ghost1;
					end
				else begin
					red <= palette_red_orange_ghost;
					green <= palette_green_orange_ghost;
					blue <= palette_blue_orange_ghost;
				end
		  end
		  else if((green_on == 1'b1) && palette_green_green_ghost != 4'b0) begin
				if(powerup_on) begin
					red <= palette_red_green_freeze;
					green <= palette_green_green_freeze;
					blue <= palette_blue_green_freeze;
				end
				else if(powerup_on2) begin
						red <= palette_red_green_ghost1;
						green <= palette_green_green_ghost1;
						blue <= palette_blue_green_ghost1;
					end
				else begin
					red <= palette_red_green_ghost;
					green <= palette_green_green_ghost;
					blue <= palette_blue_green_ghost;
					end

		  end
			else if (blank) 
				begin
				case (ram_data_Out) 
					4'h0: begin
						red<= 4'h0;
						green <= 4'h0;
						blue <= 4'h0;
					end

					4'h1: begin
						red <= 4'h2;
						green <= 4'h2;
						blue <= 4'hF;
					end
	 
					4'h2: begin
						red <= palette_red_food;
						green <= palette_green_food;
						blue <= palette_blue_food;
					end
					4'h5: begin
						 if(counter % 32 <= 15 ) begin
							red <= palette_red_powerup2;
							green <= palette_green_powerup2;
							blue <= palette_blue_powerup2;
						end
						else begin
							red<= 4'h0;
							green <= 4'h0;
							blue <= 4'h0;
						end
						
					end
					4'h7: begin
						 if(counter % 32 <= 15 ) begin
							red <= palette_red_power;
							green <= palette_green_power;
							blue <= palette_blue_power;
						end
						else begin
							red<= 4'h0;
							green <= 4'h0;
							blue <= 4'h0;
						end
						
					end
					4'h8: begin
						if  (pixel_thous == 1'b1)
							begin
							red <= 4'h0;
							green <= 4'h0;
							blue <= 4'hF;
							end
						else 
							begin 
							red <= 4'hF;
							green <= 4'h0;
							blue <= 4'h0;
							end
					end
					4'h9: begin
						if  (pixel_hunds == 1'b1)
							begin
							red <= 4'h0;
							green <= 4'h0;
							blue <= 4'hF;
							end
						else 
							begin 
							red <= 4'hF;
							green <= 4'h0;
							blue <= 4'h0;
							end
					end
					4'hA: begin
						if(lives_remaining ==3) begin
							 if(DrawX<=80) begin
								 red <= palette_red_lives;
								green <= palette_green_lives;
								blue <= palette_blue_lives;
							end
						end
						else 
						if(lives_remaining ==2) begin
							 if(DrawX<=64) begin
								 red <= palette_red_lives;
								green <= palette_green_lives;
								blue <= palette_blue_lives;
							end
						end
						else if(lives_remaining ==1) begin
							 if(DrawX<=48) begin
								 red <= palette_red_lives;
								green <= palette_green_lives;
								blue <= palette_blue_lives;
							end
						end
						else begin
							 red <= 0;
							green <= 0;
							blue <= 0;
						end
					end
					4'hB: begin
						red <= palette_red_cherries;
						green <= palette_green_cherries;
						blue <= palette_blue_cherries;
					end
					4'hE: begin
						if  (pixel_tens == 1'b1)
							begin
							red <= 4'h0;
							green <= 4'h0;
							blue <= 4'hF;
							end
						else 
							begin 
							red <= 4'hF;
							green <= 4'h0;
							blue <= 4'h0;
							end
					end
					4'hF: begin
						if  (pixel_ones == 1'b1)
							begin
							red <= 4'h0;
							green <= 4'h0;
							blue <= 4'hF;
							end
						else 
							begin 
							red <= 4'hF;
							green <= 4'h0;
							blue <= 4'h0;
							end
					end
					default: begin
						red<= 4'h0;
						green <= 4'h0;
						blue <= 4'h0;
					end
					endcase
				end
		else begin
				red <= 4'h0;
				green <= 4'h0;
				blue <= 4'h0;
		end
	end


end



font_rom myFontRom(
							.addr_ones(fontrom_addr_ones), 
							.addr_tens(fontrom_addr_tens), 
							.addr_hunds(fontrom_addr_hunds),
							.addr_thous(fontrom_addr_thous),
							.data_ones(fontrom_data_ones), 
							.data_tens(fontrom_data_tens), 
							.data_hunds(fontrom_data_hunds),
							.data_thous(fontrom_data_thous)
		);

Food_rom Food_rom (
	.clock   (vga_clk),
	.address (rom_address_food),
	.q       (rom_q_food)
);

Food_palette Food_palette (
	.index (rom_q_food),
	.red   (palette_red_food),
	.green (palette_green_food),
	.blue  (palette_blue_food)
);

pacman_left_1_rom pacman_left_1_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_left_1),
	.q       (rom_q_pacman_left_1)
);

pacman_left_1_palette pacman_left_1_palette (
	.index (rom_q_pacman_left_1),
	.red   (palette_red_pacman_left_1),
	.green (palette_green_pacman_left_1),
	.blue  (palette_blue_pacman_left_1)
);

pacman_left_2_rom pacman_left_2_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_left_2),
	.q       (rom_q_pacman_left_2)
);

pacman_left_2_palette pacman_left_2_palette (
	.index (rom_q_pacman_left_2),
	.red   (palette_red_pacman_left_2),
	.green (palette_green_pacman_left_2),
	.blue  (palette_blue_pacman_left_2)
);

pacman_left_3_rom pacman_left_3_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_left_3),
	.q       (rom_q_pacman_left_3)
);

pacman_left_3_palette pacman_left_3_palette (
	.index (rom_q_pacman_left_3),
	.red   (palette_red_pacman_left_3),
	.green (palette_green_pacman_left_3),
	.blue  (palette_blue_pacman_left_3)
);

//pacman right
pacman_right_1_rom pacman_right_1_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_right_1),
	.q       (rom_q_pacman_right_1)
);

pacman_right_1_palette pacman_right_1_palette (
	.index (rom_q_pacman_right_1),
	.red   (palette_red_pacman_right_1),
	.green (palette_green_pacman_right_1),
	.blue  (palette_blue_pacman_right_1)
);

pacman_right_2_rom pacman_right_2_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_right_2),
	.q       (rom_q_pacman_right_2)
);

pacman_right_2_palette pacman_right_2_palette (
	.index (rom_q_pacman_right_2),
	.red   (palette_red_pacman_right_2),
	.green (palette_green_pacman_right_2),
	.blue  (palette_blue_pacman_right_2)
);

pacman_right_3_rom pacman_right_3_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_right_3),
	.q       (rom_q_pacman_right_3)
);

pacman_right_3_palette pacman_right_3_palette (
	.index (rom_q_pacman_right_3),
	.red   (palette_red_pacman_right_3),
	.green (palette_green_pacman_right_3),
	.blue  (palette_blue_pacman_right_3)
);

//pacman up
pacman_up_1_rom pacman_up_1_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_up_1),
	.q       (rom_q_pacman_up_1)
);

pacman_up_1_palette pacman_up_1_palette (
	.index (rom_q_pacman_up_1),
	.red   (palette_red_pacman_up_1),
	.green (palette_green_pacman_up_1),
	.blue  (palette_blue_pacman_up_1)
);

pacman_up_2_rom pacman_up_2_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_up_2),
	.q       (rom_q_pacman_up_2)
);

pacman_up_2_palette pacman_up_2_palette (
	.index (rom_q_pacman_up_2),
	.red   (palette_red_pacman_up_2),
	.green (palette_green_pacman_up_2),
	.blue  (palette_blue_pacman_up_2)
);

pacman_up_3_rom pacman_up_3_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_up_3),
	.q       (rom_q_pacman_up_3)
);

pacman_up_3_palette pacman_up_3_palette (
	.index (rom_q_pacman_up_3),
	.red   (palette_red_pacman_up_3),
	.green (palette_green_pacman_up_3),
	.blue  (palette_blue_pacman_up_3)
);

//pacman down
pacman_down_1_rom pacman_down_1_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_down_1),
	.q       (rom_q_pacman_down_1)
);

pacman_down_1_palette pacman_down_1_palette (
	.index (rom_q_pacman_down_1),
	.red   (palette_red_pacman_down_1),
	.green (palette_green_pacman_down_1),
	.blue  (palette_blue_pacman_down_1)
);

pacman_down_2_rom pacman_down_2_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_down_2),
	.q       (rom_q_pacman_down_2)
);

pacman_down_2_palette pacman_down_2_palette (
	.index (rom_q_pacman_down_2),
	.red   (palette_red_pacman_down_2),
	.green (palette_green_pacman_down_2),
	.blue  (palette_blue_pacman_down_2)
);

pacman_down_3_rom pacman_down_3_rom (
	.clock   (vga_clk),
	.address (rom_address_pacman_down_3),
	.q       (rom_q_pacman_down_3)
);

pacman_down_3_palette pacman_down_3_palette (
	.index (rom_q_pacman_down_3),
	.red   (palette_red_pacman_down_3),
	.green (palette_green_pacman_down_3),
	.blue  (palette_blue_pacman_down_3)
);



blue_ghost_left_rom blue_ghost_left_rom (
	.clock   (vga_clk),
	.address (rom_address_blue_ghost),
	.q       (rom_q_blue_ghost)
);

blue_ghost_left_palette blue_ghost_left_palette (
	.index (rom_q_blue_ghost),
	.red   (palette_red_blue_ghost),
	.green (palette_green_blue_ghost),
	.blue  (palette_blue_blue_ghost)
);

red_ghost_left_rom red_ghost_left_rom (
	.clock   (vga_clk),
	.address (rom_address_red_ghost),
	.q       (rom_q_red_ghost)
);

red_ghost_left_palette red_ghost_left_palette (
	.index (rom_q_red_ghost),
	.red   (palette_red_red_ghost),
	.green (palette_green_red_ghost),
	.blue  (palette_blue_red_ghost)
);

pink_ghost_left_rom pink_ghost_left_rom (
	.clock   (vga_clk),
	.address (rom_address_pink_ghost),
	.q       (rom_q_pink_ghost)
);

pink_ghost_left_palette pink_ghost_left_palette (
	.index (rom_q_pink_ghost),
	.red   (palette_red_pink_ghost),
	.green (palette_green_pink_ghost),
	.blue  (palette_blue_pink_ghost)
);
orange_ghost_left_rom orange_ghost_left_rom (
	.clock   (vga_clk),
	.address (rom_address_orange_ghost),
	.q       (rom_q_orange_ghost)
);

orange_ghost_left_palette orange_ghost_left_palette (
	.index (rom_q_orange_ghost),
	.red   (palette_red_orange_ghost),
	.green (palette_green_orange_ghost),
	.blue  (palette_blue_orange_ghost)
);

cherries_rom cherries_rom (
	.clock   (vga_clk),
	.address (rom_address_cherries),
	.q       (rom_q_cherries)
);

cherries_palette cherries_palette (
	.index (rom_q_cherries),
	.red   (palette_red_cherries),
	.green (palette_green_cherries),
	.blue  (palette_blue_cherries)
);

PowerUp_rom PowerUp_rom (
	.clock   (vga_clk),
	.address (rom_address_power),
	.q       (rom_q_power)
);

PowerUp_palette PowerUp_palette (
	.index (rom_q_power),
	.red   (palette_red_power),
	.green (palette_green_power),
	.blue  (palette_blue_power)
);
lives_rom lives_rom (
	.clock   (vga_clk),
	.address (rom_address_lives),
	.q       (rom_q_lives)
);

lives_palette lives_palette (
	.index (rom_q_lives),
	.red   (palette_red_lives),
	.green (palette_green_lives),
	.blue  (palette_blue_lives)
);

game_over_rom game_over_rom (
	.clock   (vga_clk),
	.address (rom_address_game_over),
	.q       (rom_q_game_over)
);

game_over_palette game_over_palette (
	.index (rom_q_game_over),
	.red   (palette_red_game_over),
	.green (palette_green_game_over),
	.blue  (palette_blue_game_over)
);

WinScreen_rom WinScreen_rom (
	.clock   (vga_clk),
	.address (rom_address_win),
	.q       (rom_q_win)
);

WinScreen_palette WinScreen_palette (
	.index (rom_q_win),
	.red   (palette_red_win),
	.green (palette_green_win),
	.blue  (palette_blue_win)
);

StartScreen_rom StartScreen_rom (
	.clock   (vga_clk),
	.address (rom_address_start),
	.q       (rom_q_start)
);

StartScreen_palette StartScreen_palette (
	.index (rom_q_start),
	.red   (palette_red_start),
	.green (palette_green_start),
	.blue  (palette_blue_start)
);

green_ghost_left_rom green_ghost_left_rom (
	.clock   (vga_clk),
	.address (rom_address_green_ghost),
	.q       (rom_q_green_ghost)
);

green_ghost_left_palette green_ghost_left_palette (
	.index (rom_q_green_ghost),
	.red   (palette_red_green_ghost),
	.green (palette_green_green_ghost),
	.blue  (palette_blue_green_ghost)
);

freeze_pacman_rom freeze_pacman_rom_orange (
	.clock   (vga_clk),
	.address (rom_address_freeze_orange),
	.q       (rom_q_freeze_orange)
);

freeze_pacman_palette freeze_pacman_palette_orange (
	.index (rom_q_freeze_orange),
	.red   (palette_red_orange_freeze),
	.green (palette_green_orange_freeze),
	.blue  (palette_blue_orange_freeze)
);

freeze_pacman_rom freeze_pacman_rom_pink (
	.clock   (vga_clk),
	.address (rom_address_freeze_pink),
	.q       (rom_q_freeze_pink)
);

freeze_pacman_palette freeze_pacman_palette_pink (
	.index (rom_q_freeze_pink),
	.red   (palette_red_pink_freeze),
	.green (palette_green_pink_freeze),
	.blue  (palette_blue_pink_freeze)
);

freeze_pacman_rom freeze_pacman_rom_green(
	.clock   (vga_clk),
	.address (rom_address_freeze_green),
	.q       (rom_q_freeze_green)
);

freeze_pacman_palette freeze_pacman_palette_green (
	.index (rom_q_freeze_green),
	.red   (palette_red_green_freeze),
	.green (palette_green_green_freeze),
	.blue  (palette_blue_green_freeze)
);

freeze_pacman_rom freeze_pacman_rom_blue(
	.clock   (vga_clk),
	.address (rom_address_freeze_blue),
	.q       (rom_q_freeze_blue)
);

freeze_pacman_palette freeze_pacman_palette_blue (
	.index (rom_q_freeze_blue),
	.red   (palette_red_blue_freeze),
	.green (palette_green_blue_freeze),
	.blue  (palette_blue_blue_freeze)
);

freeze_pacman_rom freeze_pacman_rom_red(
	.clock   (vga_clk),
	.address (rom_address_freeze_red),
	.q       (rom_q_freeze_red)
);

freeze_pacman_palette freeze_pacman_palette_red (
	.index (rom_q_freeze_red),
	.red   (palette_red_red_freeze),
	.green (palette_green_red_freeze),
	.blue  (palette_blue_red_freeze)
);

frighten_state_rom frighten_state_rom_pink (
	.clock   (vga_clk),
	.address (rom_address_pink_ghost1),
	.q       (rom_q_pink_ghost1)
);

frighten_state_palette frighten_state_palette_pink (
	.index (rom_q_pink_ghost1),
	.red   (palette_red_pink_ghost1),
	.green (palette_green_pink_ghost1),
	.blue  (palette_blue_pink_ghost1)
);

frighten_state_rom frighten_state_rom_orange (
	.clock   (vga_clk),
	.address (rom_address_orange_ghost1),
	.q       (rom_q_orange_ghost1)
);

frighten_state_palette frighten_state_palette_orange (
	.index (rom_q_orange_ghost1),
	.red   (palette_red_orange_ghost1),
	.green (palette_green_orange_ghost1),
	.blue  (palette_blue_orange_ghost1)
);

frighten_state_rom frighten_state_rom_red (
	.clock   (vga_clk),
	.address (rom_address_red_ghost1),
	.q       (rom_q_red_ghost1)
);

frighten_state_palette frighten_state_palette_red (
	.index (rom_q_red_ghost1),
	.red   (palette_red_red_ghost1),
	.green (palette_green_red_ghost1),
	.blue  (palette_blue_red_ghost1)
);

frighten_state_rom frighten_state_rom_green (
	.clock   (vga_clk),
	.address (rom_address_green_ghost1),
	.q       (rom_q_green_ghost1)
);

frighten_state_palette frighten_state_palette_green (
	.index (rom_q_green_ghost1),
	.red   (palette_red_green_ghost1),
	.green (palette_green_green_ghost1),
	.blue  (palette_blue_green_ghost1)
);

frighten_state_rom frighten_state_rom_blue (
	.clock   (vga_clk),
	.address (rom_address_blue_ghost1),
	.q       (rom_q_blue_ghost1)
);

frighten_state_palette frighten_state_palette_blue (
	.index (rom_q_blue_ghost1),
	.red   (palette_red_blue_ghost1),
	.green (palette_green_blue_ghost1),
	.blue  (palette_blue_blue_ghost1)
);

PowerUp2_rom PowerUp2_rom (
	.clock   (vga_clk),
	.address (rom_address_powerup2),
	.q       (rom_q_powerup2)
);

PowerUp2_palette PowerUp2_palette (
	.index (rom_q_powerup2),
	.red   (palette_red_powerup2),
	.green (palette_green_powerup2),
	.blue  (palette_blue_powerup2)
);
endmodule
