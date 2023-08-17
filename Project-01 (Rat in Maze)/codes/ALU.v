`define PLUS 1'b0
`define MINUS 1'b1
module my_alu(plus_minus, A, Res, Cout);
	input plus_minus;
	input [3:0] A;
	output Cout;
	output [3:0] Res;
	reg [3:0] Res;
	reg Cout;
	always @(plus_minus or A)
	case(plus_minus)
		 `PLUS : {Cout, Res} = A+ 4'b0001;
		 `MINUS : 
			begin
				Res = A- 4'b0001;
				Cout = 1'b0;
			end
		default : {Cout, Res} = 5'b00000;
	endcase
endmodule
