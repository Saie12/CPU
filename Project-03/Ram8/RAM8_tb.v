`timescale 1ns / 1ps

module tb_RAM8;

    // Parameters
    parameter ADDRESS_WIDTH = 3; // 3 bits for 8 addresses
    parameter DATA_WIDTH = 16;    // 16 bits for data

    // Inputs
    reg [ADDRESS_WIDTH-1:0] address; // Address input
    reg [DATA_WIDTH-1:0] in;          // Data input
    reg load;                          // Load signal

    // Outputs
    wire [DATA_WIDTH-1:0] out;        // Output data

    // Instantiate the RAM8 module
    RAM8 uut (
        .address(address),
        .in(in),
        .load(load),
        .out(out)
    );

    // File handling
    integer output_file;

    // Initial block
    initial begin
        // Open the output file
        output_file = $fopen("RAM8.out", "w");
        

        // Dump waveform data to VCD file
        $dumpfile("RAM8.vcd");
        $dumpvars(0, tb_RAM8);

        // Test sequence
        // Test case 1: Write to address 0
        address = 3'b000; // Address 0
        in = 16'hA5A5;    // Data to write
        load = 1;         // Set load to 1
        #10;              // Wait for 10 time units
        load = 0;        // Clear load

        // Output the result
        $fwrite(output_file, "Address: %b, Written Data: %h, Read Data: %h\n", address, in, out);

        // Test case 2: Write to address 1
        address = 3'b001; // Address 1
        in = 16'h5A5A;    // Data to write
        load = 1;         // Set load to 1
        #10;              // Wait for 10 time units
        load = 0;        // Clear load

        // Output the result
        $fwrite(output_file, "Address: %b, Written Data: %h, Read Data: %h\n", address, in, out);

        // Test case 3: Read from address 0
        address = 3'b000; // Address 0
        #10;              // Wait for 10 time units

        // Output the result
        $fwrite(output_file, "Address: %b, Read Data: %h\n", address, out);

        // Test case 4: Read from address 1
        address = 3'b001; // Address 1
        #10;              // Wait for 10 time units

        // Output the result
        $fwrite(output_file, "Address: %b, Read Data: %h\n", address, out);

        // Test case 5: Write to address 2
        address = 3'b010; // Address 2
        in = 16'hFFFF;    // Data to write
        load = 1;         // Set load to 1
        #10;              // Wait for 10 time units
        load = 0;        // Clear load

        // Output the result
        $fwrite(output_file, "Address: %b, Written Data: %h, Read Data: %h\n", address, in, out);

        // Close the output file
        $fclose(output_file);

        // Finish simulation
        $finish;
    end

endmodule