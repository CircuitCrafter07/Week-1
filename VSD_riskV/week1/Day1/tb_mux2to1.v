`timescale 1ns/1ps

module tb_mux2to1;
    reg a, b, sel;       // testbench drives inputs
    wire y;              // output from DUT

    // Instantiate the DUT (Device Under Test)
    mux2to1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        // Create VCD file for waveform
        $dumpfile("mux2to1.vcd");   // output filename
        $dumpvars(0, tb_mux2to1);   // dump all signals in this testbench

        // Monitor signals on console
        $monitor("Time=%0t | a=%b b=%b sel=%b -> y=%b", $time, a, b, sel, y);

        // Initialize inputs
        a = 0; b = 0; sel = 0;
        #10;

        // Apply test vectors
        a = 0; b = 1; sel = 0; #10;
        a = 0; b = 1; sel = 1; #10;
        a = 1; b = 0; sel = 0; #10;
        a = 1; b = 0; sel = 1; #10;
        a = 1; b = 1; sel = 0; #10;
        a = 1; b = 1; sel = 1; #10;

        // Finish simulation
        $finish;
    end
endmodule

