`timescale 1ns / 1ps

module reg16_tb;

    // Inputs
    reg clk;
    reg rst;
    reg ld;
    reg [15:0] d;

    // Outputs
    wire [15:0] q;

    // Instantiate the register module
    reg16 uut (
        .clk(clk),
        .rst(rst),
        .ld(ld),
        .d(d),
        .q(q)
    );

    integer output_file;
    integer i;
    reg [15:0] test_inputs [0:21]; // Array to hold 22 test inputs



    initial begin
        // Open output file
        output_file = $fopen("Register16.out", "w");
        $dumpfile("Register16.vcd");
        $dumpvars(0, reg16_tb);
        
        // Write the header
        $fwrite(output_file, "| time |   in   | load |  out   |\n");

        // Initialize inputs
        clk = 0;
        rst = 0;
        ld = 0;
        d = 16'b0;

        // Initial state
        #1;
        $fwrite(output_file, "|  %0d+  | %d  |  %d  | %d  |\n", $time, d, ld, q);

        // Reset the register
        #1 rst = 1; // Assert reset
        #1 rst = 0; // Deassert reset

        // Define test inputs
        test_inputs[0]  = 16'h0000;     // 0
        test_inputs[1]  = 16'hFFFF;     // -32123
        test_inputs[2]  = 16'h1234;     // 11111
        test_inputs[3]  = 16'h3039;     // 12345
        test_inputs[4]  = 16'h0001;     // 1
        test_inputs[5]  = 16'h0002;     // 2
        test_inputs[6]  = 16'h0004;     // 4
        test_inputs[7]  = 16'h0008;     // 8
        test_inputs[8]  = 16'h0010;     // 16
        test_inputs[9]  = 16'h0020;     // 32
        test_inputs[10] = 16'h0040;     // 64
        test_inputs[11] = 16'h0080;     // 128
        test_inputs[12] = 16'h0100;     // 256
        test_inputs[13] = 16'hFFFE;     // -2
        test_inputs[14] = 16'hFFFD;     // -3
        test_inputs[15] = 16'hFF9B;     // -65
        test_inputs[16] = 16'hFFFB;     // -5
        test_inputs[17] = 16'hFFF7;     // -9
        test_inputs[18] = 16'h80A3;     // -129
        test_inputs[19] = 16'hA9B5;     // -643
        test_inputs[20] = 16'hFFCC;     // -54
        test_inputs[21] = 16'hFFB8;     // -74

        // Loop through each test input and manage time output
        for (i = 0; i < 22; i = i + 1) begin
            // Load data into the register
            #1 d = test_inputs[i]; // Load test input
            #1 ld = 1; // Assert load
            $fwrite(output_file, "|  %0d+  | %d  |  %d  | %d  |\n", $time, d, ld, q);

            #1;
            #1 ld = 0; // Deassert load
            #1; // Wait for one clock cycle
            
            // Print output for current time
            #1; // Wait for one clock cycle
            
            // Print output for next time
            $fwrite(output_file, "|  %0d   | %d  |  %d  | %d  |\n", $time, d, ld, q);
        end

        // End the simulation
        #10 $fclose(output_file);
        #10 $finish;
    end

    // Clock generation
    always #5 clk = ~clk;

endmodule