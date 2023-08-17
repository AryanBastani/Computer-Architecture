module reg_group1(clk, rst, clr, en, instr_f, pc_f,
    pc_plus4_f, instr_d, pc_d, pc_plus4_d);
    input clk, rst, clr, en;
    input [31:0] instr_f, pc_f, pc_plus4_f;
    output [31:0] instr_d, pc_d, pc_plus4_d;

    reg_32bit instr(clk, rst, clr, en, instr_f, instr_d);
    reg_32bit pc(clk, rst, clr, en, pc_f, pc_d);
    reg_32bit pc_plus4(clk, rst, clr, en, pc_plus4_f, pc_plus4_d);
endmodule