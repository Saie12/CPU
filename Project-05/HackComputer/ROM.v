module ROM #(
    parameter SIZE = 32*1024  // Default size is 32K words
) (
    input wire [$clog2(SIZE)-1:0] address,  // Address input
    output wire [15:0] out                  // Instruction output
);

    // ROM memory array
    reg [15:0] memory [0:SIZE-1];

    // Initialize ROM with a program (make sure the file exists and is in the correct path)
    initial begin
        $readmemh("program.hex", memory, 0, 255);  // Load only a portion for testing
    end

    // Output the instruction at the given address
    assign out = memory[address];

endmodule
