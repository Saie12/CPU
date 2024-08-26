// RAM16K.v
module RAM16K(input [15:0] in, input load, input [13:0] address, output reg [15:0] out);
    // Example memory array, not the actual implementation
    reg [15:0] memory [0:16383];  // 16K words of memory
    always @(*) begin
        if (load) begin
            memory[address] = in;
        end
        out = memory[address];
    end
endmodule