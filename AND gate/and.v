module And (
    input wire a,  // Input A
    input wire b,  // Input B
    output wire out  // Output out
);

// Intermediate wire for Nand output
wire aNandb;

// Implementing AND using NAND gates
//  aNandb = NOT(a AND b) using NAND gate
assign aNandb = ~(a & b); // aNandb = a NAND b

//  out = NOT(aNandb) using NAND gate
assign out = ~(aNandb & aNandb); // out = NOT(aNandb) = aNandb NAND aNandb

endmodule