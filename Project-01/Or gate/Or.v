module Or (
    input wire a,
    input wire b,
    output wire out
);

wire nota;
wire notb;

wire notaAndnotb;

// Demorgan's Law:- A or B = Not((Not a) & (Not b))
assign nota = ~a;
assign notb = ~b;

assign notaAndnotb = nota & notb;

assign out = ~notaAndnotb;

endmodule