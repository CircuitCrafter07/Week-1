`timescale 1ns/1ps

module blocking_caveat_tb;

  // Declare testbench signals
  reg a;
  reg b;
  reg c;
  wire d;
  
  // Instantiate the Device Under Test (DUT)
  blocking_caveat DUT (
    .a(a),
    .b(b),
    .c(c),
    .d(d)
  );

  // Initial block for test stimulus and VCD dumping
  initial begin
    // Setup VCD file for waveform viewing
    $dumpfile("blocking_caveat.vcd");
    $dumpvars(0, blocking_caveat_tb);

    // Initial values for all inputs
    a = 1'b0;
    b = 1'b0;
    c = 1'b0;

    $display("Time | a | b | c | d");
    $display("%4t | %b | %b | %b | %b", $time, a, b, c, d);
    #10;

    // Test Case 1: a=1, b=0, c=1. Expected x=1, d=1
    a = 1'b1;
    $display("%4t | %b | %b | %b | %b", $time, a, b, c, d);
    #10;

    // Test Case 2: a=0, b=1, c=1. Expected x=1, d=1
    a = 1'b0;
    b = 1'b1;
    $display("%4t | %b | %b | %b | %b", $time, a, b, c, d);
    #10;

    // Test Case 3: a=1, b=1, c=0. Expected x=1, d=0
    a = 1'b1;
    b = 1'b1;
    c = 1'b0;
    $display("%4t | %b | %b | %b | %b", $time, a, b, c, d);
    #10;

    // Test Case 4: a=1, b=0, c=0. Expected x=1, d=0
    a = 1'b1;
    b = 1'b0;
    c = 1'b0;
    $display("%4t | %b | %b | %b | %b", $time, a, b, c, d);
    #10;

    $finish;
  end

endmodule

