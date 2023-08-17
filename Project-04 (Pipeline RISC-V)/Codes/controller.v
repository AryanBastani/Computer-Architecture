module controller (
  input  reg [6:0]  op,
  input  reg [2:0]  funct3,
  input  reg        funct7b5,
  output [1:0]      ResultSrc,
  output            MemWrite,
  output            Jump,
  output            Branch,
  output [1:0]      BranchType,
  output            Jalr,
  output            Lui,
  output            ALUSrc,
  output            RegWrite,
  output [2:0]      ImmSrc,
  output [2:0]      ALUControl
);

  wire [1:0] ALUOp;

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
    .Jalr        (Jalr),
    .Lui         (Lui)
  );

  aludec ad (       
    .opb5       (op[5]),
    .Branch     (Branch),
    .funct3     (funct3),
    .funct7b5   (funct7b5),
    .ALUOp      (ALUOp),
    .ALUControl (ALUControl),
    .BranchType (BranchType)
  );

endmodule

