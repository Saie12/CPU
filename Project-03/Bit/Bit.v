// 1-Bit Register Module
// This module implements a 1-bit register that loads a new value 
// based on the load signal. If load is 1, the register updates 
// its output with the input value; otherwise, it retains its 
// current value.

module Bit (
    input wire in,       // Input value to be stored in the register
    input wire load,     // Control signal to determine loading behavior
    output reg out       // Output value of the register
);

    // Always block triggered on the positive edge of the load signal
    always @(posedge load or negedge load) begin
        // Check if the load signal is active (1)
        if (load) begin
            out <= in;  // Load the new input value into the output
        end
        // If load is 0, the output retains its current value (no action needed)
    end

endmodule