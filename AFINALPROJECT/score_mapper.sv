module score_mapper ( input [3:0]	score_bit,
							input [9:0] DrawY, DrawX,
							output pixel
							);

logic [3:0] char_value; 
logic [7:0] fontrom_addr;	
logic [15:0] fontrom_data;
	
always_comb 
    begin
	 char_value = 4'h0;
        case(score_bit) 
            4'h0: begin 
            char_value = 4'h0;
            end
				4'h1: begin
				char_value = 4'h1;
            end
				4'h2: begin
				char_value = 4'h2;
            end
				4'h3: begin
				char_value = 4'h3;
            end
				4'h4: begin
				char_value = 4'h4;
            end
				4'h5: begin
				char_value = 4'h5;
            end
				4'h6: begin
				char_value = 4'h6;
            end
				4'h7: begin
				char_value = 4'h7;
            end
				4'h8: begin
				char_value = 4'h8;
            end
				4'h9: begin
				char_value = 4'h9;
            end
				default: begin
				char_value = 4'h0;
				end
			endcase
    end
	 
assign fontrom_addr = score_bit*16 + DrawY[3:0];
assign pixel = fontrom_data[15 - DrawX[3:0]];

font_rom myFontRom(.addr(fontrom_addr),
		.data(fontrom_data)
		);
		
	
endmodule