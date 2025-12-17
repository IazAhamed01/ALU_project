// --------------------------------------------------
// Module Name : alu
// Description : 16-bit Arithmetic Logic Unit
// Author      : AJMAL AHAMED Z
// --------------------------------------------------
// Operations:
// 0000 : ADD
// 0001 : SUB
// 0010 : AND
// 0011 : OR
// 0100 : XOR
// 0101 : SHIFT LEFT
// 0110 : SHIFT RIGHT
// --------------------------------------------------

module alu (
    input  [15:0] A,
    input  [15:0] B,
    input  [3:0]  OP,
    output reg [15:0] RESULT
);

    // Combinational ALU logic
    always @(*) begin
        case (OP)

            // Arithmetic operations
            4'b0000: RESULT = A + B;   // ADD
            4'b0001: RESULT = A - B;   // SUB

            // Logical operations
            4'b0010: RESULT = A & B;   // AND
            4'b0011: RESULT = A | B;   // OR
            4'b0100: RESULT = A ^ B;   // XOR

            // Shift operations
            4'b0101: RESULT = A << 1;  // SHIFT LEFT
            4'b0110: RESULT = A >> 1;  // SHIFT RIGHT

            // Default case
            default: RESULT = 16'd0;

        endcase
    end

endmodule
