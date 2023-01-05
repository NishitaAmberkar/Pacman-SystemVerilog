module keycode_mapper (	input vga_clk,
						input [7:0] keycode_a, keycode_b,
						output [7:0] keycode_pacman, keycode_ghost);
					
					
always_ff @ (posedge vga_clk)
begin
		if (keycode_a == 8'h04 || keycode_a == 8'h07 || keycode_a == 8'h16 || keycode_a == 8'h1A)
		begin
			keycode_pacman <= keycode_a;
		end
		else if (keycode_b == 8'h04 || keycode_b == 8'h07 || keycode_b == 8'h16 || keycode_b == 8'h1A)
		begin
			keycode_pacman <= keycode_b;
		end
		else if (keycode_a == 8'h52 || keycode_a == 8'h51 || keycode_a == 8'h50 || keycode_a == 8'h4F)
		begin
			keycode_ghost <= keycode_a;
		end
		else if (keycode_b == 8'h52 || keycode_b == 8'h51 || keycode_b == 8'h50 || keycode_b == 8'h4F)
		begin
			keycode_ghost <= keycode_b;
		end		
end

endmodule