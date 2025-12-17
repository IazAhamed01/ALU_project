// --------------------------------------------------
// Module Name : alu
// Version     : v4 (Parameterized Width)
// Description : WIDTH-bit ALU with signed arithmetic,
//               ZERO, CARRY, OVERFLOW flags
// --------------------------------------------------

module alu #(
    parameter WIDTH = 16
)(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [3:0]       OP,
    output reg [WIDTH-1:0] RESULT,
    output reg CARRY,
    output reg OVERFLOW,
    output ZERO
);

    // Signed versions
    wire signed [WIDTH-1:0] sA = A;
    wire signed [WIDTH-1:0] sB = B;
    wire signed [WIDTH-1:0] sR = RESULT;

    assign ZERO = (RESULT == {WIDTH{1'b0}});

    always @(*) begin
        RESULT   = {WIDTH{1'b0}};
        CARRY    = 1'b0;
        OVERFLOW = 1'b0;

        case (OP)

            // ADD (signed)
            4'b0000: begin
                {CARRY, RESULT} = A + B;
                OVERFLOW = (~(sA[WIDTH-1] ^ sB[WIDTH-1])) &
                           (sA[WIDTH-1] ^ sR[WIDTH-1]);
            end

            // SUB (signed)
            4'b0001: begin
                RESULT = A - B;
                OVERFLOW = (sA[WIDTH-1] ^ sB[WIDTH-1]) &
                           (sA[WIDTH-1] ^ sR[WIDTH-1]);
            end

            // LOGIC
            4'b0010: RESULT = A & B;
            4'b0011: RESULT = A | B;
            4'b0100: RESULT = A ^ B;

            // SHIFTS
            4'b0101: RESULT = A << 1;
            4'b0110: RESULT = A >> 1;

            default: begin
                RESULT   = {WIDTH{1'b0}};
                CARRY    = 1'b0;
                OVERFLOW = 1'b0;
            end

        endcase
    end

endmodule
