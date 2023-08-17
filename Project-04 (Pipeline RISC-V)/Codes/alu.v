`define PLUS 3'b000
`define MINUS 3'b001
`define AND 3'b010
`define OR 3'b011
`define SLT 3'b101

module alu(a, b, control, out, zero);
    input [31:0] a, b ;
    input [2:0] control;
    output reg [31:0] out;
    output zero;
    wire my_slt;
    assign my_slt = (a<b)? 1 : 0;
    always@ (a or b or control)
        case(control)
            `PLUS : out = a+ b;
            `MINUS : out = a- b;
            `AND : out = a& b;
            `OR : out = a| b;
            `SLT : out = my_slt;
            default : out = 0;
        endcase

    assign zero = ~|out;

endmodule