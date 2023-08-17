module data_path(clk, rst,  reg_write, alu_control, mem_write, result_src,
	alu_src, imm_src, pc_src, op, funct3, funct7b5, zero, slt_out);

    input clk, rst, reg_write, mem_write, alu_src;
    input [1:0] result_src, pc_src;
    input [2:0] alu_control, imm_src;
    output [6:0] op;
    output [2:0] funct3;
    output zero, funct7b5, slt_out;

    wire [31:0] pc_in, pc_out, inst_out, alu_out, rd1, rd2,
        imm_out, alu_in2, mem_out, rf_write_data, next_adrs, next_pc;

    // here is the decode of instruction:
    assign op = inst_out[6:0];
    assign funct3 = inst_out[14:12];
    assign funct7b5 = inst_out[30];

    assign slt_out = alu_out[0]; // if slt is true then output of alu is like ....0001

    // and here is the all instantiates of modules:
    
    reg_32bit pc(clk, rst, 1'b1, pc_in, pc_out);
    adder_32bit pc_adder(pc_out , 4, next_pc); // just calculating next pc
    adder_32bit imm_adder(imm_out, pc_out, next_adrs); // calculating ( jump_addres + pc )
    mux_3_to_1 pc_in_mux(next_pc, next_adrs, alu_out, pc_src, pc_in);
    	// the output of this mux is the input for pc
    
    inst_mem my_inst_mem(pc_out, inst_out);

    register_file r_f(clk, reg_write, inst_out[19:15],
    inst_out[24:20], inst_out[11:7], rf_write_data, rd1, rd2);
    mux_4_to_1 mux2(alu_out, mem_out, next_pc, imm_out, result_src, rf_write_data);
    	// the output of this mux is the write_data for register_file

    imm_extend my_imm_extend(inst_out, imm_src, imm_out);

    alu alu1(rd1, alu_in2, alu_control, alu_out, zero);
    mux_2_to_1 alu_in_mux(rd2, imm_out, alu_src, alu_in2);
    	// the output of this mux is the input for alu

    deta_mem data_memory(clk, mem_write, alu_out, rd2, mem_out);

endmodule