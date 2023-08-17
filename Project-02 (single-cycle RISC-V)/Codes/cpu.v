module cpu(clk, rst);
    input clk, rst;

    wire reg_write, mem_write, alu_src;
    wire [1:0] result_src, pc_src;
    wire [2:0] alu_control;
    wire [2:0] imm_src;
    wire [6:0] op;
    wire [2:0] funct3;
    wire zero, funct7b5, slt_out;


    data_path dp(clk, rst, reg_write, alu_control, mem_write, result_src,
	alu_src, imm_src, pc_src, op, funct3, funct7b5, zero, slt_out);

    controller cr(op, funct3, funct7b5, zero, slt_out, result_src, mem_write,
	pc_src, alu_src, reg_write, imm_src, alu_control);

endmodule
