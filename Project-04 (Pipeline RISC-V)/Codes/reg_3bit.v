module reg_3bit(clk, rst, clr, ld, in, out);
    input clk, ld, rst, clr;
    input [2:0] in;
    output reg[2:0] out;
    always@ (posedge clk or posedge rst)
        begin
            if(rst | clr)
	     	    out = 0;
            else if(ld)
                out = in;
            else
                out = out;
        end
endmodule