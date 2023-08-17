module my_incrementer(A, Res, Cout);
	input [1:0] A;
	output Cout;
	output [1:0] Res;
	reg [1:0] Res;
	reg Cout;
	always@ (A)
	begin
		{Cout, Res} = A+ 1;
	end
endmodule
