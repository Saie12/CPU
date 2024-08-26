module Screen (
    input [15:0] in,           // Input data
    input load,                // Load signal
    input [12:0] address,      // Address input for screen memory
    output reg [15:0] out      // Output data
);
    reg [15:0] memory [0:8191]; // Screen memory (8K words)

    // Handle load operation
    always @(posedge load) begin
        if (load) begin
            memory[address] <= in; // Load data into screen memory
        end
    end

    // Handle read operation
    always @(*) begin
        out = memory[address]; // Output the value from screen memory
    end
endmodule
