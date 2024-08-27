module HackCPU (
    input wire clk,
    input wire reset,
    input wire [15:0] inM,          // Input from memory
    input wire [15:0] instruction,   // Current instruction
    output reg [15:0] outM,          // Output to memory
    output reg [15:0] addressM,      // Address to write to memory
    output reg writeM,               // Write enable signal
    output reg [15:0] pc             // Program counter
);

    // Registers A and D
    reg [15:0] A; // Register A
    reg [15:0] D; // Register D

    // ALU operation
    wire [15:0] aluResult;
    wire aluZero; // ALU zero flag

    // ALU implementation
    ALU alu (
        .A(A),
        .D(D),
        .instruction(instruction),
        .result(aluResult),
        .zero(aluZero)
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

        // Decode instruction on clock edge
        case (instruction[15:12]) // Decode instruction
            4'b0000: begin // A-instruction
                A <= instruction[11:0]; // Load value into A
            end
            4'b0001: begin // C-instruction
                D <= aluResult; // Store ALU result in D
                outM <= D; // Prepare output to memory
                addressM <= A; // Address for memory write
                writeM <= 1'b1; // Enable memory write
            end
            // Additional instruction cases can be added here
            default: begin
                // Handle other instructions
            end
        endcase
    end

endmodule