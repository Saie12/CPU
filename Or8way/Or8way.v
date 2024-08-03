module Or8_using_NAND (
    input  [7:0] a,  // 8-bit input a
    input  [7:0] b,  // 8-bit input b
    output [7:0] out // 8-bit output out
);

    wire [7:0] nand_out; // Intermediate wires for NAND outputs

    // Generate NAND gates for each bit
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : nand_gates
            assign nand_out[i] = (~a[i]) & (~b[i]); // NAND operation
            assign out[i] = ~(nand_out[i]); // Or operation using NAND
        end
    endgenerate

endmodule