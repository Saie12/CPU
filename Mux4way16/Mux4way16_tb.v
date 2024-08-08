`timescale 1ns / 1ps

module tb_mux4way16;

    // Inputs
    reg [15:0] a, b, c, d;
    reg [1:0] sel;

    // Output
    wire [15:0] out;

    // Instantiate the multiplexer
    mux4way16 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out)
    );

    // File for output
    integer file;

    initial begin
        $dumpfile("Mux4way16.vcd");
        $dumpvars(0, tb_mux4way16);
        // Open the output file
        file = $fopen("Mux4way16.out", "w");

        // Write the header
        $fwrite(file, "|        a         |        b         |        c         |        d         | sel  |       out        |\n");

        // Test cases
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 2'b00);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 2'b01);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 2'b10);
        test_case(16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 16'b0000000000000000, 2'b11);
        test_case(16'b0001001000110100, 16'b1001100001110110, 16'b1010101010101010, 16'b0101010101010101, 2'b00);
        test_case(16'b0001001000110100, 16'b1001100001110110, 16'b1010101010101010, 16'b0101010101010101, 2'b01);
        test_case(16'b0001001000110100, 16'b1001100001110110, 16'b1010101010101010, 16'b0101010101010101, 2'b10);
        test_case(16'b0001001000110100, 16'b1001100001110110, 16'b1010101010101010, 16'b0101010101010101, 2'b11);

        // Close the output file
        $fclose(file);
        $finish;
    end

    // Task to apply inputs and write output
    task test_case(input [15:0] a_input, input [15:0] b_input, input [15:0] c_input, input [15:0] d_input, input [1:0] sel_input);
        begin
            // Assign inputs
            a = a_input;
            b = b_input;
            c = c_input;
            d = d_input;
            sel = sel_input;

            // Wait for a time unit for the output to stabilize
            #10;

            // Write the results to the file
            $fwrite(file, "| %016b | %016b | %016b | %016b |  %02b  | %016b |\n", a, b, c, d, sel, out);
        end
    endtask

endmodule