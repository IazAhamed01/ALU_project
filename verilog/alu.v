module alu (
    input  [15:0] A,
    input  [15:0] B,
    input  [3:0]  OP,
    output reg [15:0] RESULT
);

    always @(*) begin
        case (OP)
            4'b0000: RESULT = A + B;   // ADD
            4'b0001: RESULT = A - B;   // SUB
            4'b0010: RESULT = A & B;   // AND
            4'b0011: RESULT = A | B;   // OR
            4'b0100: RESULT = A ^ B;   // XOR
            4'b0101: RESULT = A << 1;  // SHIFT LEFT
            4'b0110: RESULT = A >> 1;  // SHIFT RIGHT
            default: RESULT = 0;
        endcase
    end

endmodule
