module  pacman_player ( input logic Reset, frame_clk, vga_clk, Clk, blank, run,
                        input logic [7:0] keycode_pacman, keycode_ghost,
                        input logic [9:0] DrawX, DrawY, 
								input logic [3:0] rand_num,
								output logic [9:0] LEDR,
                        output logic [3:0] red, green, blue
								//output logic run
							
);

    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
    logic [9:0] Pink_X_Pos, Pink_X_Motion, Pink_Y_Pos, Pink_Y_Motion;
    logic [9:0] Blue_X_Pos, Blue_X_Motion, Blue_Y_Pos, Blue_Y_Motion;
    logic [9:0] Orange_X_Pos, Orange_X_Motion, Orange_Y_Pos, Orange_Y_Motion;
	 logic [9:0] Green_X_Pos, Green_X_Motion, Green_Y_Pos, Green_Y_Motion;
    logic [9:0] Red_X_Pos, Red_X_Motion, Red_Y_Pos, Red_Y_Motion;
	 logic [11:0] pacman_score = 0;
	 logic [2:0] lives_remaining =3;
	 logic [1:0] state;
		
	logic [1:0] pink_ghost_mode_next, red_ghost_mode_next, blue_ghost_mode_next, orange_ghost_mode_next, green_ghost_mode_next;
	logic [2:0] green_prev_motion, green_last_motion, pink_prev_motion, pink_last_motion, red_prev_motion, red_last_motion, blue_prev_motion, blue_last_motion, orange_prev_motion, orange_last_motion;

    
	logic [11:0] ram_write_address, ram_read_address1, ram_read_address2, ram_read_address3, ram_read_address4, ram_read_address5, ram_read_address6, ram_read_address7, ram_read_address8;
	logic [3:0] ram_data_In, ram_data_Out1, ram_data_Out2, ram_data_Out3, ram_data_Out4, ram_data_Out5, ram_data_Out6, ram_data_Out7, ram_data_Out8;

	logic we;
	
    logic [6:0] HexDrivers_Out;

	//PacMan Starting Location
    parameter [9:0] Ball_X_Center=264;  
    parameter [9:0] Ball_Y_Center=264;  

    //Pink Ghost Starting Location
    parameter [9:0] Pink_X_Center=264;  
    parameter [9:0] Pink_Y_Center=216;  

    //Blue Ghost Starting Location
    parameter [9:0] Blue_X_Center=248;  
    parameter [9:0] Blue_Y_Center=208;  

    //Orange Ghost Starting Location
    parameter [9:0] Orange_X_Center=280;  
    parameter [9:0] Orange_Y_Center=208;  

    //Red Ghost Starting Location
    parameter [9:0] Red_X_Center=264;  
    parameter [9:0] Red_Y_Center=184;  
	 
	 //Green Ghost Starting Location
	 parameter [9:0] Green_X_Center=248;  
    parameter [9:0] Green_Y_Center=168;  

    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=527;     // Rightmost point on the X axis
    
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=432;     // Bottommost point on the Y axis

    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

	logic [1:0] pac_direction, pac_direction_curr;
	//logic[1:0] curr_delay_red, curr_delay_pink, curr_delay_orange, curr_delay_blue, curr_delay_red_next, curr_delay_pink_next, curr_delay_orange_next, curr_delay_blue_next;
	logic food_eaten, win, loss;
	logic [8:0] food_count_eaten;
	logic [8:0] max_food_count = 200;
   assign Ball_Size = 8; 
	
   always_ff @ (posedge Reset or posedge frame_clk ) begin
        ram_read_address1 = (DrawX/16) + ((DrawY/16) * 40);
	end
	
	
	always_ff @ (posedge frame_clk)
	begin
		//LEDR = powerup_active;
		
		//LEDR[7:6] = blue_ghost_mode_next;  
