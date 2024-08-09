`timescale 1ns / 1ps

module DMux8Way_tb;

    // Inputs
    reg in;
    reg [2:0] sel;

    // Outputs
    wire a, b, c, d, e, f, g, h;

    // Instantiate the DMux8Way module
    DMux8Way uut (
        .in(in),
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h)
    );

    integer output_file;

    initial begin
        $dumpfile("DeMux8way.vcd");
        $dumpvars(0, DMux8Way_tb);
        // Open the output file
        
        output_file = $fopen("DeMux8way.out", "w");
        // Print table header
        $fwrite(output_file, "| in  |  sel  |  a  |  b  |  c  |  d  |  e  |  f  |  g  |  h  |\n");

        // Test case 1: in = 0, sel = 000
        in = 0; sel = 3'b000; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 2: in = 0, sel = 001
        in = 0; sel = 3'b001; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 3: in = 0, sel = 010
        in = 0; sel = 3'b010; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 4: in = 0, sel = 011
        in = 0; sel = 3'b011; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 5: in = 0, sel = 100
        in = 0; sel = 3'b100; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 6: in = 0, sel = 101
        in = 0; sel = 3'b101; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 7: in = 0, sel = 110
        in = 0; sel = 3'b110; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 8: in = 0, sel = 111
        in = 0; sel = 3'b111; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 9: in = 1, sel = 000
        in = 1; sel = 3'b000; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 10: in = 1, sel = 001
        in = 1; sel = 3'b001; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 11: in = 1, sel = 010
        in = 1; sel = 3'b010; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 12: in = 1, sel = 011
        in = 1; sel = 3'b011; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 13: in = 1, sel = 100
        in = 1; sel = 3'b100; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 14: in = 1, sel = 101
        in = 1; sel = 3'b101; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 15: in = 1, sel = 110
        in = 1; sel = 3'b110; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // Test case 16: in = 1, sel = 111
        in = 1; sel = 3'b111; #10;
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", 
                 in, sel, a, b, c, d, e, f, g, h);

        // End simulation after all tests
        $finish;
    end
endmodule