// --------------------------------------------------
// Module Name : alu
// Description : 16-bit ALU with ZERO and CARRY flags
// Version     : v2 (Flags added)
// --------------------------------------------------

module alu (
    input  [15:0] A,
    input  [15:0] B,
    input  [3:0]  OP,
    output reg [15:0] RESULT,
    output reg CARRY,
    output ZERO
);

    // ZERO flag: high when RESULT is zero
    assign ZERO = (RESULT == 16'd0);

    always @(*) begin
        RESULT = 16'd0;
        CARRY  = 1'b0;

        case (OP)

            // ADD
            4'b0000: begin
                {CARRY, RESULT} = A + B;
            end

            // SUB
            4'b0001: begin
                RESULT = A - B;
                CARRY  = 1'b0; // no carry for subtraction (for now)
            end

            // AND
            4'b0010: RESULT = A & B;

            // OR
            4'b0011: RESULT = A | B;

            // XOR
            4'b0100: RESULT = A ^ B;

            // SHIFT LEFT
            4'b0101: RESULT = A << 1;

            // SHIFT RIGHT
            4'b0110: RESULT = A >> 1;

            default: begin
                RESULT = 16'd0;
                CARRY  = 1'b0;
            end

        endcase
    end

endmodule
