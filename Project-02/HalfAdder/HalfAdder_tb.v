module test_half_adder;

// Declare inputs and outputs
reg A;
reg B;
wire Sum;
wire Carry;

// Instantiate the half adder
half_adder ha (
    .A(A),
    .B(B),
    .Sum(Sum),
    .Carry(Carry)
);

// File descriptor for output
integer file;

// Test procedure
initial begin
    $dumpfile("HalfAdder.vcd");
    $dumpvars(0, test_half_adder);
    // Open the output file
    file = $fopen("HalfAdder.out", "w");
    
    // Print the table header to the file
    $fdisplay(file, "|   a   |   b   |  sum  | carry |");
    
    // Test all combinations of A and B
    A = 0; B = 0; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |", A, B, Sum, Carry);
    
    A = 0; B = 1; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |", A, B, Sum, Carry);
    
    A = 1; B = 0; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |", A, B, Sum, Carry);
    
    A = 1; B = 1; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |", A, B, Sum, Carry);
    
    // Close the output file
    $fclose(file);
    
    $finish; // End the simulation
end

endmodule