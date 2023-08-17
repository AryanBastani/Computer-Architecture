module deta_mem(clk, write_en, in, write_data, out);
    input clk, write_en;
    input [31:0] in, write_data;
    output [31:0] out;
    reg [31:0] mem [15:0];
    initial
	begin
		$readmemh("data.dat", mem);
	end
    assign out = mem[{2'b00, in[15:2]}]; // out = mem [(in/4)]
    	// next_pc is (pc + 4) so we should divide the address by 4
    always@ (posedge clk)
        if(write_en)
            mem[in[15:0]] = write_data;
endmodule