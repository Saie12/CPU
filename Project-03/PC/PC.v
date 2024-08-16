// 16-bit Program Counter Module
module ProgramCounter (
    input wire [15:0] in,     // 16-bit input value for loading
    input wire load,          // Load control signal
    input wire inc,           // Increment control signal
    input wire reset,         // Reset control signal
    output reg [15:0] out     // 16-bit output value (current PC)
);

    // Always block triggered on the rising edge of the clock
    // or when any of the control signals change
    always @(*) begin
        // Check the reset signal first
        if (reset) begin
            out = 16'b0; // Set output to 0 if reset is high
        end else if (load) begin
            out = in; // Load the input value if load is high
        end else if (inc) begin
            out = out + 1; // Increment the current value if inc is high
        end else begin
            out = out; // Hold the current value if no control signals are active
        end
    end

endmodule