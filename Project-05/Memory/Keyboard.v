// Keyboard Module Implementation
module Keyboard (
    output reg [15:0] out      // Output data
);
    initial begin
        out = 16'hFFFF; // Simulate a key press as a constant output
    end
endmodule
