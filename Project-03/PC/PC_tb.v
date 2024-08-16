`timescale 1ns / 1ps

// Testbench for the Program Counter
module tb_ProgramCounter;
    reg [15:0] in;
    reg reset;
    reg load;
    reg inc;
    wire [15:0] out;

    ProgramCounter pc (
        .in(in),
        .reset(reset),
        .load(load),
        .inc(inc),
        .out(out)
    );

    // File descriptor for output file
    integer output_file;

    initial begin
        // Open output file for writing
        output_file = $fopen("PC.out", "w"); // Open the output file
        $dumpfile("PC.vcd"); // Create a VCD file for waveform analysis
        $dumpvars(0, tb_ProgramCounter); // Dump all variables in the testbench

        // Print header to the output file
        $fwrite(output_file, "| time |   in   | reset | load | inc |   out   |\n");

        // Test Case 1: Initial state
        #0;
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 2: Increment without load/reset
        #1;
        in = 16'b0;       reset = 1'b0;  load = 1'b0;  inc = 1'b1; // Increment
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 3: Increment again
        #1;
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 4: Load a value
        #1;
        in = -32123;      reset = 1'b0;  load = 1'b1;  inc = 1'b0; // Load value
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 5: Increment after load
        #1;
        reset = 1'b0;  load = 1'b0;  inc = 1'b1; // Increment
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 6: Load another value
        #1;
        load = 1'b1;  inc = 1'b0; // Load value
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 7: Reset the counter
        #1;
        reset = 1'b1;  load = 1'b0;  inc = 1'b0; // Reset
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 8: Load a new value
        #1;
        in = 12345;       reset = 1'b0;  load = 1'b1;  inc = 1'b0; // Load new value
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 9: Increment the loaded value
        #1;
        load = 1'b0;  inc = 1'b1; // Increment
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 10: Reset again
        #1;
        reset = 1'b1;  load = 1'b0;  inc = 1'b0; // Reset
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 11: Load a value after reset
        #1;
        in = 22222;       reset = 1'b0;  load = 1'b1;  inc = 1'b0; // Load new value
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Test Case 12: Increment the new value
        #1;
        load = 1'b0;  inc = 1'b1; // Increment
        $fwrite(output_file, "| %2d.%1d | %6d |   %1b   |   %1b  |  %1b  |  %6d |\n", $time / 10, $time % 10, in, reset, load, inc, out);

        // Close the output file
        $fclose(output_file); // Close the output file
        #10 $finish; // End the simulation
    end

endmodule