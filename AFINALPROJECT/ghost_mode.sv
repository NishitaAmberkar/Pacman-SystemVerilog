module ghost_mode(
                //input [1:0] ghost_mode, delay, 
                input frame_clk, vga_clk, we, Reset, 
					 input logic [2:0] prev_motion, 
					 input logic [3:0] rand_num,
                input logic [9:0] Ghost_X_Pos, Ghost_Y_Pos, Ball_X_Pos, Ball_Y_Pos,
                output logic [9:0] Ghost_X_Motion, Ghost_Y_Motion,
                output logic [2:0] last_motion,
					 output logic [1:0] ghost_mode
					 );


logic [11:0] ram_write_address, ram_read_address1, ram_read_address2, ram_read_address3, ram_read_address4, ram_read_address5, ram_read_address6, ram_read_address7, ram_read_address8;
logic [3:0] ram_data_In, ram_data_Out1, ram_data_Out2, ram_data_Out3, ram_data_Out4, ram_data_Out5, ram_data_Out6, ram_data_Out7, ram_data_Out8;
logic [9:0] pos_x1, pos_x2, pos_y1, pos_y2, squares_x, squares_y;

//
//always_ff @ (posedge vga_clk) begin
//	  Ghost_X_Motion <= 0;
//	  Ghost_Y_Motion <= 0;
//	  ram_read_address1<= ((Ghost_X_Pos-4)/16) + ((Ghost_Y_Pos-9)/16 * 40); // up
//	  ram_read_address5<= ((Ghost_X_Pos+4)/16) + ((Ghost_Y_Pos-9)/16 * 40);
//	  
//	  ram_read_address2<= ((Ghost_X_Pos+9)/16) + ((Ghost_Y_Pos-4)/16 * 40); //right 
//	  ram_read_address6<= ((Ghost_X_Pos+9)/16) + ((Ghost_Y_Pos+4)/16 * 40);
//	  
//	  ram_read_address3<= ((Ghost_X_Pos-4)/16) + ((Ghost_Y_Pos+9)/16 * 40);  //down
//	  ram_read_address7<= ((Ghost_X_Pos+4)/16) + ((Ghost_Y_Pos+9)/16 * 40);
//	  
//	  ram_read_address4<= ((Ghost_X_Pos-9)/16) + ((Ghost_Y_Pos-4)/16 * 40); //left
//	  ram_read_address8<= ((Ghost_X_Pos-9)/16) + ((Ghost_Y_Pos+4)/16 * 40);
//	  
//	  pos_x1 = Ghost_X_Pos-Ball_X_Pos; // left
//	  pos_x2 = Ball_X_Pos - Ghost_X_Pos; //right
//	  pos_y1 = Ghost_Y_Pos-Ball_Y_Pos; //up
//	  pos_y2 = Ball_Y_Pos - Ghost_Y_Pos; //down
//	  
//	  squares_x = pos_x1 * pos_x1;
//	  squares_y = pos_y1 * pos_y1;
//	  
//		  if(squares_x <= squares_y) begin
//				if(last_motion == 3'b000 && (ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
//						Ghost_X_Motion <= 0;
//						Ghost_Y_Motion <= -1; //up
//						last_motion <= 3'b000;
//						end
//					else if(last_motion == 3'b001 && (ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1) ) begin
//						Ghost_X_Motion <= 1; //right
//						Ghost_Y_Motion <= 0;
//						last_motion <= 3'b001;
//						end
//
//					else if(last_motion == 3'b010 &&(ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1) ) begin
//						Ghost_X_Motion <= 0; //down
//						Ghost_Y_Motion <= 1;
//						last_motion <= 3'b010; 
//						end
//					else if (last_motion == 3'b011 &&(ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1) ) begin
//						Ghost_X_Motion <= -1; //left
//						Ghost_Y_Motion <= 0;
//						last_motion <= 3'b011;
//						end
//				 else if(pos_y1<=pos_y2 && (ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
//					Ghost_X_Motion <= 0;
//					Ghost_Y_Motion <= -1; //up
//					last_motion <= 3'b000;
//					end
//				else if(pos_y1>pos_y2 && (ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1)) begin
//					Ghost_X_Motion <= 0; //down
//					Ghost_Y_Motion <= 1;
//					last_motion <= 3'b010; 
//					end
//				else if(pos_x1<=pos_x2 && (ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1)) begin
//					Ghost_X_Motion <= -1; //left
//					Ghost_Y_Motion <= 0;
//					last_motion <= 3'b011;
//				end
//				else if(pos_x1>pos_x2 && (ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1)) begin
//					Ghost_X_Motion <= 1; //right
//						Ghost_Y_Motion <= 0;
//						last_motion <= 3'b001;
//						end
//				else begin
//						if((ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1)) begin
//							Ghost_X_Motion <= 1; //right
//							Ghost_Y_Motion <= 0;
//							last_motion <= 3'b001;
//							end
//						else if((ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1)) begin
//							Ghost_X_Motion <= -1; //left
//							Ghost_Y_Motion <= 0;
//							last_motion <= 3'b011;
//							end
//						else if((ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
//								Ghost_X_Motion <= 0;
//								Ghost_Y_Motion <= -1; //up
//								last_motion <= 3'b000;
//								end
//						else if((ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1)) begin
//								Ghost_X_Motion <= 0; //down
//								Ghost_Y_Motion <= 1;
//								last_motion <= 3'b010; 
//								end
//						else 
//							begin
//								Ghost_X_Motion <= 0; 
//								Ghost_Y_Motion <= 0;
//							end
//					end
//				end
//
//				else begin
//					if(last_motion == 3'b000 && (ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
//						Ghost_X_Motion <= 0;
//						Ghost_Y_Motion <= -1; //up
//						last_motion <= 3'b000;
//						end
//					else if(last_motion == 3'b001 && (ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1) ) begin
//						Ghost_X_Motion <= 1; //right
//						Ghost_Y_Motion <= 0;
//						last_motion <= 3'b001;
//						end
//
//					else if(last_motion == 3'b010 &&(ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1) ) begin
//						Ghost_X_Motion <= 0; //down
//						Ghost_Y_Motion <= 1;
//						last_motion <= 3'b010; 
//						end
//					else if (last_motion == 3'b011 &&(ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1) ) begin
//						Ghost_X_Motion <= -1; //left
//						Ghost_Y_Motion <= 0;
//						last_motion <= 3'b011;
//						end
//					else if(pos_x1<=pos_x2 && (ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1)) begin
//						Ghost_X_Motion <= -1; //left
//						Ghost_Y_Motion <= 0;
//						last_motion <= 3'b011;
//					end
//					else if(pos_x1>pos_x2 && (ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1)) begin
//						Ghost_X_Motion <= 1; //right
//							Ghost_Y_Motion <= 0;
//							last_motion <= 3'b001;
//							end
//					else if(pos_y1<=pos_y2 && (ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
//						Ghost_X_Motion <= 0;
//						Ghost_Y_Motion <= -1; //up
//						last_motion <= 3'b000;
//						end
//					else if(pos_y1<pos_y2 && (ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1)) begin
//						Ghost_X_Motion <= 0; //down
//						Ghost_Y_Motion <= 1;
//						last_motion <= 3'b010; 
//						end
//					else begin
//						if((ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1)) begin
//							Ghost_X_Motion <= 1; //right
//							Ghost_Y_Motion <= 0;
//							last_motion <= 3'b001;
//							end
//						else if((ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1)) begin
//							Ghost_X_Motion <= -1; //left
//							Ghost_Y_Motion <= 0;
//							last_motion <= 3'b011;
//							end
//						else if((ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
//								Ghost_X_Motion <= 0;
//								Ghost_Y_Motion <= -1; //up
//								last_motion <= 3'b000;
//								end
//						else if((ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1)) begin
//								Ghost_X_Motion <= 0; //down
//								Ghost_Y_Motion <= 1;
//								last_motion <= 3'b010; 
//								end
//						else 
//							begin
//								Ghost_X_Motion <= 0; 
//								Ghost_Y_Motion <= 0;
//							end
//					end
//				end
		


