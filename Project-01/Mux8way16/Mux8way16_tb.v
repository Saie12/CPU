`timescale 1ns / 1ps

module tb_mux8way16;

    // Inputs
    reg [15:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;

    // Output
    wire [15:0] out;

    // Instantiate the multiplexer
    mux8way16 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h),
        .sel(sel),
        .out(out)
    );

    // File for output
    integer file;

    initial begin
        $dumpfile("Mux8way16.vcd");
        $dumpvars(0, tb_mux8way16);
        // Open the output file
        file = $fopen("Mux8way16.out", "w");

        // Write the header
        $fwrite(file, "|        a         |        b         |        c         |        d         |        e         |        f         |        g         |        h         |  sel  |       out        |\n");

        // Test cases with all inputs set to zero
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 
                  16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 3'b000);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 
                  16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 3'b001);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 
                  16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 3'b010);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 
                  16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 3'b011);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 
                  16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 3'b100);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 
                  16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 3'b101);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 
                  16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 3'b110);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 
                  16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 3'b111);

        // Test cases with non-zero inputs
        test_case(16'b0001001000110100, 16'b0010001101000101, 16'b0011010001010110, 16'b0100010101100111, 
                  16'b0101011001111000, 16'b0110011110001001, 16'b0111100010011010, 16'b1000100110101011, 3'b000);
        test_case(16'b0001001000110100, 16'b0010001101000101, 16'b0011010001010110, 16'b0100010101100111, 
                  16'b0101011001111000, 16'b0110011110001001, 16'b0111100010011010, 16'b1000100110101011, 3'b001);
        test_case(16'b0001001000110100, 16'b0010001101000101, 16'b0011010001010110, 16'b0100010101100111, 
                  16'b0101011001111000, 16'b0110011110001001, 16'b0111100010011010, 16'b1000100110101011, 3'b010);
        test_case(16'b0001001000110100, 16'b0010001101000101, 16'b0011010001010110, 16'b0100010101100111, 
                  16'b0101011001111000, 16'b0110011110001001, 16'b0111100010011010, 16'b1000100110101011, 3'b011);
        test_case(16'b0001001000110100, 16'b0010001101000101, 16'b0011010001010110, 16'b0100010101100111, 
                  16'b0101011001111000, 16'b0110011110001001, 16'b0111100010011010, 16'b1000100110101011, 3'b100);
        test_case(16'b0001001000110100, 16'b0010001101000101, 16'b0011010001010110, 16'b0100010101100111, 
                  16'b0101011001111000, 16'b0110011110001001, 16'b0111100010011010, 16'b1000100110101011, 3'b101);
        test_case(16'b0001001000110100, 16'b0010001101000101, 16'b0011010001010110, 16'b0100010101100111, 
                  16'b0101011001111000, 16'b0110011110001001, 16'b0111100010011010, 16'b1000100110101011, 3'b110);
        test_case(16'b0001001000110100, 16'b0010001101000101, 16'b0011010001010110, 16'b0100010101100111, 
                  16'b0101011001111000, 16'b0110011110001001, 16'b0111100010011010, 16'b1000100110101011, 3'b111);

        // Close the output file
        $fclose(file);
        $finish;
    end

    // Task to apply inputs and write output
    task test_case(input [15:0] a_input, input [15:0] b_input, input [15:0] c_input, input [15:0] d_input,
                input [15:0] e_input, input [15:0] f_input, input [15:0] g_input, input [15:0] h_input,
                input [2:0] sel_input);
        begin
            // Assign inputs
            a = a_input;
            b = b_input;
            c = c_input;
            d = d_input;
            e = e_input;
            f = f_input;
            g = g_input;
            h = h_input;
            sel = sel_input;

            // Wait for a time unit for the output to stabilize
            #10;

            // Write the results to the file
            $fwrite(file, "| %016b | %016b | %016b | %016b | %016b | %016b | %016b | %016b |  %03b  | %016b |\n", 
                    a, b, c, d, e, f, g, h, sel, out);
        end
    endtask

endmodule