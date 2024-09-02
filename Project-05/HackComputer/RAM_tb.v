`timescale 1ns/1ps

module RAM_tb;
    // Testbench parameters
    parameter CLOCK_PERIOD = 10;
    parameter RAM_SIZE = 16 * 1024; // 16K words

    // Testbench signals
    reg clk;
    reg [15:0] address; // Address input
    reg [15:0] in;                       // Data input
    wire [15:0] out;                    // Data output
    reg load;                            // Write enable signal

    // Instantiate the RAM module
    RAM #(
        .SIZE(RAM_SIZE)
    ) uut (
        .clk(clk),
        .address(address),
        .in(in),
        .out(out),
        .load(load)
    );

    // Clock generation
    always begin
        #(CLOCK_PERIOD / 2) clk = ~clk;
    end

    // Testbench initial block
    initial begin
        // Initialize signals
        clk = 0;
        address = 0;
        in = 0;
        load = 0;

        // Write values to RAM
        // Test case 1: Write value 42 to address 0
        address = 0;
        in = 16'h002A; // 42 in hexadecimal
        load = 1; // Enable write
        #CLOCK_PERIOD; // Wait for one clock period
        load = 0; // Disable write
        #CLOCK_PERIOD; // Allow time for the write to complete

        // Test case 2: Write value 100 to address 1
        address = 1;
        in = 16'h0064; // 100 in hexadecimal
        load = 1; // Enable write
        #CLOCK_PERIOD; // Wait for one clock period
        load = 0; // Disable write
        #CLOCK_PERIOD; // Allow time for the write to complete

        // Read values from RAM
        // Test case 3: Read value from address 0
        address = 0;
        #CLOCK_PERIOD; // Wait for one clock period
        if (out !== 16'h002A) begin
            $display("Test failed: Expected 42 at address 0, got %d", out);
        end else begin
            $display("Test passed: Read %d from address 0", out);
        end

        // Test case 4: Read value from address 1
        address = 1;
        #CLOCK_PERIOD; // Wait for one clock period
        if (out !== 16'h0064) begin
            $display("Test failed: Expected 100 at address 1, got %d", out);
        end else begin
            $display("Test passed: Read %d from address 1", out);
        end

        // Test case 5: Read from an unused address (should return 0)
        address = 2;
        #CLOCK_PERIOD; // Wait for one clock period
        if (out !== 16'h0000) begin
            $display("Test failed: Expected 0 at address 2, got %d", out);
        end else begin
            $display("Test passed: Read %d from address 2", out);
        end

        // Finish the simulation
        $finish;
    end

endmodule