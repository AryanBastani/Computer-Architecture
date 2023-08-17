module TB();
    reg clk = 1, rst=1;
	
    cpu my_cpu(clk, rst);
    
    always
        #5 clk = ~clk;
    initial begin
	#1 rst = 0;
        #10000 $stop;
    end
endmodule
