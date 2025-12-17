`timescale 1ns/1ps

module alu_tb;

    reg  [15:0] A, B;
    reg  [3:0]  OP;
    wire [15:0] RESULT;
    wire CARRY, OVERFLOW, ZERO;

    // Instantiate DUT
    alu dut (
        .A(A),
        .B(B),
        .OP(OP),
        .RESULT(RESULT),
        .CARRY(CARRY),
        .OVERFLOW(OVERFLOW),
        .ZERO(ZERO)
    );

    initial begin
        $display("==== ALU SIGNED + OVERFLOW TEST START ====");

        // -------------------------
        // Test 1: ADD (no overflow)
        // 10 + 5 = 15
        // -------------------------
        A = 16'sd10; B = 16'sd5; OP = 4'b0000;
        #10;
        $display("ADD: RESULT=%0d CARRY=%b OVERFLOW=%b ZERO=%b",
                  RESULT, CARRY, OVERFLOW, ZERO);

        // -------------------------
        // Test 2: ADD overflow
        // 32767 + 1 = overflow
        // -------------------------
        A = 16'sd32767; B = 16'sd1; OP = 4'b0000;
        #10;
      $display("ADD_OVF: RESULT=%0d CARRY=%b OVERFLOW=%b ZERO=%b",$signed(RESULT), CARRY, OVERFLOW, ZERO);

        // -------------------------
        // Test 3: SUB no overflow
        // 10 - 5 = 5
        // -------------------------
        A = 16'sd10; B = 16'sd5; OP = 4'b0001;
        #10;
        $display("SUB: RESULT=%0d CARRY=%b OVERFLOW=%b ZERO=%b",
              $signed(RESULT), CARRY, OVERFLOW, ZERO);

        // -------------------------
        // Test 4: SUB overflow
        // -32768 - 1 = overflow
        // -------------------------
        A = -16'sd32768; B = 16'sd1; OP = 4'b0001;
        #10;
        $display("SUB_OVF: RESULT=%0d CARRY=%b OVERFLOW=%b ZERO=%b",
                 $signed(RESULT), CARRY, OVERFLOW, ZERO);

        // -------------------------
        // Test 5: ZERO flag check
        // 0 + 0 = 0
        // -------------------------
        A = 16'd0; B = 16'd0; OP = 4'b0000;
        #10;
        $display("ZERO_CHK: RESULT=%0d CARRY=%b OVERFLOW=%b ZERO=%b",
               $signed(RESULT), CARRY, OVERFLOW, ZERO);

        $display("==== TESTBENCH COMPLETED ====");
        $finish;
    end

endmodule
