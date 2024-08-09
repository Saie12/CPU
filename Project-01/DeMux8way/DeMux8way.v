// 4-way Demultiplexer Module
module DMux4Way (
    input wire in,
    input wire [1:0] sel,
    output wire a, b, c, d
);
    assign a = (sel == 2'b00) ? in : 1'b0;
    assign b = (sel == 2'b01) ? in : 1'b0;
    assign c = (sel == 2'b10) ? in : 1'b0;
    assign d = (sel == 2'b11) ? in : 1'b0;
endmodule

// 2-way Demultiplexer Module
module DMux (
    input wire in,
    input wire sel,
    output wire a, b
);
    assign a = (sel == 1'b0) ? in : 1'b0;
    assign b = (sel == 1'b1) ? in : 1'b0;
endmodule

// 8-way Demultiplexer Module
module DMux8Way (
    input wire in,
    input wire [2:0] sel,
    output wire a, b, c, d, e, f, g, h
);
    wire aeCase, bfCase, cgCase, dhCase;

    // First level: 4-way demultiplexer
    DMux4Way demux4 (
        .in(in),
        .sel(sel[1:0]),
        .a(aeCase),
        .b(bfCase),
        .c(cgCase),
        .d(dhCase)
    );

    // Second level: Distributing outputs
    DMux demux_a (
        .in(aeCase),
        .sel(sel[2]),
        .a(a),
        .b(e)
    );

    DMux demux_b (
        .in(bfCase),
        .sel(sel[2]),
        .a(b),
        .b(f)
    );

    DMux demux_c (
        .in(cgCase),
        .sel(sel[2]),
        .a(c),
        .b(g)
    );

    DMux demux_d (
        .in(dhCase),
        .sel(sel[2]),
        .a(d),
        .b(h)
    );
endmodule