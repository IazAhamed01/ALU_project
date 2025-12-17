module alu #(
    parameter WIDTH = 16
)(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [3:0]       OP,
    output reg [WIDTH-1:0] RESULT,
    output reg          CARRY,
    output reg          OVERFLOW,
    output              ZERO
);

assign ZERO = (RESULT == 0);

always @(*) begin
    RESULT   = 0;
    CARRY    = 0;
    OVERFLOW = 0;

    case (OP)
        4'b0000: {CARRY, RESULT} = A + B;          // ADD
        4'b0001: {CARRY, RESULT} = A - B;          // SUB
        4'b0010: RESULT = A & B;                   // AND
        4'b0011: RESULT = A | B;                   // OR
        4'b0100: RESULT = A ^ B;                   // XOR
        4'b0101: RESULT = A << 1;                  // SHIFT LEFT
        4'b0110: RESULT = A >> 1;                  // SHIFT RIGHT
        4'b0111: RESULT = (A > B) ? 1 : 0;         // COMPARE
        default: RESULT = 0;
    endcase
end

endmodule
