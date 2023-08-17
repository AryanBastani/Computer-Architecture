module reg_gp3_dp(clk, rst, alu_result_e, write_data_e,
    rd_e, pc_plus4_e, ext_imm_e, alu_result_m, write_data_m,
    rd_m, pc_plus4_m, ext_imm_m);
    input clk, rst;
    input [4:0] rd_e;
    input [31:0] alu_result_e, write_data_e, pc_plus4_e, ext_imm_e;
    output [4:0] rd_m;
    output [31:0] alu_result_m, write_data_m, pc_plus4_m, ext_imm_m;

    reg_5bit rd(clk, rst, 1'b0, 1'b1, rd_e, rd_m);

    reg_32bit alu_result(clk, rst, 1'b0, 1'b1, alu_result_e, alu_result_m);
    reg_32bit write_data(clk, rst, 1'b0, 1'b1, write_data_e, write_data_m);
    reg_32bit pc_plus4(clk, rst, 1'b0, 1'b1, pc_plus4_e, pc_plus4_m);
    reg_32bit ext_imm(clk, rst, 1'b0, 1'b1, ext_imm_e, ext_imm_m);

endmodule