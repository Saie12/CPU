`timescale 1ns / 1ps

module tb_mux16;

    reg [15:0] a;       // First 16-bit input
    reg [15:0] b;       // Second 16-bit input
    reg sel;         // Select signal
    wire [15:0] out;    // Output

    // Instantiate the MUX
    Mux16 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    // File for output
    integer output_file;

    initial begin
        $dumpfile("Mux16.vcd");
        $dumpvars(0, tb_mux16);
        // Open the output file
        output_file = $fopen("Mux16.out", "w");
        
        // Write the header
        $fwrite(output_file, "|        a         |        b         | sel |       out        |\n");

        // Test cases
        a = 16'b0000000000000000; // Input a
        b = 16'b0000000000000000; // Input b

        // Test select = 0 (should output a)
        sel = 0;
        #10; // Wait for 10 time units
        $fwrite(output_file, "| %b | %b |  %b  | %b |\n", a, b, sel, out);

        // Test select = 1 (should output b)
        sel = 1;
        #10; // Wait for 10 time units
        $fwrite(output_file, "| %b | %b |  %b  | %b |\n", a, b, sel, out);

        // Change inputs
        b = 16'b0001001000110100; // New input b

        // Test select = 0 (should output a)
        sel = 0;
        #10; // Wait for 10 time units
        $fwrite(output_file, "| %b | %b |  %b  | %b |\n", a, b, sel, out);

        // Test select = 1 (should output b)
        sel = 1;
        #10; // Wait for 10 time units
        $fwrite(output_file, "| %b | %b |  %b  | %b |\n", a, b, sel, out);

        // Change inputs
        a = 16'b1001100001110110; // New input a
        b = 16'b0000000000000000; // New input b

        // Test select = 0 (should output a)
        sel = 0;
        #10; // Wait for 10 time units
        $fwrite(output_file, "| %b | %b |  %b  | %b |\n", a, b, sel, out);

        // Test select = 1 (should output b)
        sel = 1;
        #10; // Wait for 10 time units
        $fwrite(output_file, "| %b | %b |  %b  | %b |\n", a, b, sel, out);

        // Change inputs
        a = 16'b1010101010101010; // New input a
        b = 16'b0101010101010101; // New input b

        // Test select = 0 (should output a)
        sel = 0;
        #10; // Wait for 10 time units
        $fwrite(output_file, "| %b | %b |  %b  | %b |\n", a, b, sel, out);

        // Test select = 1 (should output b)
        sel = 1;
        #10; // Wait for 10 time units
        $fwrite(output_file, "| %b | %b |  %b  | %b |\n", a, b, sel, out);

        // Close the file
        $fclose(output_file);
        
        // End simulation
        $finish;
    end
endmodule