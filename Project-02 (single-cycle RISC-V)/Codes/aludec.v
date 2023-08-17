module aludec (
  input  reg        opb5,
  input  reg        Branch,
  input  reg [2:0]  funct3,
  input  reg        funct7b5,
  input  reg [1:0]  ALUOp,
  output reg [2:0]  ALUControl,
  output reg [1:0]  JumpType
);
  reg RtypeSub;
  assign RtypeSub = funct7b5 & opb5; // TRUE for R–type subtract
  
  reg [4:0] controls;
  assign {ALUControl, JumpType} = controls;

  always@(*) begin
    case (ALUOp)
      2'b00: controls = 5'b000_00; // addition
      2'b01: controls = 5'b001_00; // subtraction
      default: case (funct3) // R–type or I–type ALU
        3'b000: if(Branch)
                  controls = 5'b001_00; // beq
                else if (RtypeSub)
                  controls = 5'b001_00; // sub
                else
                  controls = 5'b000_00; // add, addi
        3'b001: controls = 5'b001_01; // bne
        3'b010: controls = 5'b101_00; // slt, slti
        3'b100: controls = 5'b101_10; // blt
        3'b101: controls = 5'b101_11; // bge 
        3'b110: controls = 5'b011_00; // or, ori
        3'b111: controls = 5'b010_00; // and, andi
        default: controls = 5'bxxx_00; 
      endcase
    endcase
  end
endmodule
