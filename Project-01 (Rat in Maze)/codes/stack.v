module my_stack(push, do_push, do_pop, empty, pop, clk);
	input do_push, do_pop, clk;
	input [1:0] push;
	output empty;
	output [1:0] pop;
	reg [0:1] stack [0:255], pop;
	reg [0:7] point = 8'b00000000;

	assign empty = point? 1'b0: 1'b1;

	always @(posedge clk)	
		if(do_push)
		begin
			stack[point] = push;
			point = point+ 8'b00000001;
		end
		else if(do_pop)
		begin
			point = point- 8'b00000001;
			pop = stack[point];
			stack[point] = 2'bxx;
		end
endmodule
