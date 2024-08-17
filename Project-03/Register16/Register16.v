
module reg16(
    input clk,       // Clock input
    input rst,       // Reset input
    input ld,        // Load signal
    input [15:0] d,  // 16-bit input data
    output reg [15:0] q // 16-bit output data
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 16'b0; // Reset the register to 0
        end else if (ld) begin
            q <= d; // Load the input data into the register
        end
    end

endmodule