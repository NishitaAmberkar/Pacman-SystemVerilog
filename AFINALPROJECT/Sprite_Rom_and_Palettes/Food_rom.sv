module Food_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/Food.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module red_ghost_left_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/red_ghost_left.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule


module orange_ghost_left_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/orange_ghost_left.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule


module cherries_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/cherries.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pink_ghost_left_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pink_ghost_left.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule


module blue_ghost_left_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/blue_ghost_left.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule


module PowerUp_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/PowerUp.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module lives_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/lives.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule


module frighten_state_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/frighten_state.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_up_3_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_up_3.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_up_2_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_up_2.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_up_1_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_up_1.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_right_3_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_right_3.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_right_2_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_right_2.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_right_1_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_right_1.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_left_3_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_left_3.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_left_2_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_left_2.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_left_1_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_left_1.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_down_3_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_down_3.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_down_2_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_down_2.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

module pacman_down_1_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:255] /* synthesis ram_init_file = "./AFinalProjectFiles/pacman_down_1.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule

