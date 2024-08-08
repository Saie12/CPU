module mux8way16(
    input [15:0] a, b, c, d, e, f, g, h,
    input [2:0] sel,
    output [15:0] out
);

assign out = (sel == 3'b000) ? a :
            (sel == 3'b001) ? b :
            (sel == 3'b010) ? c :
            (sel == 3'b011) ? d :
            (sel == 3'b100) ? e :
            (sel == 3'b101) ? f :
            (sel == 3'b110) ? g :
            (sel == 3'b111) ? h : 16'bx;

endmodule