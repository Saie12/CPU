`timescale 1ns / 1ps

module tb_Or16_using_NAND;

    // Inputs
    reg [15:0] a;  // 16-bit input a
    reg [15:0] b;  // 16-bit input b

    // Output
    wire [15:0] out; // 16-bit output

    // Instantiate the Or16_using_NAND module
    Or16_using_NAND uut (
        .a(a),
        .b(b),
        .out(out)
    );

    // File handling
    integer output_file; // File for output results
    integer i;          // Loop variable
    reg [15:0] expected_output; // Variable to store expected output

    // Initialize the testbench
    initial begin
        $dumpfile("Or16.vcd"); // Specify the output VCD file
        $dumpvars(0, tb_Or16_using_NAND);  // Dump all variables in the testbench

        // Open the output file for writing
        output_file = $fopen("Or16.out", "w");

        // Write header to the output file
        $fwrite(output_file, "|        a         |        b         |       out        |\n");

        // Test all combinations of a and b
        for (i = 0; i < 256; i = i + 1) begin
            a = i;            // Set a to the current value of i
            b = 8'hFF;       // Set b to 0xFF for testing
            
            // Wait for a short time to allow the output to settle
            #10;

            // Calculate expected output
            expected_output = a | b;

            // Write the inputs and output to the output file in the specified format
            $fwrite(output_file, "| %016b | %016b | %016b |\n", a, b, out);
        end

        // Close the output file
        $fclose(output_file);
        
        // Finish the simulation
        $finish;
    end

endmodule