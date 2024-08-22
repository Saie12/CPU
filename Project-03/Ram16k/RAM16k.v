module RAM16K (
    input wire clk,                // Clock signal
    input wire [13:0] address,     // 14-bit address to select one of 16384 registers
    input wire [15:0] in,           // 16-bit input data to be written
    input wire load,                // Load signal
    output reg [15:0] out           // 16-bit output data
);

    // Declare an array of 16384 registers, each 16 bits wide
    reg [15:0] memory [0:16383];

    // Always block to handle read and write operations
    always @(posedge clk) begin
        if (load) begin
            // Write data to the specified address if load is high
            memory[address] <= in;
        end
    end

    // Always block to handle reading from memory
    always @(*) begin
        // Output the value stored at the specified address
        out = memory[address];
    end

endmodule