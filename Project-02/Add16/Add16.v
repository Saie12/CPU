module Add16 (
    input [15:0] a, b,
    output [15:0] out,
    output cout
);

    assign {cout, out} = a + b;

endmodule