logic [9:0] max_counter = 200;
logic [9:0] counter_ghost = 0;
logic ghost_scatter = 1;


	always_ff @ (posedge Reset or posedge frame_clk)
	begin 
		 if(Reset) begin 
			 counter_ghost <= 0;
			 ghost_mode <= 2'b01;
		 end
		 else 
		 begin
			 if (counter_ghost < max_counter)
				 begin
					ghost_mode <= 2'b00;
				 end
			 else
				 begin
					ghost_mode <= 2'b01;
				 end
			counter_ghost <= counter_ghost + 1;
		 end
	end

	always_ff @ (posedge vga_clk) begin
	  Ghost_X_Motion <= 0;
	  Ghost_Y_Motion <= 0;
	  ram_read_address1<= ((Ghost_X_Pos-4)/16) + ((Ghost_Y_Pos-9)/16 * 40); // up
	  ram_read_address5<= ((Ghost_X_Pos+4)/16) + ((Ghost_Y_Pos-9)/16 * 40);
	  
	  ram_read_address2<= ((Ghost_X_Pos+9)/16) + ((Ghost_Y_Pos-4)/16 * 40); //right 
	  ram_read_address6<= ((Ghost_X_Pos+9)/16) + ((Ghost_Y_Pos+4)/16 * 40);
	  
	  ram_read_address3<= ((Ghost_X_Pos-4)/16) + ((Ghost_Y_Pos+9)/16 * 40);  //down
	  ram_read_address7<= ((Ghost_X_Pos+4)/16) + ((Ghost_Y_Pos+9)/16 * 40);
	  
	  ram_read_address4<= ((Ghost_X_Pos-9)/16) + ((Ghost_Y_Pos-4)/16 * 40); //left
	  ram_read_address8<= ((Ghost_X_Pos-9)/16) + ((Ghost_Y_Pos+4)/16 * 40);
	  
	  case(ghost_mode)
	  2'b00:
		begin
			//Scatter Mode
			if(prev_motion == 3'b000 && ram_data_Out1!=4'h1) begin
				Ghost_X_Motion <= 0;
				Ghost_Y_Motion <= -1; //up
				last_motion <= 3'b000;
			end
			else if(prev_motion == 3'b001 && ram_data_Out2!=4'h1) begin
				Ghost_X_Motion <= 1; //right
				Ghost_Y_Motion <= 0;
				last_motion <= 3'b001;
			end
			else if(prev_motion == 3'b010 && ram_data_Out3!=4'h1 ) begin
				Ghost_X_Motion <= 0; //down
				Ghost_Y_Motion <= 1;
				last_motion <= 3'b010 ;
			end
			else if (prev_motion == 3'b011 && ram_data_Out4 != 4'h1) begin
				Ghost_X_Motion <= -1; //left
				Ghost_Y_Motion <= 0;
				last_motion <= 3'b011;
			end
			
			//random
			else if(ram_data_Out1!=4'h1 && (rand_num % 4) == 4'b00 ) begin
				Ghost_X_Motion <= 0;
				Ghost_Y_Motion <= -1; //up
				last_motion <= 3'b000;
			end
			else if(ram_data_Out2!=4'h1 && (rand_num % 4) == 4'b01) begin
				Ghost_X_Motion <= 1; //right
				Ghost_Y_Motion <= 0;
				last_motion <= 3'b001;
				end
			else if(ram_data_Out3!=4'h1 && (rand_num % 4) == 4'b10 ) begin
				Ghost_X_Motion <= 0; //down
				Ghost_Y_Motion <= 1;
				last_motion <= 3'b010;
				end
			else if(ram_data_Out4 != 4'h1 && (rand_num % 4) == 4'b11) begin
				Ghost_X_Motion <= -1; //left
				Ghost_Y_Motion <= 0;
				last_motion <= 3'b011;
				end
				else begin
					Ghost_X_Motion <= 0;
					Ghost_Y_Motion <= 0;
					end
		end
	  2'b01:
			begin
			  pos_x1 = Ghost_X_Pos-Ball_X_Pos; // left
			  pos_x2 = Ball_X_Pos - Ghost_X_Pos; //right
			  pos_y1 = Ghost_Y_Pos-Ball_Y_Pos; //up
			  pos_y2 = Ball_Y_Pos - Ghost_Y_Pos; //down
			  
			  squares_x = pos_x1 * pos_x1;
			  squares_y = pos_y1 * pos_y1;
			  
				  if(squares_x <= squares_y) begin
						if(last_motion == 3'b000 && (ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
								Ghost_X_Motion <= 0;
								Ghost_Y_Motion <= -1; //up
								last_motion <= 3'b000;
								end
							else if(last_motion == 3'b001 && (ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1) ) begin
								Ghost_X_Motion <= 1; //right
								Ghost_Y_Motion <= 0;
								last_motion <= 3'b001;
								end

							else if(last_motion == 3'b010 &&(ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1) ) begin
								Ghost_X_Motion <= 0; //down
								Ghost_Y_Motion <= 1;
								last_motion <= 3'b010; 
								end
							else if (last_motion == 3'b011 &&(ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1) ) begin
								Ghost_X_Motion <= -1; //left
								Ghost_Y_Motion <= 0;
								last_motion <= 3'b011;
								end
						  else if(pos_y1<=pos_y2 && (ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
							Ghost_X_Motion <= 0;
							Ghost_Y_Motion <= -1; //up
							last_motion <= 3'b000;
							end
						else if(pos_y1>pos_y2 && (ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1)) begin
							Ghost_X_Motion <= 0; //down
							Ghost_Y_Motion <= 1;
							last_motion <= 3'b010; 
							end
						else if(pos_x1<=pos_x2 && (ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1)) begin
							Ghost_X_Motion <= -1; //left
							Ghost_Y_Motion <= 0;
							last_motion <= 3'b011;
						end
						else if(pos_x1>pos_x2 && (ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1)) begin
							Ghost_X_Motion <= 1; //right
								Ghost_Y_Motion <= 0;
								last_motion <= 3'b001;
								end
						else
						begin
								if((ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1)) begin
									Ghost_X_Motion <= 1; //right
									Ghost_Y_Motion <= 0;
									last_motion <= 3'b001;
									end
								else if((ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1)) begin
									Ghost_X_Motion <= -1; //left
									Ghost_Y_Motion <= 0;
									last_motion <= 3'b011;
									end
								else if((ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
										Ghost_X_Motion <= 0;
										Ghost_Y_Motion <= -1; //up
										last_motion <= 3'b000;
										end
								else if((ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1)) begin
										Ghost_X_Motion <= 0; //down
										Ghost_Y_Motion <= 1;
										last_motion <= 3'b010; 
										end
								else 
									begin
										Ghost_X_Motion <= 0; 
										Ghost_Y_Motion <= 0;
									end
							end
						end

						else begin
							if(last_motion == 3'b000 && (ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
								Ghost_X_Motion <= 0;
								Ghost_Y_Motion <= -1; //up
								last_motion <= 3'b000;
								end
							else if(last_motion == 3'b001 && (ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1) ) begin
								Ghost_X_Motion <= 1; //right
								Ghost_Y_Motion <= 0;
								last_motion <= 3'b001;
								end

							else if(last_motion == 3'b010 &&(ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1) ) begin
								Ghost_X_Motion <= 0; //down
								Ghost_Y_Motion <= 1;
								last_motion <= 3'b010; 
								end
							else if (last_motion == 3'b011 &&(ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1) ) begin
								Ghost_X_Motion <= -1; //left
								Ghost_Y_Motion <= 0;
								last_motion <= 3'b011;
								end
							else if(pos_x1<=pos_x2 && (ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1)) begin
								Ghost_X_Motion <= -1; //left
								Ghost_Y_Motion <= 0;
								last_motion <= 3'b011;
							end
							else if(pos_x1>pos_x2 && (ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1)) begin
								Ghost_X_Motion <= 1; //right
									Ghost_Y_Motion <= 0;
									last_motion <= 3'b001;
									end
							else if(pos_y1<=pos_y2 && (ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
								Ghost_X_Motion <= 0;
								Ghost_Y_Motion <= -1; //up
								last_motion <= 3'b000;
								end
							else if(pos_y1<pos_y2 && (ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1)) begin
								Ghost_X_Motion <= 0; //down
								Ghost_Y_Motion <= 1;
								last_motion <= 3'b010; 
								end
							else
							begin
								if((ram_data_Out2 != 4'h1) && (ram_data_Out6 != 4'h1)) begin
									Ghost_X_Motion <= 1; //right
									Ghost_Y_Motion <= 0;
									last_motion <= 3'b001;
									end
								else if((ram_data_Out4 != 4'h1) && (ram_data_Out8 != 4'h1)) begin
									Ghost_X_Motion <= -1; //left
									Ghost_Y_Motion <= 0;
									last_motion <= 3'b011;
									end
								else if((ram_data_Out1 != 4'h1) && (ram_data_Out5 != 4'h1) ) begin
										Ghost_X_Motion <= 0;
										Ghost_Y_Motion <= -1; //up
										last_motion <= 3'b000;
										end
								else if((ram_data_Out3 != 4'h1) && (ram_data_Out7 != 4'h1)) begin
										Ghost_X_Motion <= 0; //down
										Ghost_Y_Motion <= 1;
										last_motion <= 3'b010; 
										end
								else 
									begin
										Ghost_X_Motion <= 0; 
										Ghost_Y_Motion <= 0;
									end
							end
						end
						end
			default:
			begin
				Ghost_X_Motion <= 0; 
				Ghost_Y_Motion <= 0;
			end
			
		endcase

end


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
    .we (1'b0), 
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

endmodule