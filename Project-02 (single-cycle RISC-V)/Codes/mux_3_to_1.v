module mux_3_to_1 (i0, i1, i2, sel, y);
	input [31:0] i0, i1, i2;
	input [1:0] sel;
	output [31:0] y;
	assign y = (sel==2'b10) ? i2 : (sel==2'b01)? i1 : i0 ;
endmodule