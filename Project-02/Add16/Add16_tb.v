module Add16_tb;
    reg [15:0] a, b;
    wire [15:0] out;
    wire cout;

    // Instantiate the Add16 module
    Add16 uut (
        .a(a), .b(b),
        .out(out), .cout(cout)
    );

    // File descriptor for output file
    integer file;

    initial begin
        $dumpfile("Add16.vcd");
        $dumpvars(0, Add16_tb);
        // Open the output file
        file = $fopen("Add16.out", "w");
        
        
        // Write the header to the file
        $fdisplay(file, "|        a         |        b         |       out        |");

        // Test cases
        a = 16'h0000; b = 16'h0000; #10;
        $fdisplay(file, "| %016b | %016b | %016b |", a, b, out);

        a = 16'h0000; b = 16'hFFFF; #10;
        $fdisplay(file, "| %016b | %016b | %016b |", a, b, out);

        a = 16'hFFFF; b = 16'hFFFF; #10;
        $fdisplay(file, "| %016b | %016b | %016b |", a, b, out);

        a = 16'hAAAA; b = 16'h5555; #10;
        $fdisplay(file, "| %016b | %016b | %016b |", a, b, out);

        a = 16'h33C3; b = 16'h0FF0; #10;
        $fdisplay(file, "| %016b | %016b | %016b |", a, b, out);

        a = 16'h0948; b = 16'h9876; #10;
        $fdisplay(file, "| %016b | %016b | %016b |", a, b, out);

        // Close the output file
        $fclose(file);
        
        // End the simulation
        $finish;
    end
endmodule