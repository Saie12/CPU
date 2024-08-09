`timescale 1ns / 1ps

module Not_tb;

reg a;

wire out;

Not uut (
    .a(a),
    .out(out)
);

integer output_file;

initial begin
    $dumpfile("Not.vcd");
    $dumpvars(0, Not_tb);  

    output_file = $fopen("Not.out", "w");

    $fwrite(output_file, "|   a   |  out  |\n");
    a = 0; #10 $fwrite(output_file, "|   %b   |   %b   |\n", a, out);
    a = 1; #10 $fwrite(output_file, "|   %b   |   %b   |", a, out);

    $fclose(output_file);
    $finish;
end
    
endmodule