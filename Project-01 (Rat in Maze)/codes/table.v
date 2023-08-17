module game_table();
	reg clk, rst, start, run;
	wire fail, done;
	wire [1:0] move;

	maze_game game(.clk(clk), .rst(rst), .start(start), .run(run),
		 .fail(fail), .done(done), .move(move));
	
	initial
	begin
	start = 1'b0;
	clk = 1'b1;
	#30 start = 1'b1;
	#5000 run = 1'b1;
	#5000 $stop;
	end
	
	always
	begin
	#10 clk = ~clk;
	end
endmodule	
