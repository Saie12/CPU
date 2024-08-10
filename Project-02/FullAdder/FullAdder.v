module full_adder (
    input wire A,        // First input bit
    input wire B,        // Second input bit
    input wire Cin,      // Carry input
    output wire Sum,     // Sum output
    output wire Cout     // Carry output
);

// Logic for Sum and Carry
assign Sum = A ^ B ^ Cin;     // Sum is the XOR of A, B, and Cin
assign Cout = (A & B) | (Cin & (A ^ B)); // Carry is generated from A and B or Cin with the XOR of A and B

endmodule