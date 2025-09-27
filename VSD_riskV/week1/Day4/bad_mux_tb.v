`timescale 1ns / 1ps

module bad_mux_tb;

  // Declarations for the Unit Under Test (UUT)
  reg i0;
  reg i1;
  reg sel;
  wire y;

  // Instantiate the module to be tested
  bad_mux uut (
    .i0(i0),
    .i1(i1),
    .sel(sel),
    .y(y)
  );

  // VCD file generation
  initial begin
    // Open the VCD file
    $dumpfile("bad_mux.vcd");
    // Specify which signals to dump. Here, we dump all signals in the current scope.
    $dumpvars(0, bad_mux_tb);
  end

  // Initial block for stimulus generation
  initial begin
    // Initialize inputs to a known state
    i0 = 1'b0;
    i1 = 1'b0;
    sel = 1'b0;

    // Wait for a short period
    #10;

    // Test case 1: sel = 0, y should be i0
    i0 = 1'b1;
    i1 = 1'b0;
    sel = 1'b0;
    #10;
    $display("Time=%0d, sel=%b, i0=%b, i1=%b, y=%b", $time, sel, i0, i1, y);
    $display("Expected y = %b", i0);

    // Test case 2: sel = 1, y should be i1
    i0 = 1'b0;
    i1 = 1'b1;
    sel = 1'b1;
    #10;
    $display("Time=%0d, sel=%b, i0=%b, i1=%b, y=%b", $time, sel, i0, i1, y);
    $display("Expected y = %b", i1);

    // Test case 3: Change inputs while sel is high
    i0 = 1'b1;
    i1 = 1'b0;
    #10;
    $display("Time=%0d, sel=%b, i0=%b, i1=%b, y=%b", $time, sel, i0, i1, y);
    $display("Expected y = %b", i1);

    // Test case 4: Change sel again to see if it updates
    sel = 1'b0;
    #10;
    $display("Time=%0d, sel=%b, i0=%b, i1=%b, y=%b", $time, sel, i0, i1, y);
    $display("Expected y = %b", i0);

    // End of simulation
    $finish;
  end

endmodule
