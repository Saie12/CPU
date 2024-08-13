module Inc16_tb;
    reg [15:0] in;
    wire [15:0] out;

    // Instantiate the Inc16 module
    Inc16 uut (
        .in(in),
        .out(out)
    );

    // File descriptor for output file
    integer file;

    initial begin
        $dumpfile("Inc16.vcd");
        $dumpvars(0, Inc16_tb);
        // Open the output file
        file = $fopen("Inc16.out", "w");
        
        
        // Write the header to the file
        $fdisplay(file, "|        in        |       out        |");

        // Test cases
        in = 16'h0000; #10;
        $fdisplay(file, "| %016b | %016b |", in, out);

        in = 16'h0001; #10;
        $fdisplay(file, "| %016b | %016b |", in, out);

        in = 16'hFFFF; #10;
        $fdisplay(file, "| %016b | %016b |", in, out);

        in = 16'h7FFF; #10;
        $fdisplay(file, "| %016b | %016b |", in, out);

        in = 16'hAAAA; #10;
        $fdisplay(file, "| %016b | %016b |", in, out);

        in = 16'h5555; #10;
        $fdisplay(file, "| %016b | %016b |", in, out);

        // Close the output file
        $fclose(file);
        
        // End simulation
        $finish;
    end
endmodule