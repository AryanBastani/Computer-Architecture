module M_Memory(X, Y, Din, rst_map, RD, WR, CLK, Dout);
	input Din, RD, WR, CLK, rst_map;
	input [3:0] X, Y;
	output Dout;
	reg [0:15] mem [0:15];
	reg Dout;
	reg [0:15] row;
	wire [0:15] first_row;

	initial
	begin
		$readmemh("maze_1.dat", mem);
	end

	always @(posedge CLK, posedge RD, posedge rst_map)	
	begin
		row = mem[X];	
		if(rst_map)
			$readmemh("maze_1.dat", mem);
		else if(RD)
			begin
			if ({X, Y} == 8'b00000000)
				Dout = 1'b1;
			else
				Dout = row[Y];
			end
		else if(WR)
			begin
			row[Y] = Din;
			mem[X] = row;
			end
	end
endmodule
	