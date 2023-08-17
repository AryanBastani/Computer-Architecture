module maindec (
  input  reg [6:0]   op,
  output reg [1:0]   ResultSrc,
  output reg         MemWrite,
  output reg         Branch,
  output reg         ALUSrc,
  output reg         RegWrite,
  output reg         Jump,
  output reg [2:0]   ImmSrc,
  output reg [1:0]   ALUOp,
  output reg         Jalr,
  output reg         Lui
);

  reg [13:0] controls;

  assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump, Jalr, Lui} = controls;

  always@(*)
    case(op)
      // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump
      7'b0000011: controls = 14'b1_000_1_0_01_0_00_0_0_0; // lw
      7'b0100011: controls = 14'b0_001_1_1_00_0_00_0_0_0; // sw
      7'b0110011: controls = 14'b1_xxx_0_0_00_0_10_0_0_0; // R–type
      7'b1100011: controls = 14'b0_010_0_0_xx_1_10_0_0_0; // beq or bne or blt or bge
      7'b0010011: controls = 14'b1_000_1_0_00_0_10_0_0_0; // I–type ALU
      7'b1100111: controls = 14'b1_000_1_0_10_0_00_1_1_0; // jalr
      7'b1101111: controls = 14'b1_011_x_0_10_0_xx_1_0_0; // jal
      7'b0110111: controls = 14'b1_100_x_0_11_0_xx_0_0_1; // lui
      default   : controls = 14'b0_000_0_0_00_0_00_0_0_0;
    endcase

endmodule