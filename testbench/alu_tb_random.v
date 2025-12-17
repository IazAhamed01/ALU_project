`timescale 1ns/1ps

module alu_tb_random;

    integer i;
    integer pass_count = 0;
    integer fail_count = 0;

    reg  signed [15:0] A, B;
    reg  [3:0] OP;

    wire signed [15:0] RESULT;
    wire CARRY, OVERFLOW, ZERO;

    // DUT
    alu #(.WIDTH(16)) dut (
        .A(A),
        .B(B),
        .OP(OP),
        .RESULT(RESULT),
        .CARRY(CARRY),
        .OVERFLOW(OVERFLOW),
        .ZERO(ZERO)
    );

    reg signed [15:0] exp_result;

    task check;
        begin
            if (RESULT !== exp_result) begin
                $display("❌ FAIL | A=%0d B=%0d OP=%b | EXP=%0d GOT=%0d",
                          A, B, OP, exp_result, RESULT);
                fail_count = fail_count + 1;
            end
            else begin
                pass_count = pass_count + 1;
            end
        end
    endtask

    initial begin
        $display("==== DAY 8 RANDOM TEST START ====");

        for (i = 0; i < 200; i = i + 1) begin
            A  = $random;
            B  = $random;
            OP = $random % 7;  // operations 0–6 only

            case (OP)
                4'b0000: exp_result = A + B;   // ADD
                4'b0001: exp_result = A - B;   // SUB
                4'b0010: exp_result = A & B;   // AND
                4'b0011: exp_result = A | B;   // OR
                4'b0100: exp_result = A ^ B;   // XOR
                4'b0101: exp_result = A << 1;  // SHL
                4'b0110: exp_result = A >> 1;  // SHR
                default: exp_result = 0;
            endcase

            #5;
            check;
        end

        $display("==== RANDOM TEST COMPLETE ====");
        $display("PASS = %0d | FAIL = %0d", pass_count, fail_count);

        if (fail_count == 0)
            $display("🎉 ALL RANDOM TESTS PASSED");
        else
            $display("⚠️ RANDOM TEST FAILED");

        $finish;
    end

endmodule
