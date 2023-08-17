module reg_gp4(clk, rst, reg_write_m, result_src_m,
    reg_write_w, result_src_w, alu_result_m,
    read_data_m, rd_m, pc_plus4_m, ext_imm_m,
    alu_result_w, read_data_w, rd_w, pc_plus4_w, ext_imm_w);
    input clk, rst;

    // Datapath signals:
    input [4:0] rd_m;
    input [31:0] alu_result_m, read_data_m,
        pc_plus4_m, ext_imm_m;
    output [4:0] rd_w;
    output [31:0] alu_result_w, read_data_w,
        pc_plus4_w, ext_imm_w;

    // Controller signals:
    input reg_write_m;
    input [1:0] result_src_m;
    output reg_write_w;
    output [1:0] result_src_w;

    // Instantiate of datapath and controller:
    reg_gp4_dp datapath_regs(clk, rst, alu_result_m, read_data_m,
    rd_m, pc_plus4_m, ext_imm_m, alu_result_w, read_data_w,
    rd_w, pc_plus4_w, ext_imm_w);
    reg_gp4_cr controller_regs(clk, rst, reg_write_m, result_src_m,
    reg_write_w, result_src_w);


endmodule
