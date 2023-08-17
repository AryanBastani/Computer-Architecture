module cpu(clk, rst);
    input clk, rst;

    wire reg_write, mem_write, alu_src;
    wire [1:0] result_src, branch_type;
    wire [2:0] alu_control;
    wire [2:0] imm_src;
    wire [6:0] op;
    wire [2:0] funct3;
    wire funct7b5, jump, branch, jalr, lui;


    data_path dp(clk, rst, reg_write, alu_control, mem_write,
    jump, branch, branch_type, jalr, result_src,
	alu_src, imm_src, lui, op, funct3, funct7b5);

    controller cr(op, funct3, funct7b5, result_src,
    mem_write, jump, branch, branch_type, jalr, lui, alu_src,
    reg_write, imm_src, alu_control);

endmodule
