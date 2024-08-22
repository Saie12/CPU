`timescale 1ns / 1ps

module tb_RAM4K;

    // Parameters
    parameter ADDRESS_WIDTH = 12; // 12 bits for 4096 addresses
    parameter DATA_WIDTH = 16;    // 16 bits for data

    // Inputs
    reg clk;                         // Clock signal
    reg [ADDRESS_WIDTH-1:0] address; // Address input
    reg [DATA_WIDTH-1:0] in;         // Data input
    reg load;                        // Load signal

    // Outputs
    wire [DATA_WIDTH-1:0] out;       // Output data

    // Instantiate the RAM4K module
    RAM4K uut (
        .clk(clk),
        .address(address),
        .in(in),
        .load(load),
        .out(out)
    );

    // File handling
    integer output_file;
    integer i;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Initial block
    initial begin
        // Open the output file
        output_file = $fopen("output_file.txt", "w");
        if (output_file == 0) begin
            $display("Error: Could not open output_file.txt");
            $finish;
        end

        // Dump waveform data to VCD file (optional)
        $dumpfile("RAM4K.vcd");
        $dumpvars(0, tb_RAM4K);

        // Test sequence
        // Write to all addresses
        for (i = 0; i < 4096; i = i + 1) begin
            address = i;                       // Set the address
            in = 16'h5A5A + i;                // Set the data to write
            load = 1;                         // Set load to 1 to enable writing
            #10;                               // Wait for 10 time units to allow writing
            $fwrite(output_file, "Address: %b, Written Data: %h\n", address, in);

            load = 0;                         // Set load to 0 to disable writing
            #10;                               // Wait for 10 time units before the next operation
        end

        // Add a delay to allow for all writes to settle
        #20;

        // Read from all addresses
        for (i = 0; i < 4096; i = i + 1) begin
            address = i;                      // Set the address to read
            #10;                              // Wait for 10 time units to allow reading
            $fwrite(output_file, "Address: %b, Read Data: %h\n", address, out);
        end

        // Close the output file
        $fclose(output_file);

        // Finish simulation
        $finish;
    end

endmodule