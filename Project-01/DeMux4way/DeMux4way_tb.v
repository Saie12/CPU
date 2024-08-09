module DeMux4way_tb;
    reg din;              // Data input
    reg [1:0] select;    // Select lines
    wire a, b, c, d;     // Outputs

    // Instantiate the demux
    DeMux4way uut (
        .din(din),
        .select(select),
        .a(a),
        .b(b),
        .c(c),
        .d(d)
    );

    integer output_file;

    initial begin
        $dumpfile("DeMux4way.vcd");
        $dumpvars(0, DeMux4way_tb);
        // Open the output file
        
        output_file = $fopen("DeMux4way.out", "w");
        
        // Write the header
        $fwrite(output_file, "| din | sel  |  a  |  b  |  c  |  d  |\n");

        // Test cases for din = 0
        din = 0;

        // Test select = 00
        select = 2'b00;
        #10; // Wait for 10 time units
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", din, select, a, b, c, d);

        // Test select = 01
        select = 2'b01;
        #10; // Wait for 10 time units
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", din, select, a, b, c, d);

        // Test select = 10
        select = 2'b10;
        #10; // Wait for 10 time units
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", din, select, a, b, c, d);

        // Test select = 11
        select = 2'b11;
        #10; // Wait for 10 time units
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", din, select, a, b, c, d);

        // Test cases for din = 1
        din = 1;

        // Test select = 00
        select = 2'b00;
        #10; // Wait for 10 time units
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", din, select, a, b, c, d);

        // Test select = 01
        select = 2'b01;
        #10; // Wait for 10 time units
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", din, select, a, b, c, d);

        // Test select = 10
        select = 2'b10;
        #10; // Wait for 10 time units
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", din, select, a, b, c, d);

        // Test select = 11
        select = 2'b11;
        #10; // Wait for 10 time units
        $fwrite(output_file, "|  %b  |  %b  |  %b  |  %b  |  %b  |  %b  |\n", din, select, a, b, c, d);

        // Close the output file
        $fclose(output_file);
        
        // End simulation
        $finish;
    end

    initial begin
        // Monitor the output
        $monitor("din=%b, select=%b, a=%b, b=%b, c=%b, d=%b", din, select, a, b, c, d);
    end
endmodule