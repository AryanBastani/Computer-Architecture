`define S0 5'b00000
`define S1 5'b00001
`define S2 5'b00010
`define S3 5'b00011
`define S4 5'b00100
`define S5 5'b00101
`define S6 5'b00110
`define S7 5'b00111
`define S8 5'b01000
`define S9 5'b01001
`define S10 5'b01010
`define S11 5'b01011
`define S12 5'b01100
`define S13 5'b01101
`define S14 5'b01110
`define S15 5'b01111
`define S16 5'b10000
`define S17 5'b10001
`define S18 5'b10010
`define S19 5'b10011
`define S20 5'b10100
`define S21 5'b10101
`define S22 5'b10110
`define S23 5'b10111
module Maze_controller(run, start, clk, rst, xy_select, mem_dout, arrive_final, wall,
		dir_ends, stack_empty, ld_x, ld_y, ld_n_x, ld_n_y, mem_wr, mem_rd,
		rst_x, rst_y, rst_n_x, rst_n_y, rst_dir, ld_dir, dir_select, fail,
		done, mem_din, stack_push, stack_pop, rst_map, mem_select, queue_push,
		queue_pop, queue_empty);

	input start, clk, rst, xy_select, mem_dout, run,
		arrive_final, wall, dir_ends, stack_empty, queue_empty;
	output ld_x, ld_y, ld_n_x, ld_n_y, mem_wr, mem_rd, rst_x, rst_y, rst_n_x, rst_map,queue_push, queue_pop,
		rst_n_y, rst_dir, ld_dir, fail, done, mem_din, stack_push, mem_select, stack_pop;
	output [1:0] dir_select;
	reg ld_x, ld_y, ld_n_x, ld_n_y, mem_wr, mem_rd, rst_x, rst_y, rst_n_x, rst_n_y, rst_map,
		rst_dir, ld_dir, fail, done, mem_din, stack_push, stack_pop, mem_select,queue_push, queue_pop;
	reg [1:0] dir_select;
	reg [4:0] ps, ns;
	always @(posedge clk, posedge rst)
		if(rst)
			ps = `S0;
		else
			ps = ns;

	always @(ps or start or xy_select or mem_dout or wall or
 			dir_ends or stack_empty or arrive_final)
	begin
		case(ps)
			`S0: ns = start? `S1 : `S0;
			`S1: ns = `S2;
			`S2: ns = arrive_final? `S21 : xy_select? `S8 : `S9;
			`S3: ns = `S4;
			`S4: ns = `S15;
			`S5: ns = `S7;
			`S6: ns = `S7;
			`S7: ns = `S2;
			`S8: ns = `S10;
			`S9: ns = `S10;
			`S10: ns = (wall || mem_dout)? dir_ends? stack_empty? `S14 : `S20 : `S12 : `S13;
			`S11: ns =  run? `S23 : `S11;
			`S12: ns = `S2;
			`S13: ns = xy_select? `S5 : `S6;
			`S14: ns = `S14;
			`S15: ns = xy_select? `S16 : `S17;
			`S16: ns = `S18;
			`S17: ns = `S18;
			`S18: ns = `S19;
			`S19: ns = dir_ends? stack_empty? `S14 : `S20 : `S12;
			`S20: ns = `S3;
			`S21: ns = `S22;
			`S22: ns = stack_empty? `S11 : `S21;
			`S23: ns = `S23;
			default : ns = `S0;
		endcase
	end

	always@(ps)
	begin
		{ld_x, ld_y, ld_n_x, ld_n_y, mem_wr, mem_rd, rst_x, rst_y,
			rst_n_x, rst_n_y, rst_dir, ld_dir, dir_select, fail,
			done, mem_din, stack_push, stack_pop} = 19'b0000000000000000000; 
		case(ps)
			`S0: ;
			`S1: {rst_x, rst_y, rst_dir, rst_n_x, rst_n_y, rst_map} = 6'b111111;
			`S2: rst_map = 1'b0;
			`S3: {stack_pop, mem_wr} = 2'b11;
			`S4:  {ld_dir, dir_select} = 3'b100;
			`S5: ld_x = 1'b1;
			`S6: ld_y = 1'b1;
			`S7: {rst_dir, mem_wr, mem_din, mem_select} = 4'b1110;
			`S8: ld_n_x = 1'b1;
			`S9: ld_n_y = 1'b1;
			`S10: {mem_rd, mem_select} = 2'b11;
			`S11: {stack_pop, queue_push, done} = 3'b001;
			`S12: {ld_dir, dir_select} = 3'b101;
			`S13: stack_push = 1'b1;
			`S14: fail = 1'b1;
			`S15: ;
			`S16: ld_x = 1'b1;
			`S17: ld_y = 1'b1;
			`S18: {ld_dir, dir_select} = 3'b110;
			`S19: ;
			`S20: {mem_din, mem_select}  = 2'b00;
			`S21: {queue_push, stack_pop} = 2'b01;
			`S22: {queue_push, stack_pop} = 2'b10; 
			`S23: queue_pop = 1'b1;
		endcase
	end
endmodule	