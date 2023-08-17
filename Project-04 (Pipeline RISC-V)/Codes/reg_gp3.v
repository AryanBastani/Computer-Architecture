module reg_gp3(clk, rst, alu_result_e, write_data_e,
    rd_e, pc_plus4_e, ext_imm_e, alu_result_m, write_data_m,
    rd_m, pc_plus4_m, ext_imm_m, reg_write_e, result_src_e,
    mem_write_e, lui_e, reg_write_m, result_src_m,
    mem_write_m, lui_m);
    input clk, rst;

    // Datapath signals:
    input [4:0] rd_e;
    input [31:0] alu_result_e, write_data_e, pc_plus4_e, ext_imm_e;
    output [4:0] rd_m;
    output [31:0] alu_result_m, write_data_m, pc_plus4_m, ext_imm_m;

    // Controller signals:
    input reg_write_e, mem_write_e, lui_e;
    input [1:0] result_src_e;
    output reg_write_m, mem_write_m, lui_m;
    output [1:0] result_src_m;
    
    // Instantiate of datapath and controller:
    reg_gp3_dp datapath_regs(clk, rst, alu_result_e,
    write_data_e, rd_e, pc_plus4_e, ext_imm_e,
    alu_result_m, write_data_m, rd_m, pc_plus4_m, ext_imm_m);
    reg_gp3_cr controller_regs(clk, rst, reg_write_e, result_src_e,
    mem_write_e, lui_e, reg_write_m, result_src_m, mem_write_m, lui_m);

endmodule

