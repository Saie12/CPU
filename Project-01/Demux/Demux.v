module demux_1_to_2 (
    input wire in,        // Data input
    input wire sel,       // Selection line
    output reg a,        // Output a
    output reg b         // Output b
);

always @(*) begin
    // Default outputs
    a = 0;
    b = 0;

    case (sel)
        1'b0: begin
            a = in; // When sel is 0, output a follows in
            b = 0;  // Output b is 0
        end
        1'b1: begin
            a = 0;  // Output a is 0
            b = in; // When sel is 1, output b follows in
        end
    endcase
end

endmodule