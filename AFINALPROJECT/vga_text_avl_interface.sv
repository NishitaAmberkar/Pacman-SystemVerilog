/************************************************************************
Avalon-MM Interface VGA Text mode display
-- Lab 7.1 --
Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

-- Lab 7.2 --
Register Map:
0x000-0x4AF : VRAM, 80x30X2 (2X2400 byte, 2X600 word) raster order (first column then row)
0X4B0 - 0X7FF : unused
0x800 - 0x807 : Palette - 8 words of 2 colors each, for a 16 color palette

VRAM Format:
X->
[ 31  30-24][ 23-20][ 19-16 ][ 15][14-8][7-4][3-0]
[IV1][CODE1][FG_IDX1][BKG_IDX1][IV0][CODE0][FG_IDX0][BKG_IDX0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/
`define NUM_REGS 1200 //80*30*2 characters / 4 characters per register

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);

logic [31:0] LOCAL_REG       [`NUM_REGS]; // Registers
//put other local variables here

logic [12:0] out_reg; // 2400
logic [11:0] row_reg_char; // 600
logic  column_reg_char;
logic [10:0] fontrom_addr;
logic [7:0] fontrom_data;
logic [7:0] char_value;
logic [7:0] inv_value;
logic [3:0] FGD_IDX;
logic [3:0] BKD_IDX;
logic [9:0] drawxsig, drawysig;
logic [31:0] ram_b_output;
logic [31:0] control_reg [8];
logic pixel;
logic pixel_clk;
logic blank;
logic sync;

//Declare submodules..e.g. VGA controller, ROMS, etc
vga_controller myVGA (.Clk(CLK),
                     .Reset(RESET),      
                     .hs(hs),          
                     .vs(vs),           
                     .pixel_clk(pixel_clk),   
                     .blank(blank),            
                     .sync(sync),        
                     .DrawX(drawxsig), 
                     .DrawY(drawysig));    
font_rom myFontRom(.addr(fontrom_addr),
						 .data(fontrom_data));

// port a: Avalon Read and Write
// port b: Read from VGA
megnabb2_nda6_onchipmemory myOnChipMemory (.address_a(AVL_ADDR),
														.address_b(row_reg_char),
														.byteena_a(AVL_BYTE_EN),
														.clock(CLK),
														.data_a(AVL_WRITEDATA), 
														.data_b(),
														.rden_a(AVL_CS && AVL_READ),
														.rden_b(1'b1),
														.wren_a(AVL_CS && AVL_WRITE),
														.wren_b(1'b0),
														.q_a(AVL_READDATA),
														.q_b(ram_b_output));	

											
// ** Replaced by Onchip Memory - Don't Need											
//// Read and write from AVL interface to register block, note that READ waitstate = 1, so this should be in always_ff
//always_ff @(posedge CLK) begin
//
//	if (AVL_CS && AVL_WRITE)
//		begin
//		case(AVL_BYTE_EN)
//				4'b1111: LOCAL_REG[AVL_ADDR]<= AVL_WRITEDATA; 
//				4'b1100: LOCAL_REG[AVL_ADDR][31:16] <= AVL_WRITEDATA[31:16]; 
//				4'b0011: LOCAL_REG[AVL_ADDR][15:0]<= AVL_WRITEDATA[15:0]; 
//				4'b1000: LOCAL_REG[AVL_ADDR][31:24]<= AVL_WRITEDATA[31:24]; 
//				4'b0100: LOCAL_REG[AVL_ADDR][23:16]<= AVL_WRITEDATA[23:16]; 
//				4'b0010: LOCAL_REG[AVL_ADDR][15:8]<= AVL_WRITEDATA[15:8]; 
//				4'b0001: LOCAL_REG[AVL_ADDR][7:0]<= AVL_WRITEDATA[7:0]; 
//				default: ;
//			endcase
//		end
//end
//assign AVL_READDATA = (AVL_CS && AVL_READ) ? LOCAL_REG[AVL_ADDR]:{32{1'b0}};

	
//Vram access logic and drawing logic


//calculate address to access vRAM to work with indiviual bits

//Drawx[9:3] + DrawY[9:4] x 80 <- first 10 bits is reg_addr then the last 2 bits different characters 
assign out_reg = drawxsig[9:3] + (drawysig[9:4] * 80);
assign row_reg_char = out_reg[11:1];
assign column_reg_char = out_reg[0];

always_ff @(posedge CLK) begin
	if (AVL_ADDR[11] && AVL_WRITE && AVL_CS) 
		begin
			 control_reg[AVL_ADDR[2:0]] <= AVL_WRITEDATA; 
		end
end

//then parse the character through the vram
always_comb
	begin
		case(column_reg_char)
			1'b0: 
				begin
				char_value = ram_b_output[14:8];
				inv_value = ram_b_output[15];
				FGD_IDX = ram_b_output[7:4];
				BKD_IDX = ram_b_output[3:0];
				
				end
			1'b1: 
				begin
				char_value = ram_b_output[30:24];
				inv_value = ram_b_output[31];
				FGD_IDX = ram_b_output[23:20];
				BKD_IDX = ram_b_output[19:16];
				end
			default: ;
		endcase
	end



//character value x 16 +drawY[3:0] = gives address to input to font rom
assign fontrom_addr = char_value * 16 + drawysig[3:0];
//fontrom_data = .myFontRom(fontrom_addr); //get the fontrom_data
assign pixel = fontrom_data[7 - drawxsig[2:0]];


logic [3:0] FG_control_addr;
assign FG_control_addr = FGD_IDX/2;
logic [3:0] BG_control_addr;
assign BG_control_addr = BKD_IDX/2;
logic odd_FG;
assign odd_FG = FGD_IDX % 2;
logic odd_BG;
assign odd_BG  = FGD_IDX % 2;
//use 8-bit value to 7 - drawX[2:0] ^ INV

//check VGA blank signal, if low set RGB to 0, otherwise check above value if 1 draw foreground RGB, else draw background RGB from LOCAL_REG[600]
always_ff@(posedge pixel_clk) 
	begin
	if(~blank)
		begin
		red = 4'h0000;
		green = 4'h0000;
		blue = 4'h0000;
		end
	else if (pixel ^ inv_value) 
		begin
		if(odd_FG) begin
			red = control_reg[FG_control_addr][24:21];
			green =  control_reg[FG_control_addr][20:17];
			blue =  control_reg[FG_control_addr][16:13];
			end
		else begin
				red = control_reg[FG_control_addr][12:9];
				green =  control_reg[FG_control_addr][8:5];
				blue =  control_reg[FG_control_addr][4:1];
				end
		
		end
	else 
		begin
		if(odd_BG) begin
			red = control_reg[BG_control_addr][24:21];
			green =  control_reg[BG_control_addr][20:17];
			blue =  control_reg[BG_control_addr][16:13];
			end
		else begin
				red = control_reg[BG_control_addr][12:9];
				green =  control_reg[BG_control_addr][8:5];
				blue =  control_reg[BG_control_addr][4:1];
				end
		end
	end


//handle drawing (may either be combinational or sequential - or both).
		

endmodule
