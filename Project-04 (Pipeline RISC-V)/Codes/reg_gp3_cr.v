module reg_gp3_cr(clk, rst, reg_write_e, result_src_e, mem_write_e,
    lui_e, reg_write_m, result_src_m, mem_write_m, lui_m);
    input clk, rst, reg_write_e, mem_write_e, lui_e;
    input [1:0] result_src_e;
    output reg_write_m, mem_write_m, lui_m;
    output [1:0] result_src_m;

    reg_1bit reg_write(clk, rst, 1'b0, 1'b1, reg_write_e, reg_write_m);
    reg_1bit mem_write(clk, rst, 1'b0, 1'b1, mem_write_e, mem_write_m);
    reg_1bit lui(clk, rst, 1'b0, 1'b1, lui_e, lui_m);

    reg_2bit result_src(clk, rst, 1'b0, 1'b1, result_src_e, result_src_m);

endmodule