module HackCPU (
    input wire clk,
    input wire reset,
    input wire [15:0] inM,          // Input from memory
    input wire [15:0] instruction,  // Current instruction
    output reg [15:0] outM,         // Output to memory
    output reg [15:0] addressM,     // Address to write to memory
    output reg writeM,              // Write enable signal
    output reg [15:0] pc,           // Program counter
    output wire [15:0] A,           // Expose A register
    output wire [15:0] D,           // Expose D register
    output wire aluNegative         // Expose ALU negative flag
);

    // Registers A and D
    reg [15:0] A_reg; // Internal Register A
    reg [15:0] D_reg; // Internal Register D

    // Assign exposed outputs to internal registers
    assign A = A_reg;
    assign D = D_reg;

    // ALU operation
    wire [15:0] aluResult;
    wire aluZero; // ALU zero flag

    // ALU implementation
    ALU alu (
        .x(D_reg),
        .y(instruction[12] ? inM : A_reg),
        .zx(instruction[11]),
        .nx(instruction[10]),
        .zy(instruction[9]),
        .ny(instruction[8]),
        .f(instruction[7]),
        .no(instruction[6]),
        .out(aluResult),
        .zr(aluZero),
        .ng(aluNegative) // ALU negative flag
    );

    // Program Counter Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 16'b0; // Reset PC to 0
            A_reg <= 16'b0;  // Reset A to 0
            D_reg <= 16'b0;  // Reset D to 0
        end else begin
            // Determine jump condition
            case (instruction[2:0])
                3'b000: pc <= pc + 1;                       // No jump
                3'b001: if (!aluNegative && !aluZero) pc <= A_reg; // Jump if out > 0
                3'b010: if (aluZero) pc <= A_reg;           // Jump if out == 0
                3'b011: if (!aluNegative) pc <= A_reg;      // Jump if out >= 0
                3'b100: if (aluNegative) pc <= A_reg;       // Jump if out < 0
                3'b101: if (!aluZero) pc <= A_reg;          // Jump if out != 0
                3'b110: if (aluNegative || aluZero) pc <= A_reg; // Jump if out <= 0
                3'b111: pc <= A_reg;                        // Unconditional jump
                default: pc <= pc + 1;                      // Default: increment PC
            endcase
        end
    end


    // Main CPU Logic
    always @(posedge clk) begin
        // Default outputs
        outM <= 16'b0;
        addressM <= 16'b0;
        writeM <= 1'b0;

        // Decode instruction on clock edge
        if (instruction[15] == 0) begin // A-instruction
            A_reg <= instruction[14:0]; // Load value into A
        end else if (instruction[15] == 1) begin // C-instruction
            D_reg <= aluResult; // Store ALU result in D

            // Example: Using the ALU negative flag to control output
            if (instruction[3]) begin // D=M
                outM <= aluResult; // Output ALU result to memory
                addressM <= A_reg; // Use A_reg as the memory address
                writeM <= 1'b1; // Enable memory write
            end
        end
    end

endmodule
