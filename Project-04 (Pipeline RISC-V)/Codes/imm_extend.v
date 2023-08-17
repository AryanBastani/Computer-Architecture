`define I_TYPE 3'b000
`define S_TYPE 3'b001
`define B_TYPE 3'b010
`define J_TYPE 3'b011
`define U_TYPE 3'b100
module imm_extend(inst, imm_src, imm_out);
    input [31:0] inst;
    input [2:0] imm_src;
    output [31:0] imm_out;

        assign imm_out =
            (imm_src==`I_TYPE)?
              {{20{inst[31]}}, inst[31:20]}: 
            (imm_src==`S_TYPE)?
              {{20{inst[31]}}, inst[31:25], inst[11:7]}:
            (imm_src==`B_TYPE)?
              {{19{inst[31]}}, inst[31], inst[7],
                inst[30:25], inst[11:8], 1'b0}:
            (imm_src==`J_TYPE)?
              {{11{inst[31]}}, inst[31], inst[19:12],
                inst[20], inst[30:21], 1'b0}:
            (imm_src==`U_TYPE)?
              {{12{inst[31]}}, inst[31:12]}:
            {{12{inst[31]}}, inst[31:12]}; // some default value

endmodule