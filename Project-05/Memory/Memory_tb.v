`timescale 1ns / 1ps


module tb_Memory;

    // Testbench signals
    reg [15:0] in;              // Input data
    reg load;                   // Load signal
    reg [14:0] address;         // Address input
    wire [15:0] out;            // Output data

    integer log_file;           // Log file descriptor
    integer i;                  // Loop variable

    // Instantiate the Memory module
    Memory memory (
        .in(in),
        .load(load),
        .address(address),
        .out(out)
    );

    // Open output file and VCD file
    initial begin
        $dumpfile("Memory.vcd");
        $dumpvars(0, tb_Memory);

        // Open output file for logging
        log_file = $fopen("Memory.out", "w");
        if (log_file == 0) begin
            $display("Error: Could not open Memory.out for writing.");
            $finish;
        end
    end

    // Test procedure
    initial begin
        // Initialize inputs
        in = 16'b0;
        load = 0;
        address = 15'b0;

        // Test RAM functionality using a loop
        $display("Testing RAM functionality...");
        for (i = 0; i < 16; i = i + 1) begin
            address = i; // Test addresses 0x0000 to 0x000F
            in = 16'hA0 + i; // Example data (0xA0 to 0xAF)
            load = 1; // Enable loading
            #10; // Wait for a short period
            load = 0; // Disable loading
            #10; // Wait for a short period

            // Read back from RAM
            address = i;
            #10;
            if (out !== in) begin
                $display("Error: Expected 0x%h, got %h at address 0x%h", in, out, address);
                $fwrite(log_file, "Error: Expected 0x%h, got %h at address 0x%h\n", in, out, address);
            end else begin
                $display("RAM Test Passed: Read 0x%h from address 0x%h", out, address);
                $fwrite(log_file, "RAM Test Passed: Read 0x%h from address 0x%h\n", out, address);
            end
        end

        // Test Screen functionality using a loop
        $display("Testing Screen functionality...");
        for (integer i = 0; i < 16; i = i + 1) begin
                address = 15'h4000 + i; // Test addresses 0x4000 to 0x400F
                in = 16'hB0 + i; // Example data (0xB0 to 0xBF)
                load = 1; // Enable loading
                #10; // Wait for a short period
                load = 0; // Disable loading
                #20; // Wait for a short period

            // Read back from Screen
            address = 15'h4000 + i;
            #10;
            if (out !== in) begin
                $display("Error: Expected 0x%h, got %h at address 0x%h", in, out, address);
                $fwrite(log_file, "Error: Expected 0x%h, got %h at address 0x%h\n", in, out, address);
            end else begin
                $display("Screen Test Passed: Read 0x%h from address 0x%h", out, address);
                $fwrite(log_file, "Screen Test Passed: Read 0x%h from address 0x%h\n", out, address);
            end
        end

        // Test Keyboard functionality
        $display("Testing Keyboard functionality...");
        address = 15'h6000; // Simulate reading from Keyboard address 0x6000
        #10; // Wait for a short period
        if (out !== 16'hFFFF) begin
            $display("Error: Expected 0xFFFF, got %h", out);
            $fwrite(log_file, "Error: Expected 0xFFFF, got %h\n", out);
        end else begin
            $display("Keyboard Test Passed: Read 0x%h from address 0x%h", out, address);
            $fwrite(log_file, "Keyboard Test Passed: Read 0x%h from address 0x%h\n", out, address);
        end


        

        // Test invalid address access
        $display("Testing invalid address access...");
        address = 15'h7000; // Invalid address
        #10; // Wait for a short period
        if (out !== 16'b0) begin
            $display("Error: Expected 0x0000, got %h", out);
            $fwrite(log_file, "Error: Expected 0x0000, got %h\n", out);
        end else begin
            $display("Invalid Address Test Passed: Read 0x%h from address 0x%h", out, address);
            $fwrite(log_file, "Invalid Address Test Passed: Read 0x%h from address 0x%h\n", out, address);
        end

        // Close output file
        $fclose(log_file);
        $finish;
    end

endmodule
