module my_4bit_reg(in, clk, ld, rst, out);
	input clk, rst, ld;
	input [3:0] in;
	output [3:0] out;
	reg [3:0] out;
always @(posedge clk, posedge rst)
	if(rst)
		out = 4'b0000;
	else if(ld)
		out = in;
endmodule
