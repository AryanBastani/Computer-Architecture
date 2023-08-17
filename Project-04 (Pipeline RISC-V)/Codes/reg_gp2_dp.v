module reg_gp2_dp(clk, rst, clr, rd1_d, rd2_d, pc_d, rs1_d,
    rs2_d, rd_d, ext_imm_d, pc_plus4_d, rd1_e, rd2_e, pc_e,
    rs1_e, rs2_e, rd_e, ext_imm_e, pc_plus4_e);
    input clk, rst, clr;
    input [31:0] rd1_d, rd2_d, pc_d, ext_imm_d, pc_plus4_d;
    input [4:0] rs1_d, rs2_d, rd_d;
    output [31:0] rd1_e, rd2_e, pc_e, ext_imm_e, pc_plus4_e;
    output [4:0] rs1_e, rs2_e, rd_e;

    reg_32bit rd1(clk, rst, clr, 1'b1, rd1_d, rd1_e);
    reg_32bit rd2(clk, rst, clr, 1'b1, rd2_d, rd2_e);
    reg_32bit pc(clk, rst, clr, 1'b1, pc_d, pc_e);
    reg_32bit ext_imm(clk, rst, clr, 1'b1, ext_imm_d, ext_imm_e);
    reg_32bit pc_plus4(clk, rst, clr, 1'b1, pc_plus4_d, pc_plus4_e);

    reg_5bit rs1(clk, rst, clr, 1'b1, rs1_d, rs1_e);
    reg_5bit rs2(clk, rst, clr, 1'b1, rs2_d, rs2_e);
    reg_5bit rd(clk, rst, clr, 1'b1, rd_d, rd_e);

endmodule