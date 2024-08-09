`timescale 1ns / 1ps

module And_tb;

// Inputs
reg a;
reg b;

// Output
wire out;

// Instantiate the And module
And uut (
    .a(a),
    .b(b),
    .out(out)
);

// Output file
integer output_file;

// Initial block to apply test cases
initial begin
    $dumpfile("And.vcd"); // Specify the output VCD file
    $dumpvars(0, And_tb);  // Dump all variables in the testbench
    
    // Open the output file for writing
    output_file = $fopen("and.out", "w");
    
    // Write the header to the output file
    $fwrite(output_file, "|   a   |   b   |  out  |\n");

    // Apply all combinations of inputs (00, 01, 10, 11)
    a = 0; b = 0; #10 $fwrite(output_file, "|   %b   |   %b   |   %b   |\n", a, b, out);
    
    a = 0; b = 1; #10 $fwrite(output_file, "|   %b   |   %b   |   %b   |\n", a, b, out);
    
    a = 1; b = 0; #10 $fwrite(output_file, "|   %b   |   %b   |   %b   |\n", a, b, out);
    
    a = 1; b = 1; #10 $fwrite(output_file, "|   %b   |   %b   |   %b   |", a, b, out);

    // Close the output file
    $fclose(output_file);
    $finish; // End the simulation
end

endmodule