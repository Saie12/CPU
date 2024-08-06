module DeMux4way(
    input din,            // Data input
    input [1:0] select,  // Select lines
    output reg a,        // Output 0
    output reg b,        // Output 1
    output reg c,        // Output 2
    output reg d         // Output 3
);

    always @(*) begin
        // Initialize outputs to 0
        a = 0;
        b = 0;
        c = 0;
        d = 0;

        // Select the output based on the select lines
        case (select)
            2'b00: a = din;  // Route input to output a
            2'b01: b = din;  // Route input to output b
            2'b10: c = din;  // Route input to output c
            2'b11: d = din;  // Route input to output d
            default: begin
                a = 0;
                b = 0;
                c = 0;
                d = 0;
            end
        endcase
    end

endmodule