`timescale 1ns / 1ps

module tb_RAM512;

    // Parameters
    parameter ADDRESS_WIDTH = 9; // 9 bits for 512 addresses
    parameter DATA_WIDTH = 16;    // 16 bits for data

    // Inputs
    reg [ADDRESS_WIDTH-1:0] address; // Address input
    reg [DATA_WIDTH-1:0] in;         // Data input
    reg load;                        // Load signal

    // Outputs
    wire [DATA_WIDTH-1:0] out;       // Output data

    // Instantiate the RAM512 module
    RAM512 uut (
        .address(address),
        .in(in),
        .load(load),
        .out(out)
    );

    // File handling
    integer output_file;
    integer i;

    // Initial block
    initial begin
        // Dump waveform data to VCD file
        $dumpfile("RAM512.vcd");
        $dumpvars(0, tb_RAM512);

        // Open the output file
        output_file = $fopen("RAM512.out", "w");
        if (output_file == 0) begin
            $display("Error: Could not open output_file.txt");
            $finish;
        end

        // Dump waveform data to VCD file (optional)
        $dumpfile("RAM512.vcd");
        $dumpvars(0, tb_RAM512);

        // Test sequence
        // Write to all addresses
        for (i = 0; i < 512; i = i + 1) begin
            address = i;                       // Set the address
            in = 16'h5A5A + i;                // Set the data to write
            load = 1;                         // Set load to 1 to enable writing
            #10;                               // Wait for 10 time units to allow writing
            $fwrite(output_file, "Address: %b, Written Data: %h\n", address, in);

            load = 0;                         // Set load to 0 to disable writing
            #10;                               // Wait for 10 time units before the next operation
            $fwrite(output_file, "Address: %b, Written Data: %h\n", address, in);
        end

        // Add a delay to allow for all writes to settle
        #20;

        // Read from all addresses
        for (i = 0; i < 512; i = i + 1) begin
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