module RAM #(
    parameter SIZE = 16 * 1024  // Default size
) (
    input wire [13:0] address,  // Address input
    input wire [15:0] in,       // Data input
    input wire write,           // Write enable
    output reg [15:0] out       // Data output
);

    // RAM memory array
    reg [15:0] memory [0:SIZE-1];

    // Read or write operations
    always @(posedge write) begin
        if (write) begin
            memory[address] <= in; // Write data to RAM
        end
        out <= memory[address];  // Read data from RAM
    end

endmodule
