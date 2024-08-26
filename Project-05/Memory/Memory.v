module Memory (
    input [15:0] in,           // Input data
    input load,                // Load signal
    input [14:0] address,      // Address input (15 bits)
    output reg [15:0] out      // Output data
);

    // Internal signals
    wire [15:0] ram_out;       // Output from RAM
    wire [15:0] screen_out;    // Output from Screen
    wire [15:0] keyboard_out;  // Output from Keyboard
    wire ram_load;             // Load signal for RAM
    wire screen_load;          // Load signal for Screen
    wire keyboard_load;        // Load signal for Keyboard
    wire [13:0] ram_address;   // Address for RAM
    wire [12:0] screen_address; // Address for Screen

    // Address decoding
    assign ram_load = load & (address[14] == 1'b0); // Load to RAM if address is in RAM space
    assign screen_load = load & (address >= 15'h4000) & (address < 15'h6000); // Load to Screen
    assign keyboard_load = address == 15'h6000; // Load to Keyboard at address 0x6000

    assign ram_address = address[13:0]; // RAM address (0 to 16383)
    assign screen_address = address[12:0]; // Screen address (0 to 8191)

    // RAM instantiation
    RAM16K ram (
        .in(in),
        .load(ram_load),
        .address(ram_address),
        .out(ram_out)
    );

    // Screen and Keyboard instantiation
    Screen screen (
        .in(in),
        .load(screen_load),
        .address(screen_address),
        .out(screen_out)
    );

    Keyboard keyboard (
        .out(keyboard_out)
    );

    // Output logic
    always @(*) begin
        if (address > 15'h6000) begin
            out = 16'b0; // Invalid access
        end else if (address >= 15'h4000 && address < 15'h6000) begin
            out = screen_out; // Access Screen
        end else if (address == 15'h6000) begin
            out = keyboard_out; // Access Keyboard
        end else begin
            out = ram_out; // Access RAM
        end
    end

endmodule