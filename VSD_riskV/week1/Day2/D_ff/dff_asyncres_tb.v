// Testbench for the dff_asyncres module
`timescale 1ns / 1ps

module dff_asyncres_tb;

  // Inputs
  reg clk;
  reg async_reset;
  reg d;

  // Outputs
  wire q;

  // Instantiate the Unit Under Test (UUT)
  dff_asyncres UUT (
    .clk(clk),
    .async_reset(async_reset),
    .d(d),
    .q(q)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 ns period
  end

  // Test sequence
  initial begin
    // Dump waves to VCD file
    $dumpfile("dff_asyncres.vcd");
    $dumpvars(0, dff_asyncres_tb);

    // Initialize inputs
    async_reset = 1'b0;
    d = 1'b0;

    // Wait for a few clock cycles for stability
    #20;

    // Test normal operation
    d = 1'b1; // d changes, q will change on next posedge clk
    #10;
    d = 1'b0; // d changes, q will change on next posedge clk
    #10;
    d = 1'b1;
    #10;

    // Test asynchronous reset
    // Reset happens immediately, not waiting for the clock edge
    async_reset = 1'b1;
    d = 1'b0; // change d just to show it doesn't matter
    #5; // Wait for the reset to take effect
    async_reset = 1'b0; // Release the reset
    #5;

    // Test a final normal operation
    d = 1'b1;
    #10;
    
    $finish; // End simulation
  end
endmodule
