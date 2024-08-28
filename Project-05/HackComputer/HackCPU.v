module HackCPU #(
    parameter RAM_SIZE = 16*1024   // Default RAM size is 16K words
) (
    input wire clk,
    input wire reset,
    input wire [15:0] inM,          // Input from memory
    input wire [15:0] instruction,  // Current instruction
    output reg [15:0] outM,         // Output to memory
    output reg [$clog2(RAM_SIZE)-1:0] addressM, // Address to memory
    output reg writeM,              // Write enable signal
    output reg [15:0] pc            // Program counter
);

    // Registers A and D
    reg [15:0] A;                   // Register A
    reg [15:0] D;                   // Register D

    // ALU operation
    wire [15:0] aluResult;
    wire aluZero;                   // ALU zero flag
    wire aluNegative;               // ALU negative flag

    // ALU implementation
    ALU alu (
        .x(D),                       // Operand X
        .y(instruction[12] ? inM : A), // Operand Y, based on instruction
        .zx(instruction[11]),        // Zero X
        .nx(instruction[10]),        // Negate X
        .zy(instruction[9]),         // Zero Y
        .ny(instruction[8]),         // Negate Y
        .f(instruction[7]),          // Function (Add/Sub)
        .no(instruction[6]),         // Negate Output
        .out(aluResult),             // ALU Result
        .zr(aluZero),                // Zero Flag
        .ng(aluNegative)             // Negative Flag
    );

    // Program Counter Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 16'b0; // Reset PC to 0
            A <= 16'b0;  // Reset A to 0
            D <= 16'b0;  // Reset D to 0
        end else begin
            pc <= pc + 1; // Increment PC for simple instructions
        end
    end

    // Main CPU Logic
    always @(posedge clk) begin
        // Default outputs
        outM <= 16'b0;
        addressM <= 16'b0;
        writeM <= 1'b0;

        if (instruction[15] == 1'b0) begin
            // A-instruction
            A <= instruction[14:0];
        end else begin
            // C-instruction (ALU operation)
            case (instruction[11:6])
                // Specific ALU and control operations here
                // Example:
                6'b000000: begin
                    D <= aluResult;
                    if (instruction[3]) outM <= aluResult; // Write to memory
                    if (instruction[4]) addressM <= A;   // Set memory address
                    if (instruction[5]) writeM <= 1'b1;  // Enable memory write
                end
            endcase
        end
    end

endmodule
