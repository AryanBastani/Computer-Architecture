module register_file(clk, write_en, a1, a2, a3, write_data, rd1, rd2);
    input clk, write_en;
    input [4:0] a1, a2, a3;
    input [31:0] write_data;
    output [31:0] rd1, rd2;

    reg [31:0] xi [31:0];

    assign rd1 = xi[a1];
    assign rd2 = xi[a2];

    initial
	begin
		xi[0] = 0;
	end

    always@ (negedge clk )
	begin
	if (write_en)
		if(a3!=0)
            		xi[a3] = write_data;
	end
endmodule
