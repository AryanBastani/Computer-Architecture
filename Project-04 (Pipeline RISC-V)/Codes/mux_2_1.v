module mux_2_to_1 (i0, i1, sel, y);
	input [31:0] i0, i1;
	input sel;
	output [31:0] y;
	assign y = sel ? i1 : i0;
endmodule
