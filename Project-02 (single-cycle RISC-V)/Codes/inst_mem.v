module inst_mem(in, out);
    input [31:0] in;
    output [31:0] out;
    reg [31:0] mem [15:0];
    initial
	begin
		$readmemh("inst.dat", mem);
	end
    assign out = mem[{2'b00, in[15:2]}];// out = mem [(in/4)]
    	// next_pc is (pc + 4) so we should divide the address by 4
endmodule