`define BEQ 2'b00
`define BNE 2'b01
`define BLT 2'b10
`define BGE 2'b11

module controller (
  input  reg [6:0]  op,
  input  reg [2:0]  funct3,
  input  reg        funct7b5,
  input  reg        Zero,
  input  reg        SltOut,
  output [1:0]      ResultSrc,
  output            MemWrite,
  output [1:0]      PCSrc,
  output            ALUSrc,
  output            RegWrite,
  output [2:0]      ImmSrc,
  output [2:0]      ALUControl
);

  wire Jump, Branch, JumpCondition, Jalr;
  wire [1:0] ALUOp, JumpType;

  // Instantiate modules with appropriate signal connections
  maindec md (
    .op          (op),
    .ResultSrc   (ResultSrc),
    .MemWrite    (MemWrite),
    .Branch      (Branch),
    .ALUSrc      (ALUSrc),
    .RegWrite    (RegWrite),
    .Jump        (Jump),
    .ImmSrc      (ImmSrc),
    .ALUOp       (ALUOp),
    .Jalr        (Jalr)
  );

  aludec ad (       
    .opb5       (op[5]),
    .Branch     (Branch),
    .funct3     (funct3),
    .funct7b5   (funct7b5),
    .ALUOp      (ALUOp),
    .ALUControl (ALUControl),
    .JumpType   (JumpType)
  );

  // Checking jump condition is true or not
  assign JumpCondition = (JumpType==`BEQ)?
    Zero : (JumpType==`BNE)?
    ~Zero :(JumpType==`BLT)?
    SltOut : ~SltOut; // BGE
    
  // Calculate PCSrc and assign value
  assign PCSrc = Jalr? (2'b10) : ((Branch & JumpCondition) | Jump)? (2'b01): (2'b00);

endmodule

