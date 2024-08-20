module RAM512 (
    input wire [8:0] address,   // 9-bit address to select one of 512 registers
    input wire [15:0] in,       // 16-bit input data to be written
    input wire load,            // Load signal
    output reg [15:0] out       // 16-bit output data
);

    // Declare an array of 512 registers, each 16 bits wide
    reg [15:0] memory [0:511];

    // Always block to handle read and write operations
    always @(posedge load or negedge load) begin
        if (load) begin
            // Write data to the specified address
            memory[address] <= in;
        end
    end

    // Always block to handle reading from memory
    always @(*) begin
        // Output the value stored at the specified address
        out = memory[address];
    end

endmodule