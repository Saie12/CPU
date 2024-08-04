`timescale 1ns / 1ps

module Mux_tb;

    reg a;      // Declare input a
    reg b;      // Declare input b
    reg sel;    // Declare select signal

    wire out;   // Declare output

    // Instantiate the Mux module
    Mux uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    integer output_file;

    initial begin
        $dumpfile("Mux.vcd");
        $dumpvars(0, Mux_tb);

        // Open output file for writing results
        output_file = $fopen("Mux.out", "w");
        $fwrite(output_file, "|   a   |   b   |  sel  |  out  |\n");

        // Test all combinations of a, b, and sel
        // Test case 1: A = 0, B = 0
        a = 0; b = 0; sel = 0; #10; // Wait for 10 time units
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", a, b, sel, out);

        sel = 1; #10; // Wait for 10 time units
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", a, b, sel, out);

        // Test case 2: A = 0, B = 1
        a = 0; b = 1; sel = 0; #10; // Wait for 10 time units
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", a, b, sel, out);

        sel = 1; #10; // Wait for 10 time units
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", a, b, sel, out);

        // Test case 3: A = 1, B = 0
        a = 1; b = 0; sel = 0; #10; // Wait for 10 time units
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", a, b, sel, out);

        sel = 1; #10; // Wait for 10 time units
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", a, b, sel, out);

        // Test case 4: A = 1, B = 1
        a = 1; b = 1; sel = 0; #10; // Wait for 10 time units
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", a, b, sel, out);

        sel = 1; #10; // Wait for 10 time units
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", a, b, sel, out);

        // Close the output file and finish the simulation
        $fclose(output_file);
        $finish;
    end

endmodule