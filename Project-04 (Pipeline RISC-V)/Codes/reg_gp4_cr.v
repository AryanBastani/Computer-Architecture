module reg_gp4_cr(clk, rst, reg_write_m, result_src_m,
    reg_write_w, result_src_w);
    input clk, rst, reg_write_m;
    input [1:0] result_src_m;
    output reg_write_w;
    output [1:0] result_src_w;

    reg_1bit reg_write(clk, rst, 1'b0, 1'b1, reg_write_m, reg_write_w);

    reg_2bit result_src(clk, rst, 1'b0, 1'b1, result_src_m, result_src_w);

endmodule