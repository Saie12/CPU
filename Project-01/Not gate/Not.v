module Not (
    input wire a,
    output wire out

);

wire ananda;

assign ananda = ~(a & a);
assign out  = ananda;
    
endmodule