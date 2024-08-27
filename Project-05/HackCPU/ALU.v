// ALU Module
module ALU (
    input wire [15:0] A,
    input wire [15:0] D,
    input wire [15:0] instruction,
    output reg [15:0] result,
    output reg zero
);
    always @(*) begin
        case (instruction[11:8]) // Example ALU operation decoder
            4'b0000: result = A + D; // Example: ADD
            4'b0001: result = A - D; // Example: SUB
            // Add more operations as needed
            default: result = 16'b0; // Default case
        endcase

        zero = (result == 16'b0); // Set zero flag if result is zero
    end
endmodule