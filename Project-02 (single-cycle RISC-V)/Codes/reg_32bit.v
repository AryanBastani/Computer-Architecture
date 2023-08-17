module reg_32bit(clk, rst, ld, in, out);
    input clk, ld, rst;
    input [31:0] in;
    output reg[31:0] out;
    always@ (posedge clk or posedge rst)
        begin
            if(rst)
	     	out = 0;
            else if(ld)
                out = in;
            else
                out = out;
        end
endmodule