//		case(pink_ghost_mode_next)
//		2'b00:
//		begin
//			LEDR <= 10'd00;  
//		end
//		2'b01:
//		begin
//			LEDR <= 10'd01;  
//		end
//		default:
//		begin
//			LEDR <= 10'd10;  
//		end
//		endcase
	end
	
	
	logic pink_collision, red_collision, blue_collision, orange_collision, green_collision;
	always_ff @ (posedge vga_clk) begin
		if((Pink_X_Pos-Ball_X_Pos <=12 || Ball_X_Pos- Pink_X_Pos <= 12) && (Pink_Y_Pos-Ball_Y_Pos <=12 || Ball_Y_Pos-Pink_Y_Pos <=12) )
			begin 
			pink_collision <= 1;
			end 
		else 
			pink_collision <= 0;
		if((Red_X_Pos-Ball_X_Pos <=12 || Ball_X_Pos- Red_X_Pos <= 12) && (Red_Y_Pos-Ball_Y_Pos <=12 || Ball_Y_Pos-Red_Y_Pos <=12) )
			begin
			red_collision <= 1;
			end
		else 
			red_collision <= 0;
		if((Orange_X_Pos-Ball_X_Pos <=12 || Ball_X_Pos- Orange_X_Pos <= 12) && (Orange_Y_Pos-Ball_Y_Pos <=12 || Ball_Y_Pos-Orange_Y_Pos <=12) )
			begin
			orange_collision <= 1;
			end
		else 
			orange_collision <= 0;
		if((Blue_X_Pos-Ball_X_Pos <=12 || Ball_X_Pos- Blue_X_Pos <= 12) && (Blue_Y_Pos-Ball_Y_Pos <=12 || Ball_Y_Pos-Blue_Y_Pos <=12) )
			begin
			blue_collision <= 1;
			end
		else 
			blue_collision <= 0;
		if((Green_X_Pos-Ball_X_Pos <=12 || Ball_X_Pos- Green_X_Pos <= 12) && (Green_Y_Pos-Ball_Y_Pos <=12 || Ball_Y_Pos-Green_Y_Pos <=12) )
			begin
			green_collision <= 1;
			end
		else 
			green_collision <= 0;
	end


    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Pos <= Ball_X_Center;
				pac_direction <=2'b00;
				pink_prev_motion <= 3'b111;
				red_prev_motion <= 3'b111;
				blue_prev_motion <= 3'b111;
				orange_prev_motion <= 3'b111;
				green_prev_motion <= 3'b111;
		

            Pink_X_Pos <= Pink_X_Center;
            Pink_Y_Pos <= Pink_Y_Center;

            Blue_X_Pos <= Blue_X_Center;
            Blue_Y_Pos <= Blue_Y_Center;

            Orange_X_Pos <= Orange_X_Center;
            Orange_Y_Pos <= Orange_Y_Center;

            Red_X_Pos <= Red_X_Center;
            Red_Y_Pos <= Red_Y_Center;
				
				Green_X_Pos <= Green_X_Center;
            Green_Y_Pos <= Green_Y_Center;
				
				lives_remaining <= 3;
				
        end
		  else if(pink_collision || orange_collision || red_collision || blue_collision || green_collision) begin
			if (powerup_active_2 == 1) 
				begin
					if (pink_collision == 1) 
					begin
						Pink_X_Pos <= Pink_X_Center;
						Pink_Y_Pos <= Pink_Y_Center;
					end
					else if (orange_collision == 1) 
					begin
						Orange_X_Pos <= Orange_X_Center;
						Orange_Y_Pos <= Orange_Y_Center;
					end
					else if (red_collision == 1) 
					begin
						Red_X_Pos <= Red_X_Center;
						Red_Y_Pos <= Red_Y_Center;
					end
					else if (blue_collision == 1) 
					begin
						Blue_X_Pos <= Blue_X_Center;
						Blue_Y_Pos <= Blue_Y_Center;
					end
					else if (green_collision == 1) 
					begin
						Green_X_Pos <= Green_X_Center;
						Green_Y_Pos <= Green_Y_Center;
					end
				end
			else
			begin
					lives_remaining <= lives_remaining-1;
					Ball_Y_Pos <= Ball_Y_Center;
					Ball_X_Pos <= Ball_X_Center;
			end
		  end
		  else
		  begin

				  lives_remaining <= lives_remaining;
				  if(lives_remaining == 0) begin
					loss <= 1;
				  end 
				  else 
				  begin
					loss <= 0;
				  end 
				  
				  Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
              Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				  pac_direction <= pac_direction_curr;
				  
					blue_prev_motion <= blue_last_motion;
					
					pink_prev_motion <= pink_last_motion;
					
					orange_prev_motion <= orange_last_motion;
					
					red_prev_motion <= red_last_motion;
					
					green_prev_motion <= green_last_motion;
						
				  
              Pink_X_Pos <= (Pink_X_Pos + Pink_X_Motion*Powerup_freeze);
              Pink_Y_Pos <=  (Pink_Y_Pos + Pink_Y_Motion*Powerup_freeze);
				 
            
              Blue_X_Pos <= (Blue_X_Pos + Blue_X_Motion*Powerup_freeze);
              Blue_Y_Pos <= (Blue_Y_Pos + Blue_Y_Motion*Powerup_freeze);
				  

              Orange_X_Pos <= (Orange_X_Pos + Orange_X_Motion*Powerup_freeze);
              Orange_Y_Pos <= (Orange_Y_Pos + Orange_Y_Motion*Powerup_freeze);
				   

              Red_X_Pos <= (Red_X_Pos + Red_X_Motion*Powerup_freeze);
              Red_Y_Pos <= (Red_Y_Pos + Red_Y_Motion*Powerup_freeze);
				  
				  Green_X_Pos <= (Green_X_Pos + Green_X_Motion*Powerup_freeze);
              Green_Y_Pos <= (Green_Y_Pos + Green_Y_Motion*Powerup_freeze);
			end
	end
	
