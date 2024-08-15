`timescale 1ns / 1ps

module Bit_tb;

    // Testbench signals
    reg in;           // Input value to the register
    reg load;         // Load control signal
    wire out;        // Output value of the register

    // Instantiate the Bit module
    Bit uut (
        .in(in),
        .load(load),
        .out(out)
    );

    // File for output
    integer output_file;

    // Initial block for simulation
    initial begin
        $dumpfile("Bit.vcd");
        $dumpvars(0, Bit_tb);
        // Open the output file
        output_file = $fopen("Bit.out", "w");
        if (output_file == 0) begin
            $display("Error opening output file.");
            $finish;
        end

        // Test cases
        // Test case 1: Load input value
        in = 1; load = 1; #10; // Load 1
        $fwrite(output_file, "Time: %0t, Load: %b, In: %b, Out: %b\n", $time, load, in, out);

        // Test case 2: Retain value
        load = 0; #10; // Retain value
        $fwrite(output_file, "Time: %0t, Load: %b, In: %b, Out: %b\n", $time, load, in, out);

        // Test case 3: Change input and load
        in = 0; load = 1; #10; // Load 0
        $fwrite(output_file, "Time: %0t, Load: %b, In: %b, Out: %b\n", $time, load, in, out);

        // Test case 4: Retain value
        load = 0; #10; // Retain value
        $fwrite(output_file, "Time: %0t, Load: %b, In: %b, Out: %b\n", $time, load, in, out);

        // Test case 5: Load new value
        in = 1; load = 1; #10; // Load 1
        $fwrite(output_file, "Time: %0t, Load: %b, In: %b, Out: %b\n", $time, load, in, out);

        // Test case 6: Retain value
        load = 0; #10; // Retain value
        $fwrite(output_file, "Time: %0t, Load: %b, In: %b, Out: %b\n", $time, load, in, out);

        // Close the output file
        $fclose(output_file);

        // Finish the simulation
        $finish;
    end

endmodule