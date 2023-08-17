module reg_1bit(clk, rst, clr, ld, in, out);
    input clk, ld, rst, clr;
    input in;
    output reg out;
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