module And16_using_NAND (
    input  [15:0] a,  // 16-bit input a
    input  [15:0] b,  // 16-bit input b
    output [15:0] out // 16-bit output out
);

    wire [15:0] nand_out; // Intermediate wires for NAND outputs

    // Generate NAND gates for each bit
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : nand_gates
            assign nand_out[i] = ~(a[i] & b[i]); // NAND operation
            assign out[i] = ~(nand_out[i] & nand_out[i]); // AND operation using NAND
        end
    endgenerate

endmodule