module RAM #(
    parameter SIZE = 16*1024  // Default size is 16K words
) (
    input wire clk,                               // Clock input
    input wire [$clog2(SIZE)-1:0] address,        // Address input
    input wire [15:0] in,                         // Data input (to be written)
    output reg [15:0] out,                        // Data output (read from RAM)
    input wire load                               // Write enable signal
);

    // RAM memory array
    reg [15:0] memory [0:SIZE-1];

    // Write operation (on positive clock edge if load is enabled)
    always @(posedge clk) begin
        if (load) begin
            memory[address] <= in;
        end
    end

    // Read operation (asynchronous)
    always @(*) begin
        out = memory[address];
    end

endmodule
