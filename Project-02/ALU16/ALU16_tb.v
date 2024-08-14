module ALU16_tb;
    // Declare registers for inputs
    reg [15:0] a, b;
    reg [3:0] control;
    
    // Declare wires for outputs
    wire [15:0] out;
    wire zero, carry, overflow, negative;

    // Instantiate the ALU16 module
    ALU16 uut (
        .a(a),
        .b(b),
        .control(control),
        .out(out),
        .zero(zero),
        .carry(carry),
        .overflow(overflow),
        .negative(negative)
    );

    // File descriptor for output file
    integer file;

    initial begin
        $dumpfile("ALU16.vcd");
        $dumpvars(0, ALU16_tb);
        // Open the output file
        file = $fopen("ALU16.out", "w");
        
        
        // Write the header to the file
        $fdisplay(file, "|         a        |        b         | control |       out        | zero | carry | overflow | negative |");

        // Test case 1: Addition
        a = 16'h0001; b = 16'h0001; control = 4'b0000; #10;
        $fdisplay(file, "| %016b | %016b |   %b  | %016b |   %b  |   %b   |    %b     |    %b     |", a, b, control, out, zero, carry, overflow, negative);

        // Test case 2: Subtraction
        a = 16'h0002; b = 16'h0001; control = 4'b0001; #10;
        $fdisplay(file, "| %016b | %016b |   %b  | %016b |   %b  |   %b   |    %b     |    %b     |", a, b, control, out, zero, carry, overflow, negative);

        // Test case 3: Bitwise AND
        a = 16'h000F; b = 16'h00F0; control = 4'b0010; #10;
        $fdisplay(file, "| %016b | %016b |   %b  | %016b |   %b  |   %b   |    %b     |    %b     |", a, b, control, out, zero, carry, overflow, negative);

        // Test case 4: Bitwise OR
        a = 16'h00F0; b = 16'h000F; control = 4'b0011; #10;
        $fdisplay(file, "| %016b | %016b |   %b  | %016b |   %b  |   %b   |    %b     |    %b     |", a, b, control, out, zero, carry, overflow, negative);

        // Test case 5: Bitwise XOR
        a = 16'h00F0; b = 16'h000F; control = 4'b0100; #10;
        $fdisplay(file, "| %016b | %016b |   %b  | %016b |   %b  |   %b   |    %b     |    %b     |", a, b, control, out, zero, carry, overflow, negative);

        // Test case 6: Shift Left Logical
        a = 16'h0001; b = 16'b0; control = 4'b0101; #10;
        $fdisplay(file, "| %016b | %016b |   %b  | %016b |   %b  |   %b   |    %b     |    %b     |", a, b, control, out, zero, carry, overflow, negative);

        // Test case 7: Shift Right Logical
        a = 16'h0002; b = 16'b0; control = 4'b0110; #10;
        $fdisplay(file, "| %016b | %016b |   %b  | %016b |   %b  |   %b   |    %b     |    %b     |", a, b, control, out, zero, carry, overflow, negative);

        // Test case 8: Shift Right Arithmetic
        a = 16'h8000; b = 16'b0; control = 4'b0111; #10;
        $fdisplay(file, "| %016b | %016b |   %b  | %016b |   %b  |   %b   |    %b     |    %b     |", a, b, control, out, zero, carry, overflow, negative);

        // Close the output file
        $fclose(file);
        
        // End the simulation
        $finish;
    end
endmodule