logic [8:0] max_counter = 350;
logic [8:0] counter_powerup = 0;
logic [0:0] Powerup_freeze;
logic powerup_active_1 = 0;
logic powerup_active_2 = 0;
logic powerup_on1, powerup_on2;


//When Power Ups Begin, Change the Motion
always_ff @ (posedge Reset or posedge frame_clk)
begin 
	 if(Reset) begin 
	 	 counter_powerup <= 0;
		 Powerup_freeze <= 1;
		 powerup_on1 <=0;
		 powerup_on2 <=0;
	 end

    else if (powerup_active_1 == 1) 
        begin 
            if (counter_powerup < max_counter)
            begin 
               Powerup_freeze <= 0;
					powerup_on1<=1;
            end
				else
				begin 
					Powerup_freeze <= 1;
					powerup_on1<=0;
				end
				counter_powerup <= counter_powerup + 1;
        end
	  else if (powerup_active_2 == 1) 
        begin 
				
				counter_powerup <= counter_powerup + 1;
				powerup_on2 <=1;
        end
	  else
			begin 
				powerup_on1<=0;
				Powerup_freeze <= 1;
				counter_powerup <= 0;
				powerup_on2 <=0;
			end
end

//Pacman
always_ff @ (posedge Reset or posedge frame_clk )
	begin
	if(Reset)begin
			pacman_score<=0;
			ram_data_In <= 4'h0;
			we <= 0;
			powerup_active_1 <= 0;
			powerup_active_2 <= 0;
			food_count_eaten <= 0;
			win <= 0;
		end
	else begin
		ram_data_In <= 4'h0;
		ram_read_address4 <= ((Ball_X_Pos)/16) + ((Ball_Y_Pos)/16 * 40);
		//powerup_active <= 0;
		we <= 0;
		if(ram_data_Out4==4'h2)
		begin
			ram_write_address <=  ((Ball_X_Pos)/16) + ((Ball_Y_Pos)/16 * 40);
			we <= 1;
			pacman_score <= pacman_score + 5;
			food_count_eaten <= food_count_eaten + 1;
		end
		if(ram_data_Out4==4'hb)
		begin
			ram_write_address <=  ((Ball_X_Pos)/16) + ((Ball_Y_Pos)/16 * 40);
			we <= 1;
			pacman_score <= pacman_score + 50;
			food_count_eaten <= food_count_eaten + 1;
		end
		
		
		if (food_count_eaten >= max_food_count) 
		begin
				win <= 1;
				Ball_X_Motion <= 0;
				Ball_Y_Motion <= 0;
		end
		
		if (ram_data_Out4 == 4'h7)
        begin
         ram_write_address <=  ((Ball_X_Pos)/16) + ((Ball_Y_Pos)/16 * 40);
			we <= 1;
			powerup_active_1 <= 1;
        end
		else if (ram_data_Out4 == 4'h5)
        begin
         ram_write_address <=  ((Ball_X_Pos)/16) + ((Ball_Y_Pos)/16 * 40);
			we <= 1;
			powerup_active_2 <= 1;
        end
		else if (counter_powerup >= max_counter) 
			begin
				powerup_active_1 <= 0;
				powerup_active_2 <= 0;
			end	

		
		    
		 case (keycode_pacman)
			8'h04 : begin
					pac_direction_curr <=  2'b00;
					ram_read_address2 <= ((Ball_X_Pos-9)/16) + ((Ball_Y_Pos-5)/16 * 40);
					ram_read_address3 <= ((Ball_X_Pos-9)/16) + ((Ball_Y_Pos+5)/16 * 40);
					
				  if(ram_data_Out2!=4'h1 && ram_data_Out3 !=4'h1)begin 
							Ball_X_Motion <= -1;//A
							Ball_Y_Motion <= 0;                                                                                                                                                                                                                                                                                                                                                                                                
							
					end 
					else begin
						Ball_X_Motion <= 0;
						Ball_Y_Motion <= 0;
					end
					end
					
					  
			8'h07 : begin
					pac_direction_curr <=  2'b01;
					ram_read_address2 <= ((Ball_X_Pos+9)/16) + ((Ball_Y_Pos-5)/16 * 40);
					ram_read_address3 <= ((Ball_X_Pos+9)/16) + ((Ball_Y_Pos+5)/16 * 40);
					

				  if(ram_data_Out2!=4'h1 && ram_data_Out3 !=4'h1)begin 
							Ball_X_Motion <= 1;//D
							Ball_Y_Motion <= 0;
						
					end 
					else begin
						Ball_X_Motion <= 0;
						Ball_Y_Motion <= 0;
					end
					end
					  
			8'h16 : begin
					pac_direction_curr <=  2'b10;
					ram_read_address2 <= ((Ball_X_Pos+5)/16) + ((Ball_Y_Pos+9)/16 * 40);
					ram_read_address3 <= ((Ball_X_Pos-5)/16) + ((Ball_Y_Pos+9)/16 * 40);
					
				   if(ram_data_Out2!=4'h1 && ram_data_Out3 !=4'h1)begin 
							Ball_X_Motion <= 0;//S
							Ball_Y_Motion <= 1;
					end 
					else begin
						Ball_X_Motion <= 0;
						Ball_Y_Motion <= 0;
					end
					end
					  
			8'h1A : begin
						pac_direction_curr <=  2'b11;
						ram_read_address2 <= ((Ball_X_Pos+5)/16) + ((Ball_Y_Pos-9)/16 * 40);
						ram_read_address3 <= ((Ball_X_Pos-5)/16) + ((Ball_Y_Pos-9)/16 * 40);
					
					  if(ram_data_Out2!=4'h1 && ram_data_Out3 !=4'h1)begin 
								Ball_X_Motion <= 0;//W
								Ball_Y_Motion <= -1;
						end 
						else begin
						Ball_X_Motion <= 0;
						Ball_Y_Motion <= 0;
						end	
					end

			default:
			begin	
						pac_direction_curr <= pac_direction_curr;
						Ball_X_Motion <= 0;
						Ball_Y_Motion <= 0;
						end
			endcase
			
			case (keycode_ghost)
				8'h52: begin //up
							ram_read_address5 <= ((Blue_X_Pos+5)/16) + ((Blue_Y_Pos-9)/16 * 40);
							ram_read_address6 <= ((Blue_X_Pos-5)/16) + ((Blue_Y_Pos-9)/16 * 40);
						
						  if(ram_data_Out5!=4'h1 && ram_data_Out6 !=4'h1)begin 
									Blue_X_Motion <= 0;
									Blue_Y_Motion <= -1;
							end 
							else begin
							Blue_X_Motion <= 0;
							Blue_Y_Motion <= 0;
							end	
						end	
					
				8'h51: begin //down
						ram_read_address5 <= ((Blue_X_Pos+5)/16) + ((Blue_Y_Pos+9)/16 * 40);
						ram_read_address6 <= ((Blue_X_Pos-5)/16) + ((Blue_Y_Pos+9)/16 * 40);
					
					  if(ram_data_Out5!=4'h1 && ram_data_Out6 !=4'h1)begin 
								Blue_X_Motion <= 0;
								Blue_Y_Motion <= 1;
						end 
						else begin
						Blue_X_Motion <= 0;
						Blue_Y_Motion <= 0;
						end	
					end	
						
				8'h50: begin //left
					ram_read_address5 <= ((Blue_X_Pos-9)/16) + ((Blue_Y_Pos+5)/16 * 40);
					ram_read_address6 <= ((Blue_X_Pos-9)/16) + ((Blue_Y_Pos-5)/16 * 40);
				
				  if(ram_data_Out5!=4'h1 && ram_data_Out6 !=4'h1)begin 
							Blue_X_Motion <= -1;
							Blue_Y_Motion <= 0;
					end 
					else begin
					Blue_X_Motion <= 0;
					Blue_Y_Motion <= 0;
					end	
				end	
				
				8'h4F: begin //right
					ram_read_address5 <= ((Blue_X_Pos+9)/16) + ((Blue_Y_Pos+5)/16 * 40);
					ram_read_address6 <= ((Blue_X_Pos+9)/16) + ((Blue_Y_Pos-5)/16 * 40);
				
				  if(ram_data_Out5!=4'h1 && ram_data_Out6 !=4'h1)begin 
							Blue_X_Motion <= 1;
							Blue_Y_Motion <= 0;
					end 
					else begin
					Blue_X_Motion <= 0;
					Blue_Y_Motion <= 0;
					end	
				end		
		
				default:
				begin	
						Blue_X_Motion <= 0;
						Blue_Y_Motion <= 0;
					end
				endcase
			end
	end
			


control_unit mycontrol_unit(.Clk(Clk), 
								.reset(Reset),
								.Run(run),
								 .Win(win),
								 .loss(loss),
								.state (state)   
			);
			
frameRAM my_frame_RAM
(
    .data_In	(ram_data_In),
    .write_address (ram_write_address), 
    .read_address1 (ram_read_address1),
    .read_address2 (ram_read_address2),
	 .read_address3 (ram_read_address3),
    .read_address4 (ram_read_address4),
	 .read_address5 (ram_read_address5),
    .read_address6 (ram_read_address6),
	 .read_address7 (ram_read_address7),
    .read_address8 (ram_read_address8),
    .we (we), 
    .Clk (vga_clk),
	 .Reset(Reset),
    .data_Out1 (ram_data_Out1),
    .data_Out2 (ram_data_Out2),
	 .data_Out3 (ram_data_Out3),
    .data_Out4 (ram_data_Out4),
	 .data_Out5 (ram_data_Out5),
    .data_Out6 (ram_data_Out6),
	 .data_Out7 (ram_data_Out7),
    .data_Out8 (ram_data_Out8)
);



PacManMap_mapper myPacmanMapper (
    .DrawX(DrawX),
    .DrawY(DrawY),
    .BallX(Ball_X_Pos), 
    .BallY(Ball_Y_Pos), 
    .Pink_BallX(Pink_X_Pos),
    .Pink_BallY(Pink_Y_Pos),
    .Blue_BallX(Blue_X_Pos),
    .Blue_BallY(Blue_Y_Pos),
    .Orange_BallX(Orange_X_Pos),
    .Orange_BallY(Orange_Y_Pos),
    .Red_BallX(Red_X_Pos),
    .Red_BallY(Red_Y_Pos),
	 .Green_BallX(Green_X_Pos),
    .Green_BallY(Green_Y_Pos),
    .Ball_size(Ball_Size),
    .vga_clk(vga_clk),
	 .frame_clk(frame_clk), 
    .blank(blank),
    .red(red),
    .green(green),
    .blue(blue),
    .ram_data_Out(ram_data_Out1),
	 .pac_direction(pac_direction),
    .pacman_score_next(pacman_score),
	 .lives_remaining(lives_remaining),
	 .win(win),
	 .state(state),
	 .powerup_on(powerup_on1),
	 .powerup_on2(powerup_on2)
);


ghost_mode myPink_Ghost(
	  .Reset(Reset),
     .frame_clk(frame_clk), 
	  .vga_clk(vga_clk), 
	  .we(we),
	  .prev_motion(pink_prev_motion), 
		.rand_num(rand_num+7),
      .Ghost_X_Pos(Pink_X_Pos), 
		.Ghost_Y_Pos(Pink_Y_Pos),
		.Ball_X_Pos(Ball_X_Pos), 
		.Ball_Y_Pos(Ball_Y_Pos), 
      .Ghost_X_Motion(Pink_X_Motion), 
		.Ghost_Y_Motion(Pink_Y_Motion),
      .last_motion(pink_last_motion),
		.ghost_mode(pink_ghost_mode_next)
);

ghost_mode myGreen_Ghost(
	  .Reset(Reset),
     .frame_clk(frame_clk), 
	  .vga_clk(vga_clk), 
	  .we(we),
	  .prev_motion(green_prev_motion), 
		.rand_num(rand_num+1),
      .Ghost_X_Pos(Green_X_Pos), 
		.Ghost_Y_Pos(Green_Y_Pos),
		.Ball_X_Pos(Ball_X_Pos), 
		.Ball_Y_Pos(Ball_Y_Pos), 
      .Ghost_X_Motion(Green_X_Motion), 
		.Ghost_Y_Motion(Green_Y_Motion),
      .last_motion(green_last_motion),
		.ghost_mode(green_ghost_mode_next)
);

ghost_mode myOrange_Ghost(
	.Reset(Reset),
     .frame_clk(frame_clk), 
	  .vga_clk(vga_clk), 
	  .we(we),
	  .prev_motion(orange_prev_motion), 
		.rand_num(rand_num+2),
      .Ghost_X_Pos(Orange_X_Pos), 
		.Ghost_Y_Pos(Orange_Y_Pos),
		.Ball_X_Pos(Ball_X_Pos), 
		.Ball_Y_Pos(Ball_Y_Pos), 
      .Ghost_X_Motion(Orange_X_Motion), 
		.Ghost_Y_Motion(Orange_Y_Motion),
      .last_motion(orange_last_motion),
		.ghost_mode(orange_ghost_mode_next)
);

ghost_mode myRed_Ghost(
	.Reset(Reset),
     .frame_clk(frame_clk), 
	  .vga_clk(vga_clk), 
	  .we(we),
	  .prev_motion(red_prev_motion), 
		.rand_num(rand_num),
      .Ghost_X_Pos(Red_X_Pos), 
		.Ghost_Y_Pos(Red_Y_Pos),
		.Ball_X_Pos(Ball_X_Pos), 
		.Ball_Y_Pos(Ball_Y_Pos), 
      .Ghost_X_Motion(Red_X_Motion), 
		.Ghost_Y_Motion(Red_Y_Motion),
      .last_motion(red_last_motion),
		.ghost_mode(red_ghost_mode_next)
);

endmodule
