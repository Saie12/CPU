module testbench;
    reg in;
    reg sel;
    wire a;
    wire b;

    demux_1_to_2 uut (
        .in(in),
        .sel(sel),
        .a(a),
        .b(b)
    );

    integer output_file; // Declare output file variable

    initial begin
        // Open output file for writing results
        output_file = $fopen("Demux.out", "w");
        $fwrite(output_file, "|  in   |  sel  |   a   |   b   |\n");

        // Test all combinations
        in = 0; sel = 0; #10; // a = 0, b = 0
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", in, sel, a, b);

        in = 0; sel = 1; #10; // a = 0, b = 0
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", in, sel, a, b);

        in = 1; sel = 0; #10; // a = 1, b = 0
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", in, sel, a, b);

        in = 1; sel = 1; #10; // a = 0, b = 1
        $fwrite(output_file, "|   %b   |   %b   |   %b   |   %b   |\n", in, sel, a, b);

        $fclose(output_file); // Close the output file
        $finish;
    end

    initial begin
        $dumpfile("Demux.vcd");
        $dumpvars(0, testbench);
    end
endmodule