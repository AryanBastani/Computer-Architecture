module reg_gp2(clk, rst, clr, rd1_d, rd2_d, pc_d, rs1_d,
    rs2_d, rd_d, ext_imm_d, pc_plus4_d, rd1_e, rd2_e,
    pc_e, rs1_e, rs2_e, rd_e, ext_imm_e, pc_plus4_e,
    reg_write_d, result_src_d, mem_write_d, lui_d, jump_d,
    branch_d, branch_type_d, jalr_d, alu_control_d,
    alu_src_d, reg_write_e, result_src_e, mem_write_e,
    lui_e, jump_e, branch_e, branch_type_e, jalr_e,
    alu_control_e, alu_src_e);
    input clk, rst, clr;

    // Datapath signals:
    input [31:0] rd1_d, rd2_d, pc_d, ext_imm_d, pc_plus4_d;
    input [4:0] rs1_d, rs2_d, rd_d;
    output [31:0] rd1_e, rd2_e, pc_e, ext_imm_e, pc_plus4_e;
    output [4:0] rs1_e, rs2_e, rd_e;

    // Controller signals:
    input reg_write_d, mem_write_d, lui_d,
        jump_d, branch_d, jalr_d, alu_src_d;
    input [1:0] result_src_d, branch_type_d;
    input [2:0] alu_control_d;
    output reg_write_e, mem_write_e, lui_e,
        jump_e, branch_e, jalr_e, alu_src_e;
    output [1:0] result_src_e, branch_type_e;
    output [2:0] alu_control_e;

    // Instantiate of datapath and controller:
    reg_gp2_dp datapath_regs(clk, rst, clr, rd1_d, rd2_d, pc_d, rs1_d,
    rs2_d, rd_d, ext_imm_d, pc_plus4_d, rd1_e, rd2_e, pc_e,
    rs1_e, rs2_e, rd_e, ext_imm_e, pc_plus4_e);
    reg_gp2_cr controller_regs(clk, rst, clr, reg_write_d, result_src_d,
    mem_write_d, lui_d, jump_d, branch_d, branch_type_d, jalr_d,
    alu_control_d, alu_src_d, reg_write_e, result_src_e,
    mem_write_e, lui_e, jump_e, branch_e, branch_type_e, jalr_e,
    alu_control_e, alu_src_e);

endmodule


