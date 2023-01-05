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

module game_over_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hE, 4'h1, 4'h1};
end

endmodule



module WinScreen_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'hE, 4'hE, 4'hE};
	palette[02] = {4'hC, 4'hB, 4'h4};
	palette[03] = {4'h3, 4'h3, 4'h2};
end

endmodule


module StartScreen_palette (
	input logic [3:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [16];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h1, 4'h0, 4'h0};
	palette[01] = {4'hE, 4'hE, 4'h4};
	palette[02] = {4'h5, 4'h9, 4'hA};
	palette[03] = {4'h0, 4'h0, 4'h0};
	palette[04] = {4'h7, 4'h6, 4'h2};
	palette[05] = {4'hE, 4'hB, 4'hC};
	palette[06] = {4'hA, 4'h9, 4'h3};
	palette[07] = {4'hB, 4'h2, 4'h1};
	palette[08] = {4'h9, 4'h8, 4'hE};
	palette[09] = {4'hD, 4'hC, 4'h4};
	palette[10] = {4'h5, 4'h1, 4'h0};
	palette[11] = {4'h7, 4'hE, 4'hC};
	palette[12] = {4'h6, 4'h6, 4'hA};
	palette[13] = {4'h3, 4'h3, 4'h1};
	palette[14] = {4'h3, 4'h4, 4'h5};
	palette[15] = {4'h1, 4'h1, 4'h2};
end

endmodule


module green_ghost_left_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'hF, 4'hF, 4'hF};
	palette[01] = {4'h0, 4'h0, 4'h0};
	palette[02] = {4'h0, 4'hF, 4'h9};
	palette[03] = {4'h2, 4'h2, 4'hF};
end

endmodule

module freeze_pacman_palette (
	input logic [1:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [4];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'h6, 4'hC, 4'hF};
	palette[02] = {4'hF, 4'hF, 4'hF};
	palette[03] = {4'h2, 4'h2, 4'hF};
end

endmodule



module PowerUp2_palette (
	input logic [0:0] index,
	output logic [3:0] red, green, blue
);

logic [11:0] palette [2];
assign {red, green, blue} = palette[index];

always_comb begin
	palette[00] = {4'h0, 4'h0, 4'h0};
	palette[01] = {4'h9, 4'h0, 4'hF};
end

endmodule


