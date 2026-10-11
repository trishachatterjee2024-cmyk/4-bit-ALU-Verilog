


module alu4 (
    input [3:0] A,
    input [3:0] B,
    input [2:0] sel,
    output reg [3:0] result,
    output reg carry,
    output reg zero,
    output reg borrow
);

always @(*) begin
    result = 4'b0000;
    carry = 1'b0;
    zero = 1'b0;
    borrow = 1'b0;

    case (sel)
        3'b000: {carry, result} = {1'b0, A} + {1'b0, B};
        3'b001: result = A - B;
        3'b010: result = A & B;
        3'b011: result = A | B;
        3'b100: result = A ^ B;
        3'b101: result = ~A;
        3'b110: {carry, result} = {1'b0, A} + 5'b00001;
        3'b111: result = B;
        default: result = 4'b0000;
    endcase

    if (sel == 3'b001 && A < B)
        borrow = 1'b1;

    if (result == 4'b0000)
        zero = 1'b1;
end

endmodule


