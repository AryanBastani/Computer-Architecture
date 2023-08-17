module mem_table();
	wire din, rst_map, rd, wr, clk, dout;
	wire [1:0] x, y;
	M_Memory mem(.X(x), .Y(y), .Din(din), .rst_map(rst_map), .RD(rd), .WR(wr), .CLK(clk), .Dout(dout));

	initial
	begin
	#10000 $finish;
	end
endmodule	
