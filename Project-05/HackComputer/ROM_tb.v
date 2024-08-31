`timescale 1ns / 1ps

module ROM_tb;

    // Parameters for ROM size
    localparam ROM_SIZE = 32 * 1024;  // 32K ROM

    // Signals for ROM
    reg [$clog2(ROM_SIZE)-1:0] address;
    wire [15:0] out;

    // Instantiate the ROM module
    ROM #(
        .SIZE(ROM_SIZE)
    ) uut (
        .address(address),
        .out(out)
    );

    // Testbench variables
    integer i;
    integer logFile;

    // Initialize signals
    initial begin
        address = 0;
        logFile = $fopen("ROM_tb.out", "w");
        if (logFile == 0) begin
            $display("Error: Unable to open ROM_tb.out for writing.");
            $finish;
        end

        // Test range from 0 to 255 (adjust if needed)
        for (i = 0; i < 256; i = i + 1) begin
            #10 address = i;
            // Log the output to ROM_tb.out
            $fwrite(logFile, "Time: %0t | Address: %0d | Output: %0h\n", $time, address, out);
        end

        // Add additional testing for more addresses if needed
        // Comment/uncomment and adjust range based on your ROM file
        // for (i = 256; i < 512; i = i + 1) begin
        //     #10 address = i;
        //     // Log the output to ROM_tb.out
        //     $fwrite(logFile, "Time: %0t | Address: %0d | Output: %0h\n", $time, address, out);
        // end

        // Close the output file and end the simulation
        $fclose(logFile);
        $finish;
    end

    // Monitor internal signals
    initial begin
        $monitor("Time: %0t | Address: %0d | Output: %0h", $time, address, out);
    end

endmodule
