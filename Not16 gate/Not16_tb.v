`timescale 1ns / 1ps

module tb_not16;

    // Inputs
    reg [15:0] in;

    // Outputs
    wire [15:0] out;

    // Instantiate the DUT (Device Under Test)
    not16 dut (
        .in(in),
        .out(out)
    );

    // File for output
    integer output_file;
    
    initial begin
        $dumpfile("Not16.vcd");
        $dumpvars(0, tb_not16);

        // Open the output file
        output_file = $fopen("Not16.out", "w");
        
        // Write the header
        $fwrite(output_file, "|        in        |       out        |\n");

        // Test cases
        test_case(16'b0000000000000000);
        test_case(16'b1111111111111111);
        test_case(16'b1010101010101010);
        test_case(16'b0011110011000011);
        test_case(16'b0001001000110100);

        // Close the file
        $fclose(output_file);
        
        // End the simulation
        $finish;
    end

    // Task to apply input and write output
    task test_case(input [15:0] test_in);
        begin
            in = test_in;
            #10; // Wait for some time to allow output to stabilize
            $fwrite(output_file, "| %b | %b |\n", in, out);
        end
    endtask

endmodule