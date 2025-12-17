`timescale 1ns/1ps

module alu_tb_selfcheck;

    // -------------------------
    // Testbench signals
    // -------------------------
    reg  signed [15:0] A, B;
    reg  [3:0] OP;

    wire signed [15:0] RESULT;
    wire CARRY;
    wire OVERFLOW;
    wire ZERO;

    // -------------------------
    // Instantiate DUT
    // -------------------------
    alu #(.WIDTH(16)) dut (
        .A(A),
        .B(B),
        .OP(OP),
        .RESULT(RESULT),
        .CARRY(CARRY),
        .OVERFLOW(OVERFLOW),
        .ZERO(ZERO)
    );

    // -------------------------
    // Reference model signals
    // -------------------------
    reg signed [15:0] exp_result;

    // -------------------------
    // Self-checking task
    // -------------------------
    task check_result;
        input signed [15:0] expected;
        begin
            if (RESULT !== expected)
                $display("❌ FAIL | A=%0d B=%0d OP=%b | EXPECT=%0d GOT=%0d",
                          A, B, OP, expected, RESULT);
            else
                $display("✅ PASS | A=%0d B=%0d OP=%b | RESULT=%0d",
                          A, B, OP, RESULT);
        end
    endtask

    // -------------------------
    // Test sequence
    // -------------------------
    initial begin
        $display("==== DAY 7 SELF-CHECKING TEST START ====");

        // ADD
        A = 10; B = 5; OP = 4'b0000;
        exp_result = A + B;
        #10;
        check_result(exp_result);

        // SUB
        A = 10; B = 5; OP = 4'b0001;
        exp_result = A - B;
        #10;
        check_result(exp_result);

        // ADD overflow case
        A = 16'sd32767; B = 16'sd1; OP = 4'b0000;
        exp_result = A + B;   // wraps naturally in 16-bit
        #10;
        check_result(exp_result);

        // SUB overflow case
        A = -16'sd32768; B = 16'sd1; OP = 4'b0001;
        exp_result = A - B;
        #10;
        check_result(exp_result);

        // AND
        A = 8; B = 3; OP = 4'b0010;
        exp_result = A & B;
        #10;
        check_result(exp_result);

        // OR
        A = 8; B = 3; OP = 4'b0011;
        exp_result = A | B;
        #10;
        check_result(exp_result);

        // XOR
        A = 8; B = 3; OP = 4'b0100;
        exp_result = A ^ B;
        #10;
        check_result(exp_result);

        // SHIFT LEFT
        A = 4; B = 0; OP = 4'b0101;
        exp_result = A << 1;
        #10;
        check_result(exp_result);

        // SHIFT RIGHT
        A = 8; B = 0; OP = 4'b0110;
        exp_result = A >> 1;
        #10;
        check_result(exp_result);

        // ZERO case
        A = 0; B = 0; OP = 4'b0000;
        exp_result = 0;
        #10;
        check_result(exp_result);

        $display("==== DAY 7 SELF-CHECKING TEST END ====");
        $finish;
    end

endmodule
