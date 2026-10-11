
module alu4_tb;

reg [3:0] A, B;
reg [2:0] sel;

wire [3:0] result;
wire carry, zero, borrow;

integer a_i, b_i, op_i;
integer passed, failed;

reg [3:0] expected_result;
reg expected_carry, expected_zero, expected_borrow;
reg [4:0] temp_sum;

alu4 uut (
    .A(A),
    .B(B),
    .sel(sel),
    .result(result),
    .carry(carry),
    .zero(zero),
    .borrow(borrow)
);

initial begin
    $dumpfile("alu4.vcd");
    $dumpvars(0, alu4_tb);

    passed = 0;
    failed = 0;

    $display("Starting exhaustive ALU verification...");

    // Test every A, B and operation combination
    for (a_i = 0; a_i < 16; a_i = a_i + 1) begin
        for (b_i = 0; b_i < 16; b_i = b_i + 1) begin
            for (op_i = 0; op_i < 8; op_i = op_i + 1) begin

                A = a_i;
                B = b_i;
                sel = op_i;

                // Default expected flags
                expected_result = 4'b0000;
                expected_carry = 1'b0;
                expected_borrow = 1'b0;
                temp_sum = 5'b00000;

                // Independent reference model
                case (op_i)
                    0: begin
                        temp_sum = a_i + b_i;
                        expected_result = temp_sum[3:0];
                        expected_carry = temp_sum[4];
                    end

                    1: begin
                        expected_result = a_i - b_i;
                        expected_borrow = (a_i < b_i);
                    end

                    2: expected_result = A & B;
                    3: expected_result = A | B;
                    4: expected_result = A ^ B;
                    5: expected_result = ~A;

                    6: begin
                        temp_sum = a_i + 1;
                        expected_result = temp_sum[3:0];
                        expected_carry = temp_sum[4];
                    end

                    7: expected_result = B;

                    default: expected_result = 4'b0000;
                endcase

                expected_zero = (expected_result == 4'b0000);

                // Allow the combinational ALU to settle
                #1;

                // Compare every output and flag
                if (result === expected_result &&
                    carry === expected_carry &&
                    zero === expected_zero &&
                    borrow === expected_borrow) begin

                    passed = passed + 1;
                end
                else begin
                    failed = failed + 1;

                    // Print only the first 10 failures
                    if (failed <= 10) begin
                        $display(
                            "FAIL: A=%0d B=%0d sel=%b",
                            A, B, sel
                        );
                        $display(
                            "Expected: result=%b carry=%b zero=%b borrow=%b",
                            expected_result, expected_carry,
                            expected_zero, expected_borrow
                        );
                        $display(
                            "Actual:   result=%b carry=%b zero=%b borrow=%b",
                            result, carry, zero, borrow
                        );
                    end
                end

            end
        end
    end

    $display("--------------------------------");
    $display("Total combinations: %0d", passed + failed);
    $display("Passed:             %0d", passed);
    $display("Failed:             %0d", failed);
    $display("--------------------------------");

    if (failed == 0)
        $display("ALL 2048 TESTS PASSED!");
    else
        $display("VERIFICATION FAILED!");

    $finish;
end

endmodule


