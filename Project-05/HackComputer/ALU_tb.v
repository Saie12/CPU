`timescale 1ns / 1ps

module ALU_tb;

    // Inputs to the ALU
    reg [15:0] x;
    reg [15:0] y;
    reg zx;
    reg nx;
    reg zy;
    reg ny;
    reg f;
    reg no;

    // Outputs from the ALU
    wire [15:0] out;
    wire zr;
    wire ng;

    // Instantiate the ALU
    ALU uut (
        .x(x),
        .y(y),
        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),
        .out(out),
        .zr(zr),
        .ng(ng)
    );

    integer logFile;

    // Testbench procedure
    initial begin
        // Open the log file
        
        logFile = $fopen("ALU_tb.out", "w");
        if (logFile == 0) begin
            $display("Error: Unable to open ALU_tb.out for writing.");
            $finish;
        end

        // Test cases
        // Test Case 1: Basic AND operation
        x = 16'h00FF; y = 16'h0F0F; zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        $fwrite(logFile, "Time: %0t | x: %0h | y: %0h | zx: %b | nx: %b | zy: %b | ny: %b | f: %b | no: %b | out: %0h | zr: %b | ng: %b\n", 
                $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);

        // Test Case 2: Basic ADD operation
        x = 16'h00FF; y = 16'h0001; zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        $fwrite(logFile, "Time: %0t | x: %0h | y: %0h | zx: %b | nx: %b | zy: %b | ny: %b | f: %b | no: %b | out: %0h | zr: %b | ng: %b\n", 
                $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);

        // Test Case 3: Zero X input
        x = 16'h00FF; y = 16'h0F0F; zx = 1; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        $fwrite(logFile, "Time: %0t | x: %0h | y: %0h | zx: %b | nx: %b | zy: %b | ny: %b | f: %b | no: %b | out: %0h | zr: %b | ng: %b\n", 
                $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);

        // Test Case 4: Negate X input
        x = 16'h00FF; y = 16'h0F0F; zx = 0; nx = 1; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        $fwrite(logFile, "Time: %0t | x: %0h | y: %0h | zx: %b | nx: %b | zy: %b | ny: %b | f: %b | no: %b | out: %0h | zr: %b | ng: %b\n", 
                $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);

        // Test Case 5: Zero Y input
        x = 16'h00FF; y = 16'h0F0F; zx = 0; nx = 0; zy = 1; ny = 0; f = 0; no = 0;
        #10;
        $fwrite(logFile, "Time: %0t | x: %0h | y: %0h | zx: %b | nx: %b | zy: %b | ny: %b | f: %b | no: %b | out: %0h | zr: %b | ng: %b\n", 
                $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);

        // Test Case 6: Negate Y input
        x = 16'h00FF; y = 16'h0F0F; zx = 0; nx = 0; zy = 0; ny = 1; f = 0; no = 0;
        #10;
        $fwrite(logFile, "Time: %0t | x: %0h | y: %0h | zx: %b | nx: %b | zy: %b | ny: %b | f: %b | no: %b | out: %0h | zr: %b | ng: %b\n", 
                $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);

        // Test Case 7: Negate the output
        x = 16'h00FF; y = 16'h0F0F; zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 1;
        #10;
        $fwrite(logFile, "Time: %0t | x: %0h | y: %0h | zx: %b | nx: %b | zy: %b | ny: %b | f: %b | no: %b | out: %0h | zr: %b | ng: %b\n", 
                $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);

        // Close the log file and end the simulation
        $fclose(logFile);
        $finish;
    end

    // Monitor internal signals
    initial begin
        $monitor("Time: %0t | x: %0h | y: %0h | zx: %b | nx: %b | zy: %b | ny: %b | f: %b | no: %b | out: %0h | zr: %b | ng: %b", 
                 $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);
    end

endmodule
