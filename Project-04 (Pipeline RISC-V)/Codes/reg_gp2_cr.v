module reg_gp2_cr(clk, rst, clr, reg_write_d, result_src_d,
    mem_write_d, lui_d, jump_d, branch_d, branch_type_d, jalr_d,
    alu_control_d, alu_src_d, reg_write_e, result_src_e,
    mem_write_e, lui_e, jump_e, branch_e, branch_type_e, jalr_e,
    alu_control_e, alu_src_e);
    input clk, rst, clr, reg_write_d, mem_write_d, lui_d,
        jump_d, branch_d, jalr_d, alu_src_d;
    input [1:0] result_src_d, branch_type_d;
    input [2:0] alu_control_d;
    output reg_write_e, mem_write_e, lui_e,
        jump_e, branch_e, jalr_e, alu_src_e;
    output [1:0] result_src_e, branch_type_e;
    output [2:0] alu_control_e;

    reg_1bit reg_write(clk, rst, clr, 1'b1, reg_write_d, reg_write_e);
    reg_1bit mem_write(clk, rst, clr, 1'b1, mem_write_d, mem_write_e);
    reg_1bit lui(clk, rst, clr, 1'b1, lui_d, lui_e);
    reg_1bit jump(clk, rst, clr, 1'b1, jump_d, jump_e);
    reg_1bit branch(clk, rst, clr, 1'b1, branch_d, branch_e);
    reg_1bit jalr(clk, rst, clr, 1'b1, jalr_d, jalr_e);
    reg_1bit alu_src(clk, rst, clr, 1'b1, alu_src_d, alu_src_e);

    reg_2bit result_src(clk, rst, clr, 1'b1, result_src_d, result_src_e);
    reg_2bit branch_type(clk, rst, clr, 1'b1, branch_type_d, branch_type_e);

    reg_3bit alu_control(clk, rst, clr, 1'b1, alu_control_d, alu_control_e);


endmodule