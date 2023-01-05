/*
 * ECE385 Used Rishi's Tool to help build reading from a txt file
 */

module  frameRAM
(
		input [3:0] data_In,
		input [11:0] write_address, read_address1, read_address2, read_address3, read_address4, read_address5, read_address6, read_address7, read_address8,
		input we, Clk, Reset,

		output logic [3:0] data_Out1, data_Out2, data_Out3, data_Out4, data_Out5, data_Out6, data_Out7, data_Out8
);

logic [3:0] mem [0:1199];

initial
begin
	 $readmemh("AFinalProjectFiles/MapTXT.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out1<= mem[read_address1];
	data_Out2<= mem[read_address2];
	data_Out3<= mem[read_address3];
	data_Out4<= mem[read_address4];
	data_Out5<= mem[read_address5];
	data_Out6<= mem[read_address6];
	data_Out7<= mem[read_address7];
	data_Out8<= mem[read_address8];
end

endmodule

