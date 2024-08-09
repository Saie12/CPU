module half_adder (
    input wire A,      // First input bit
    input wire B,      // Second input bit
    output wire Sum,   // Sum output
    output wire Carry  // Carry output
);

// Logic for Sum and Carry
assign Sum = A ^ B;     // Sum is the XOR of A and B
assign Carry = A & B;   // Carry is the AND of A and B

endmodule