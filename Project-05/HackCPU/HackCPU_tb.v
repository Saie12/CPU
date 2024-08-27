`timescale 1ns / 1ps

module tb_HackCPU;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in nanoseconds

    // Inputs
    reg clk;                     // Clock signal
    reg reset;                   // Reset signal
    reg [15:0] inM;              // Input from memory
    reg [15:0] instruction;      // Current instruction

    // Outputs
    wire [15:0] outM;            // Output to memory
    wire [15:0] addressM;        // Address to write to memory
    wire writeM;                 // Write enable signal
    wire [15:0] pc;              // Program counter

    // Instantiate the HackCPU
    HackCPU uut (
        .clk(clk),
        .reset(reset),
        .inM(inM),
        .instruction(instruction),
        .outM(outM),
        .addressM(addressM),
        .writeM(writeM),
        .pc(pc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Toggle clock every half period
    end

    // Declare output file as an integer
    integer output_file;

    // Test procedure
    initial begin
        // Open output file
        output_file = $fopen("HackCPU.out", "w");
        if (!output_file) begin
            $display("Error opening output file");
            $finish;
        end

        // Open VCD dump file for waveform analysis
        $dumpfile("HackCPU.vcd");
        $dumpvars(0, tb_HackCPU);

        // Reset the CPU
        reset = 1;
        #CLK_PERIOD; // Wait for one clock cycle
        reset = 0;

        // Test Case 1: A-instruction
        instruction = 16'b0000000000000001; // Load 1 into A
        #CLK_PERIOD; // Wait for one clock cycle
        $fwrite(output_file, "PC:%d , A:%d , D:%d , outM:%d , addressM:%d , writeM:%b \n", pc, uut.A, uut.D, outM, addressM, writeM);
        $display("Executed A-instruction: PC: %d, A: %d, D: %d, outM: %d, addressM: %d, writeM: %b", pc, uut.A, uut.D, outM, addressM, writeM);

        // Test Case 2: C-instruction (D = A + D)
        uut.D = 16'd5; // Set D to 5 before executing the instruction
        instruction = 16'b0001000000000000; // C-instruction: D = A + D
        #CLK_PERIOD; // Wait for one clock cycle
        $fwrite(output_file, "PC: %d, A: %d, D: %d, outM: %d, addressM: %d, writeM: %b\n", pc, uut.A, uut.D, outM, addressM, writeM);
        $display("Executed C-instruction: PC: %d, A: %d, D: %d, outM: %d, addressM: %d, writeM: %b", pc, uut.A, uut.D, outM, addressM, writeM);

        // Test Case 3: Write to Memory
        instruction = 16'b0001000000000001; // C-instruction: Write D to memory at address A
        #CLK_PERIOD; // Wait for one clock cycle
        $fwrite(output_file, "PC: %d, A: %d, D: %d, outM: %d, addressM: %d, writeM: %b\n", pc, uut.A, uut.D, outM, addressM, writeM);
        $display("Executed Write to Memory: PC: %d, A: %d, D: %d, outM: %d, addressM: %d, writeM: %b", pc, uut.A, uut.D, outM, addressM, writeM);

        // Test Case 4: Reset the CPU
        reset = 1;
        #CLK_PERIOD; // Wait for one clock cycle
        reset = 0;

        // Test Case 5: Another A-instruction
        instruction = 16'b0000000000000010; // Load 2 into A
        #CLK_PERIOD; // Wait for one clock cycle
        $fwrite(output_file, "PC: %d, A: %d, D: %d, outM: %d, addressM: %d, writeM: %b\n", pc, uut.A, uut.D, outM, addressM, writeM);
        $display("Executed A-instruction: PC: %d, A: %d, D: %d, outM: %d, addressM: %d, writeM: %b", pc, uut.A, uut.D, outM, addressM, writeM);

        // Close output file
        $fclose(output_file);

        // Finish simulation
        $finish;
    end

endmodule