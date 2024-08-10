module test_full_adder;

// Declare inputs and outputs
reg A;
reg B;
reg Cin;
wire Sum;
wire Cout;

// Instantiate the full adder
full_adder fa (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

// File descriptor for output
integer file;

// Test procedure
initial begin
    $dumpfile("FullAdder.vcd");
    $dumpvars(0, test_full_adder);
    // Open the output file
    file = $fopen("FullAdder.out", "w");
    
    // Print the table header to the file
    $fdisplay(file, "|   A   |   B   |  Cin  |  Sum  | Cout |");
    
    // Test all combinations of A, B, and Cin
    A = 0; B = 0; Cin = 0; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |   %b  |", A, B, Cin, Sum, Cout);
    
    A = 0; B = 0; Cin = 1; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |   %b  |", A, B, Cin, Sum, Cout);
    
    A = 0; B = 1; Cin = 0; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |   %b  |", A, B, Cin, Sum, Cout);
    
    A = 0; B = 1; Cin = 1; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |   %b  |", A, B, Cin, Sum, Cout);
    
    A = 1; B = 0; Cin = 0; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |   %b  |", A, B, Cin, Sum, Cout);
    
    A = 1; B = 0; Cin = 1; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |   %b  |", A, B, Cin, Sum, Cout);
    
    A = 1; B = 1; Cin = 0; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |   %b  |", A, B, Cin, Sum, Cout);
    
    A = 1; B = 1; Cin = 1; #10;
    $fdisplay(file, "|   %b   |   %b   |   %b   |   %b   |   %b  |", A, B, Cin, Sum, Cout);
    
    // Close the output file
    $fclose(file);
    
    $finish; // End the simulation
end

endmodule