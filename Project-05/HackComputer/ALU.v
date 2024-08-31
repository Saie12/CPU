module ALU (
    input wire [15:0] x,          // Operand X
    input wire [15:0] y,          // Operand Y
    input wire zx,                // Zero the X input
    input wire nx,                // Negate the X input
    input wire zy,                // Zero the Y input
    input wire ny,                // Negate the Y input
    input wire f,                 // Function code: 1 for Add, 0 for And
    input wire no,                // Negate the output
    output reg [15:0] out,        // Output of the ALU
    output wire zr,               // Zero flag
    output wire ng                // Negative flag
);

    // Internal signals
    reg [15:0] x1, y1, out1;

    // Preprocess X
    always @(*) begin
        x1 = zx ? 16'b0 : x;      // Zero X if zx is set
        if (nx) x1 = ~x1;         // Negate X if nx is set
    end

    // Preprocess Y
    always @(*) begin
        y1 = zy ? 16'b0 : y;      // Zero Y if zy is set
        if (ny) y1 = ~y1;         // Negate Y if ny is set
    end

    // Perform the ALU operation
    always @(*) begin
        if (f) begin
            out1 = x1 + y1;       // Add X and Y if f is set
        end else begin
            out1 = x1 & y1;       // AND X and Y if f is clear
        end
        if (no) begin
            out = ~out1;          // Negate the output if no is set
        end else begin
            out = out1;           // Otherwise, output the result directly
        end
    end

    // Set the zero flag (zr)
    assign zr = (out == 16'b0);

    // Set the negative flag (ng)
    assign ng = out[15];           // Check the MSB to determine if the result is negative

endmodule
