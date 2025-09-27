`timescale 1ns/1ps

module mux_tb;

  // Declare testbench signals as registers and wires
  reg i0;
  reg i1;
  reg sel;
  wire y;

  // Instantiate the Device Under Test (DUT)
  mux DUT (
    .i0(i0),
    .i1(i1),
    .sel(sel),
    .y(y)
  );

  // Initial block to apply test stimuli and setup VCD dumping
  initial begin
    // Specify the VCD file and the scope to dump
    $dumpfile("mux.vcd");
    $dumpvars(0, mux_tb);

    // Display initial values
    $display("Time | i0 | i1 | sel | y");
    $display("%4t | %2b | %2b | %3b | %2b", $time, i0, i1, sel, y);
    #10;

    // Test Case 1: sel = 0, y should be i0
    i0 = 1'b1;
    i1 = 1'b0;
    sel = 1'b0;
    $display("%4t | %2b | %2b | %3b | %2b", $time, i0, i1, sel, y);
    #10;
    
    // Test Case 2: sel = 0, y should be i0
    i0 = 1'b0;
    i1 = 1'b1;
    sel = 1'b0;
    $display("%4t | %2b | %2b | %3b | %2b", $time, i0, i1, sel, y);
    #10;

    // Test Case 3: sel = 1, y should be i1
    i0 = 1'b0;
    i1 = 1'b1;
    sel = 1'b1;
    $display("%4t | %2b | %2b | %3b | %2b", $time, i0, i1, sel, y);
    #10;

    // Test Case 4: sel = 1, y should be i1
    i0 = 1'b1;
    i1 = 1'b0;
    sel = 1'b1;
    $display("%4t | %2b | %2b | %3b | %2b", $time, i0, i1, sel, y);
    #10;

    // Finish the simulation
    $finish;
  end

endmodule
