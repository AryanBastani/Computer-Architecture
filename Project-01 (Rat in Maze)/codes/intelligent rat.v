module intelligent_rat(clk, rst, start, run, fail, dout, done, move,
		x, y, din, rd, wr, rst_map);
	input clk, rst, start, run, dout;
	output fail, done, din, rd, wr, rst_map;
	output [1:0] move;
	output [3:0] x, y;
	
	wire ld_x, ld_y, ld_dir, ld_n_x, ld_n_y, rst_x, rst_y, rst_dir, rst_n_x,
		rst_n_y, xy_select, dir_ends, arrive_final, wall, mem_select,
		stack_empty, stack_rd, stack_wr, q_wr, q_rd, q_empty;
	wire [1:0] dir_select;
		
Datapath data_path(.ld_x(ld_x), .ld_y(ld_y), .ld_dir(ld_dir), .ld_n_x(ld_n_x), .mem_select(mem_select),
 		.ld_n_y(ld_n_y), .rst_x(rst_x), .rst_y(rst_y), .rst_dir(rst_dir),
		.rst_n_x(rst_n_x), .clk(clk), .rst(rst), .stack_empty(stack_empty),
		.rst_n_y(rst_n_y), .dir_select(dir_select), .xy_select(xy_select),
		.dir_ends(dir_ends), .arrive_final(arrive_final), .wall(wall),
		.stack_rd(stack_rd), .stack_wr(stack_wr), .mem_x(x), .mem_y(y),
		.q_wr(q_wr), .q_rd(q_rd), .q_empty(q_empty), .move(move));
	
Maze_controller controller(.run(run), .start(start), .clk(clk), .rst(rst), .xy_select(xy_select),
			.mem_dout(dout), .arrive_final(arrive_final), .wall(wall),
			.dir_ends(dir_ends), .stack_empty(stack_empty), .ld_x(ld_x),
			.ld_y(ld_y), .ld_n_x(ld_n_x), .ld_n_y(ld_n_y), .mem_wr(wr),
			.mem_rd(rd), .rst_x(rst_x), .rst_y(rst_y), .rst_n_x(rst_n_x),
			.rst_n_y(rst_n_y), .rst_dir(rst_dir), .ld_dir(ld_dir),
			.dir_select(dir_select), .fail(fail), .done(done), .mem_din(din),
			.stack_push(stack_wr), .stack_pop(stack_rd), .rst_map(rst_map),
			.mem_select(mem_select),  .queue_push(q_wr), .queue_pop(q_rd), .queue_empty(q_empty));

endmodule
