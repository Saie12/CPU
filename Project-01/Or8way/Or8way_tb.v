`timescale 1ns / 1ps

module tb_Or8_using_NAND;

    // Inputs
    reg [7:0] a;  // 8-bit input a
    reg [7:0] b;  // 8-bit input b

    // Output
    wire [7:0] out; // 8-bit output

    // Instantiate the Or8_using_NAND module
    Or8_using_NAND uut (
        .a(a),
        .b(b),
        .out(out)
    );

    // File handling
    integer output_file; // File for output results
    integer i, j;          // Loop variable
    reg [8:0] expected_output; // Variable to store expected output

    // Initialize the testbench
    initial begin
        $dumpfile("Or8way.vcd"); // Specify the output VCD file
        $dumpvars(0, tb_Or8_using_NAND);  // Dump all variables in the testbench

        // Open the output file for writing
        output_file = $fopen("Or8way.out", "w");

        // Write header to the output file
        $fwrite(output_file, "|      a       |      b       |     out      |\n");

        // Test all combinations of a and b
        for (i = 0; i < 256; i = i + 1) begin
            a = i;            // Set a to the current value of i
            
            b = 4'hFF;       // Set  to j for testing
            
            // Wait for a short time to allow the output to settle
                #10;

            // Calculate expected output
                expected_output = a | b;

            // Write the inputs and output to the output file in the specified format
                $fwrite(output_file, "|   %08b   |   %08b   |   %08b   |\n", a, b, out);
            
        end

        // Close the output file
        $fclose(output_file);
        
        // Finish the simulation
        $finish;
    end

endmodule