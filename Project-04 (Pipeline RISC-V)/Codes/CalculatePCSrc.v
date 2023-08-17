`define BEQ 2'b00
`define BNE 2'b01
`define BLT 2'b10
`define BGE 2'b11
module CalculatePCSrc (
  input reg        Zero,
  input reg        SltOut,
  input reg        Jump,
  input reg        Branch,
  input reg [1:0]  BranchType,
  input reg        Jalr,
  output    [1:0]  PCSrc
  );

  wire JumpCondition;


 // Checking jump condition is true or not
 assign JumpCondition = 
    (BranchType==`BEQ)?
    Zero : (BranchType==`BNE)?
    ~Zero :(BranchType==`BLT)?
    SltOut : ~SltOut; // BGE
    
 // Calculate PCSrc and assign value
 assign PCSrc = Jalr ? (2'b10) : ((Branch &
    JumpCondition==1) | Jump)? (2'b01): (2'b00);

endmodule

    