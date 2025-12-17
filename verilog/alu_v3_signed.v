module alu (
    input  [15:0] A,
    input  [15:0] B,
    input  [3:0]  OP,
    output reg [15:0] RESULT,
    output reg CARRY,
    output reg OVERFLOW,
    output ZERO
);

    // ---- SIGNED WIRES (THIS WAS MISSING IN YOUR FILE) ----
    wire signed [15:0] sA = A;
    wire signed [15:0] sB = B;
    wire signed [15:0] sR = RESULT;

    assign ZERO = (RESULT == 16'd0);

    always @(*) begin
        RESULT   = 16'd0;
        CARRY    = 1'b0;
        OVERFLOW = 1'b0;

        case (OP)

            // ADD (signed)
            4'b0000: begin
                {CARRY, RESULT} = A + B;
                OVERFLOW = (~(sA[15] ^ sB[15])) &
                           (sA[15] ^ sR[15]);
            end

            // SUB (signed)
            4'b0001: begin
                RESULT = A - B;
                OVERFLOW = (sA[15] ^ sB[15]) &
                           (sA[15] ^ sR[15]);
            end

            // LOGIC
            4'b0010: RESULT = A & B;
            4'b0011: RESULT = A | B;
            4'b0100: RESULT = A ^ B;

            // SHIFTS
            4'b0101: RESULT = A << 1;
            4'b0110: RESULT = A >> 1;

            default: begin
                RESULT   = 16'd0;
                CARRY    = 1'b0;
                OVERFLOW = 1'b0;
            end

        endcase
    end

endmodule
