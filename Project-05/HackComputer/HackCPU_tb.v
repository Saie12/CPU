module HackCPU_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [15:0] inM;           // Input from memory
    reg [15:0] instruction;   // Current instruction

    // Outputs
    wire [15:0] outM;         // Output to memory
    wire [15:0] addressM;     // Address to write to memory
    wire writeM;              // Write enable signal
    wire [15:0] pc;           // Program counter
    wire [15:0] A;            // Expose A register
    wire [15:0] D;            // Expose D register
    wire aluNegative;         // Expose ALU negative flag

    // Instantiate the HackCPU
    HackCPU cpu (
        .clk(clk),
        .reset(reset),
        .inM(inM),
        .instruction(instruction),
        .outM(outM),
        .addressM(addressM),
        .writeM(writeM),
        .pc(pc),
        .A(A),
        .D(D),
        .aluNegative(aluNegative)
    );

    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5 time units

    // Testbench logic
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;    // Assert reset initially
        inM = 16'b0;
        instruction = 16'b0;

        // Apply reset
        #10;
        reset = 0;    // Deassert reset after 10 time units
        
        // Test Case 1: A-instruction
        instruction = 16'b0000000000010000;  // A-instruction: @16
        #10;  // Wait for clock edge
        
        $display("Time: %0t | A: %0h | PC: %0h", $time, A, pc);
        
        // Test Case 2: C-instruction (D = A)
        instruction = 16'b1110110000010000;  // C-instruction: D = A
        #10;  // Wait for clock edge
        
        $display("Time: %0t | D: %0h | PC: %0h", $time, D, pc);

        // Test Case 3: C-instruction (M = A)
        instruction = 16'b1110001100001000;  // C-instruction: M = A
        #10;  // Wait for clock edge
        
        $display("Time: %0t | outM: %0h | addressM: %0h | writeM: %0b", $time, outM, addressM, writeM);

        // Test Case 4: ALU negative output
        instruction = 16'b1110001111011000;  // Example ALU instruction
        inM = 16'hFFFF;  // Set memory input to a negative value (for ALU)
        #10;  // Wait for clock edge

        $display("Time: %0t | ALU Result: %0h | ALU Negative: %0b", $time, outM, aluNegative);
        
        // Add more test cases to cover different instructions and edge cases

        // Finish the simulation
        #50;
        $finish;
    end

endmodule
