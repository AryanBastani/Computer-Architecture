module maze_game(clk, rst, start, run, fail, done, move);
	input clk, rst, start, run;
	output fail, done;
	output [1:0] move;

	wire dout, din, rd, wr, rst_map;
	wire [3:0] x, y;

intelligent_rat rat(.clk(clk), .rst(rst), .start(start), .run(run),
		.fail(fail), .dout(dout), .done(done), .move(move),
		 .x(x), .y(y), .din(din), .rd(rd), .wr(wr), .rst_map(rst_map));

M_Memory memory(.X(x), .Y(y), .Din(din), .rst_map(rst_map), .RD(rd), .WR(wr), .CLK(clk), .Dout(dout));

endmodule