module Datapath(ld_x, ld_y, ld_dir, ld_n_x, ld_n_y, rst_x, rst_y, rst_dir, rst_n_x, clk, rst, mem_select, stack_empty,
		rst_n_y, dir_select, xy_select, dir_ends, arrive_final, wall, stack_rd, stack_wr, mem_x, mem_y,
		 q_wr, q_rd, q_empty, move);

	input ld_x, ld_y, ld_dir, ld_n_x, ld_n_y, rst_x, clk, rst, mem_select,
		rst_y, rst_dir, rst_n_x, rst_n_y, stack_rd, stack_wr, q_wr, q_rd;
	input [1:0] dir_select;
	output xy_select, dir_ends, arrive_final, wall, stack_empty, q_empty;
	output [3:0] mem_x, mem_y;
	output [1:0] move; 

	wire [3:0] x_out, y_out, xy_mux_out, alu_out, n_x_out, n_y_out, mem_x0, mem_y0, mem_x1, mem_y1, n_mux_out;
	wire [1:0] dir_out, dir_mux_out, inc_out, pop;
	wire xy_mux_select, alu_fun, nor_n_x, nor_n_y, nor_dir, nor_x, nor_y,
		 inv_pop, alu_co, inc_co, and_o1, and_o2, and_o3, or1, q_pop,
			q_push;

	assign mem_x0 = x_out;
	assign mem_y0 = y_out; 

	my_4bit_reg x(.in(alu_out), .clk(clk), .rst(rst_x), .ld(ld_x), .out(x_out));
	my_4bit_reg y(.in(alu_out), .clk(clk), .rst(rst_y), .ld(ld_y), .out(y_out));
	my_4bit_reg next_x(.in(alu_out), .clk(clk), .rst(rst_n_x), .ld(ld_n_x), .out(n_x_out));
	my_4bit_reg next_y(.in(alu_out), .clk(clk), .rst(rst_n_y), .ld(ld_n_y), .out(n_y_out));

	my_2bit_reg direct(.in(dir_mux_out), .clk(clk), .rst(rst_dir), .ld(ld_dir), .out(dir_out));
	
    	my_alu xy_alu(.plus_minus(~dir_out[0]), .A(xy_mux_out), .Res(alu_out), .Cout(alu_co));

	my_incrementer dir_incre(.A(dir_out), .Res(inc_out), .Cout(inc_co));

	mux_2_to_1 xy_mux(.i0(y_out), .i1(x_out), .sel(xy_select), .y(xy_mux_out));
	mux_3_to_1 dir_mux(.i0(~pop), .i1(inc_out), .i2(~dir_out), .sel(dir_select), .y(dir_mux_out));
	mux_2_to_1 mem_x_mux0(.i0(x_out), .i1(alu_out), .sel(xy_select), .y(mem_x1));
	mux_2_to_1 mem_y_mux0(.i0(y_out), .i1(alu_out), .sel(~xy_select), .y(mem_y1));
	mux_2_to_1 mem_y_mux1(.i0(mem_x0), .i1(mem_x1), .sel(mem_select), .y(mem_y));
	mux_2_to_1 mem_x_mux1(.i0(mem_y0), .i1(mem_y1), .sel(mem_select), .y(mem_x));
	mux_2_to_1 next_mux(.i0(n_y_out), .i1(n_x_out), .sel(xy_select), .y(n_mux_out));

	xor xor1(xy_select, dir_out[1], dir_out[0]);


	and xy_and(arrive_final, x_out[0], x_out[1], x_out[2], x_out[3],
		y_out[0], y_out[1], y_out[2], y_out[3]);
	and dir_and(dir_ends, dir_out[0], dir_out[1]);
	nor wall_nor(w_nor_o, n_mux_out[3], n_mux_out[2], n_mux_out[1], n_mux_out[0]);
	and and1(and_o1, n_mux_out[3], n_mux_out[2], n_mux_out[1], n_mux_out[0]);
	and and2(and_o2, w_nor_o, dir_out[0]);
	and and3(and_o3, and_o1, ~dir_out[0]);
	
	or wall_or(wall, and_o2, and_o3);

	my_stack stack(.push(dir_out), .do_push(stack_wr), .do_pop(stack_rd), .empty(stack_empty), .pop(pop), .clk(clk));
	my_stack1 queue(.push(pop), .do_push(q_wr), .do_pop(q_rd), .empty(q_empty), .pop(move), .clk(clk));

endmodule

