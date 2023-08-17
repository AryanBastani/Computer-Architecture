module reg_gp4_dp(clk, rst, alu_result_m, read_data_m,
    rd_m, pc_plus4_m, ext_imm_m, alu_result_w, read_data_w,
    rd_w, pc_plus4_w, ext_imm_w);
    input clk, rst;
    input [4:0] rd_m;
    input [31:0] alu_result_m, read_data_m, pc_plus4_m, ext_imm_m;
    output [4:0] rd_w;
    output [31:0] alu_result_w, read_data_w, pc_plus4_w, ext_imm_w;

    reg_5bit rd(clk, rst, 1'b0, 1'b1, rd_m, rd_w);

    reg_32bit alu_result(clk, rst, 1'b0, 1'b1, alu_result_m, alu_result_w);
    reg_32bit read_data(clk, rst, 1'b0, 1'b1, read_data_m, read_data_w);
    reg_32bit pc_plus4(clk, rst, 1'b0, 1'b1, pc_plus4_m, pc_plus4_w);
    reg_32bit ext_imm(clk, rst, 1'b0, 1'b1, ext_imm_m, ext_imm_w);

endmodule