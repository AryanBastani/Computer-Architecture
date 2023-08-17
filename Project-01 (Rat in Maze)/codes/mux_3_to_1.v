module mux_3_to_1 (i0, i1, i2, sel, y);
	input [3:0] i0, i1, i2;
	input [1:0]sel;
	output [3:0] y;
	assign y = (sel==2'b00)? i0 : (sel==2'b01)? i1: i2;
endmodule
