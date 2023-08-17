module data_path(clk, rst, reg_write_d, alu_control_d, mem_write_d,
    jump_d, branch_d, branch_type_d, jalr_d, result_src_d, alu_src_d,
    imm_src_d, lui_d, op, funct3, funct7b5);

    input clk, rst, reg_write_d, mem_write_d,
        alu_src_d, jump_d, branch_d, jalr_d, lui_d;
    input [1:0] result_src_d, branch_type_d;
    input [2:0] alu_control_d, imm_src_d;
    output [6:0] op;
    output [2:0] funct3;
    output funct7b5;
    // 1_Fetch stage signals:
    wire [31:0] pc_f, instr_f, pc_plus4_f, pc_in_f;
    // 2_Decode stage signals:
    wire reg_write_d, mem_write_d;
    wire [4:0] rs1_d, rs2_d, rd_d;
    wire [31:0]  instr_d, ext_imm_d, rd1_d,
        rd2_d, pc_d, pc_plus4_d; 
    // 3_Execute stage signals:
    wire reg_write_e, mem_write_e, jump_e, lui_e,
        branch_e, alu_src_e, slt_out_e, zero_e;
    wire [1:0]  result_src_e,
    	pc_src_e, branch_type_e;
    wire [2:0] alu_control_e;
    wire [4:0]  rs1_e, rs2_e, rd_e;
    wire [31:0] rd1_e, rd2_e, pc_e, ext_imm_e, pc_target_e,
        src_a_e, src_b_e, write_data_e, alu_result_e, pc_plus4_e;
    // 4_Memory stage signals:
    wire reg_write_m, mem_write_m, lui_m;
    wire [1:0] result_src_m;
    wire [4:0] rd_m;
    wire [31:0] alu_result_m, write_data_m,
        pc_plus4_m, read_data_m, ext_imm_m, new_val_m;
    // 5_Write_back stage signals:
    wire reg_write_w;
    wire [1:0] result_src_w;
    wire [4:0] rd_w;
    wire [31:0] alu_result_w, read_data_w,
        pc_plus4_w, result_w, ext_imm_w;
    // 6_Hazard_unit signals:
    wire stall_f, stall_d, flush_d, flush_e;
    wire [1:0] forward_a_e, forward_b_e;

    // here is the decode of instruction:
    assign op = instr_d[6:0];
    assign funct3 = instr_d[14:12];
    assign funct7b5 = instr_d[30];
    assign rs1_d = instr_d[19:15];
    assign rs2_d = instr_d[24:20];
    assign rd_d = instr_d[11:7];

    assign slt_out_e = alu_result_e[0]; 
        // if slt is true then output of alu is like ....0001

    // here is all instants of the modules:
    // 1_Instruction Fetch stage:
    reg_32bit pc(clk, rst, 1'b0, ~stall_f, pc_in_f, pc_f);
    adder_32bit pc_adder(pc_f , 4, pc_plus4_f); // just calculating next pc
    mux_3_to_1 pc_in_mux(pc_plus4_f, pc_target_e,
        alu_result_e, pc_src_e, pc_in_f);
    inst_mem my_inst_mem(pc_f, instr_f);
    // Register between stage 1 and 2:
    reg_group1 bridge_1_2(clk, rst, flush_d, ~stall_d, instr_f,
        pc_f, pc_plus4_f, instr_d, pc_d, pc_plus4_d);
    // 2_Instruction_decode stage:
    register_file r_f(clk, reg_write_w, rs1_d ,rs2_d, rd_w,
        result_w, rd1_d, rd2_d);
    imm_extend my_imm_extend(instr_d, imm_src_d, ext_imm_d);
    // Register between stage 2 and 3:
    reg_gp2  bridge_2_3(clk, rst, flush_e, rd1_d, rd2_d, pc_d, rs1_d,
    rs2_d, rd_d, ext_imm_d, pc_plus4_d, rd1_e, rd2_e,
    pc_e, rs1_e, rs2_e, rd_e, ext_imm_e, pc_plus4_e,
    reg_write_d, result_src_d, mem_write_d, lui_d, jump_d,
    branch_d, branch_type_d, jalr_d, alu_control_d,
    alu_src_d, reg_write_e, result_src_e, mem_write_e,
    lui_e, jump_e, branch_e, branch_type_e, jalr_e,
    alu_control_e, alu_src_e);
    // 3_Execute stage:
    alu alu1(src_a_e, src_b_e, alu_control_e,
        alu_result_e, zero_e);
    mux_3_to_1 src_a_e_mux(rd1_e, result_w,
        new_val_m, forward_a_e, src_a_e);
    mux_3_to_1 wr_data_e_mux(rd2_e, result_w,
        new_val_m, forward_b_e, write_data_e);
    mux_2_to_1 src_b_e_mux(write_data_e, ext_imm_e,
        alu_src_e, src_b_e);
    	// the output of this mux is the second input for alu
    adder_32bit imm_adder(ext_imm_e, pc_e, pc_target_e); 
        // calculating ( jump_addres + pc )
    CalculatePCSrc my_pc_src(zero_e, slt_out_e, jump_e,
        branch_e, branch_type_e, jalr_e, pc_src_e);
        // this module is a controll module
    // Register between stage 3 and 4:
    reg_gp3 bridge_3_4(clk, rst, alu_result_e, write_data_e,
    rd_e, pc_plus4_e, ext_imm_e, alu_result_m, write_data_m,
    rd_m, pc_plus4_m, ext_imm_m, reg_write_e, result_src_e,
    mem_write_e, lui_e, reg_write_m, result_src_m,
    mem_write_m, lui_m);
    // 4_Memory stage:
    deta_mem data_memory(clk, mem_write_m, alu_result_m,
        write_data_m, read_data_m);
    mux_2_to_1 new_val_mux(alu_result_m, ext_imm_m, lui_m, new_val_m);
    // Register between stage 4 and 5:
    reg_gp4 bridge_4_5(clk, rst, reg_write_m, result_src_m,
    reg_write_w, result_src_w, alu_result_m,
    read_data_m, rd_m, pc_plus4_m, ext_imm_m,
    alu_result_w, read_data_w, rd_w, pc_plus4_w, ext_imm_w);
    // 5_Write_back stage:
    mux_4_to_1 mux2(alu_result_w, read_data_w, pc_plus4_w,
        ext_imm_w, result_src_w, result_w);
    	// the output of this mux is the write_data for register_file
    // 6_Hazard_unit:
    hazard_unit my_hazard(rs1_d, rs2_d, rd_e, rs1_e, rs2_e, pc_src_e,
    result_src_e[0], rd_m, reg_write_m, rd_w, reg_write_w,
    stall_f, stall_d, flush_d, flush_e, forward_a_e, forward_b_e);

endmodule