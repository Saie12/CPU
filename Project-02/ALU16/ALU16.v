module ALU16 (
    input [15:0] a,          // First operand (16 bits)
    input [15:0] b,          // Second operand (16 bits)
    input [3:0] control,     // Control signal to select the operation
    output reg [15:0] out,   // Output result (16 bits)
    output reg zero,         // Zero flag (1 bit)
    output reg carry,        // Carry flag (1 bit)
    output reg overflow,     // Overflow flag (1 bit)
    output reg negative       // Negative flag (1 bit)
);

    // Control signal definitions for different ALU operations
    localparam ADD  = 4'b0000; // Addition
    localparam SUB  = 4'b0001; // Subtraction
    localparam AND  = 4'b0010; // Bitwise AND
    localparam OR   = 4'b0011; // Bitwise OR
    localparam XOR  = 4'b0100; // Bitwise XOR
    localparam SLL  = 4'b0101; // Shift Left Logical
    localparam SRL  = 4'b0110; // Shift Right Logical
    localparam SRA  = 4'b0111; // Shift Right Arithmetic

    // Always block to perform operations based on the control signal
    always @(*) begin
        // Initialize outputs and flags to default values
        out = 16'b0;            // Default output is zero
        zero = 1'b0;           // Default zero flag is false
        carry = 1'b0;          // Default carry flag is false
        overflow = 1'b0;       // Default overflow flag is false
        negative = 1'b0;       // Default negative flag is false
        
        // Perform the operation based on the control signal
        case (control)
            ADD: begin
                {carry, out} = a + b; // Perform addition and capture carry
                // Check for overflow: if the signs of the operands are the same
                // and differ from the sign of the result, overflow has occurred
                overflow = (a[15] == b[15]) && (out[15] != a[15]);
            end
            SUB: begin
                {carry, out} = a - b; // Perform subtraction and capture carry
                // Check for overflow: if the signs of the operands are different
                // and the sign of the result differs from the sign of the first operand
                overflow = (a[15] != b[15]) && (out[15] != a[15]);
            end
            AND: out = a & b; // Perform bitwise AND
            OR:  out = a | b; // Perform bitwise OR
            XOR: out = a ^ b; // Perform bitwise XOR
            SLL: out = a << 1; // Shift left logical by 1
            SRL: out = a >> 1; // Shift right logical by 1
            SRA: out = $signed(a) >>> 1; // Shift right arithmetic by 1
            default: out = 16'b0; // Default case, output zero
        endcase
        
        // Set the zero flag: true if the output is zero
        zero = (out == 16'b0);
        
        // Set the negative flag: true if the sign bit (MSB) of the output is 1
        negative = out[15]; // The sign bit of the result
    end
endmodule