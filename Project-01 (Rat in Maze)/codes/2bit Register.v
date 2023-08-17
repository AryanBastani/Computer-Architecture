module my_2bit_reg( in, clk, ld, rst, out);
	input clk, rst, ld;
	input [1:0] in;
	output [1:0] out;
	reg [1:0] out;
always @(posedge clk, posedge rst)
	if(rst)
		out = 2'b00;
	else if(ld)
		out = in;
endmodule
