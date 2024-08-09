`timescale 1ns / 1ps

module Or_tb;

reg a;
reg b;

wire out;

Or uut (
    .a(a),
    .b(b),
    .out(out)
);

integer output_file;

initial begin
    $dumpfile("Or.vcd");
    $dumpvars(0, Or_tb);

    output_file = $fopen("Or.out", "w");

    $fwrite(output_file, "|   a   |   b   |  out  |\n");

    a = 0; b = 0; #10 $fwrite(output_file, "|   %b   |   %b   |   %b   |\n", a, b, out);
    
    a = 0; b = 1; #10 $fwrite(output_file, "|   %b   |   %b   |   %b   |\n", a, b, out);
    
    a = 1; b = 0; #10 $fwrite(output_file, "|   %b   |   %b   |   %b   |\n", a, b, out);
    
    a = 1; b = 1; #10 $fwrite(output_file, "|   %b   |   %b   |   %b   |", a, b, out);

    $fclose(output_file);
    $finish;
end

endmodule