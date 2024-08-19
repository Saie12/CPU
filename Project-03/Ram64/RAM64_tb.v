`timescale 1ns / 1ps

module tb_RAM64;

    // Parameters
    parameter ADDRESS_WIDTH = 6; // 3 bits for 8 addresses
    parameter DATA_WIDTH = 16;    // 16 bits for data

    // Inputs
    reg [ADDRESS_WIDTH-1:0] address; // Address input
    reg [DATA_WIDTH-1:0] in;          // Data input
    reg load;                          // Load signal

    // Outputs
    wire [DATA_WIDTH-1:0] out;        // Output data

    // Instantiate the RAM8 module
    RAM64 uut (
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
        // Open the output file
        output_file = $fopen("RAM64.out", "w");
        

        // Dump waveform data to VCD file
        $dumpfile("RAM64.vcd");
        $dumpvars(0, tb_RAM64);

        for (i = 0; i < 64; i = i + 1) begin
            address = i;
            in = 16'h5A5A + i;
            load = 1;
            #10;
            $fwrite(output_file, "Address: %b, Written Data: %h\n", address, in);

            #10;

            load = 0;
            #10;
            $fwrite(output_file, "Address: %b, Written Data: %h\n", address, in);
        end

        // Read from all addresses
        for (i = 0; i < 64; i = i + 1) begin
            address = i;
            #10;
            $fwrite(output_file, "Address: %b, Read Data: %h\n", address, out);
        end

        // Close the output file
        $fclose(output_file);

        $finish;

        
    end

endmodule