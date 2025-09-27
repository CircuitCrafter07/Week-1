// Testbench for the dff_syncres module
`timescale 1ns / 1ps

module dff_syncres_tb;

  // Inputs
  reg clk;
  reg async_reset;
  reg sync_reset;
  reg d;

  // Outputs
  wire q;

  // Instantiate the Unit Under Test (UUT)
  dff_syncres UUT (
    .clk(clk),
    .async_reset(async_reset),
    .sync_reset(sync_reset),
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
    $dumpfile("dff_syncres.vcd");
    $dumpvars(0, dff_syncres_tb);

    // Initialize inputs
    async_reset = 1'b0;
    sync_reset = 1'b0;
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

    // Test synchronous reset
    sync_reset = 1'b1;
    d = 1'b1; // d is high, but sync_reset should force q to 0
    #10;
    sync_reset = 1'b0;
    #10;
    
    // Test that async_reset has no effect (as it's not used in the RTL)
    d = 1'b1;
    async_reset = 1'b1;
    #10;
    async_reset = 1'b0;
    d = 1'b0;
    #10;
    
    // Test a final normal operation
    d = 1'b1;
    #10;
    
    $finish; // End simulation
  end
endmodule
