module Food_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hA, 4'h2};
end

endmodule

module red_ghost_left_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hE, 4'h3, 4'h2};
	palette[01] = {4'h0, 4'h0, 4'h0};
	palette[02] = {4'hF, 4'hF, 4'hF};
	palette[03] = {4'h2, 4'h2, 4'hF};
end

endmodule


module orange_ghost_left_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hA, 4'h2};
	palette[02] = {4'hF, 4'hF, 4'hF};
	palette[03] = {4'h2, 4'h2, 4'hF};
end

endmodule


module cherries_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'h0, 4'h0};
	palette[02] = {4'h0, 4'h0, 4'h0};
	palette[03] = {4'hF, 4'hE, 4'h8};
end

endmodule

module pink_ghost_left_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hE, 4'hB, 4'hF};
	palette[01] = {4'h0, 4'h0, 4'h0};
	palette[02] = {4'h2, 4'h2, 4'hF};
	palette[03] = {4'hF, 4'hF, 4'hF};
end

endmodule


module blue_ghost_left_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h7, 4'hF, 4'hF};
	palette[01] = {4'h0, 4'h0, 4'h0};
	palette[02] = {4'hF, 4'hF, 4'hF};
	palette[03] = {4'h2, 4'h2, 4'hF};
end

endmodule



module PowerUp_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'h7, 4'hE};
end

endmodule

module lives_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hF, 4'h0};
end

endmodule


module frighten_state_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hF, 4'hF};
	palette[02] = {4'h0, 4'h0, 4'hE};
	palette[03] = {4'h0, 4'h0, 4'h0};
end

endmodule

module pacman_down_1_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hF, 4'h0};
end

endmodule

module pacman_down_2_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hF, 4'hF, 4'h0};
	palette[01] = {4'h0, 4'h0, 4'h0};
end

endmodule

module pacman_down_3_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hF, 4'hF, 4'h0};
	palette[01] = {4'h0, 4'h0, 4'h0};
end

endmodule

module pacman_left_1_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hF, 4'h0};
end

endmodule

module pacman_left_2_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hF, 4'hF, 4'h0};
	palette[01] = {4'h0, 4'h0, 4'h0};
end

endmodule

module pacman_left_3_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hF, 4'h0};
end

endmodule

module pacman_right_1_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hF, 4'hF, 4'h0};
	palette[01] = {4'h0, 4'h0, 4'h0};
end

endmodule

module pacman_right_2_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hF, 4'hF, 4'h0};
	palette[01] = {4'h0, 4'h0, 4'h0};
end

endmodule

module pacman_right_3_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hF, 4'hF, 4'h0};
	palette[01] = {4'h0, 4'h0, 4'h0};
end

endmodule

module pacman_up_1_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hF, 4'h0};
end

endmodule

module pacman_up_2_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hF, 4'h0};
end

endmodule

module pacman_up_3_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hF, 4'hF, 4'h0};
end

endmodule
