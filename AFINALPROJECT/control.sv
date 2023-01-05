module control_unit (   input logic Clk, 
									reset,
									Run,
								    Win,
								    loss,
				output logic [1:0]  state    
				);

	enum logic [2:0] {  Start, 
						Level, 
						GameOver, 
						YouWin
					 }   State, Next_state;   // Internal state logic
		
	always_ff @ (posedge Clk)
	begin
		if (reset)    
			State <= Start;
		else
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state

		// Assign next state
		unique case (State)
			Start : 
			begin
				if (Run) 
					Next_state = Level;
				else
					Next_state = Start;
			end
			Level : 
			begin
			   if (Win)
				Next_state = YouWin;
				else if (loss)
				Next_state = GameOver;
				else
				Next_state = Level;
			end
			GameOver : 
			begin
               if (reset) 
					Next_state = Start;   
					else
					Next_state = GameOver;	
			end
			YouWin : 
			begin
               if (reset) 
					Next_state = Start;
					else
					Next_state = YouWin;
			end
			default : Next_state = State;

		endcase
		
		// Assign control signals based on current state
		case (State)
			Start: 
				state = 2'b00;
			Level : 
                state = 2'b01;
			GameOver : 
                state = 2'b10;
			YouWin: 
                state = 2'b11;
			default : 
					 state = 2'b00;
		endcase
	end 

	
endmodule
