module Inc16 (
    input [15:0] in,
    output [15:0] out
);
    // Increment the input by 1
    assign out = in + 1;
endmodule