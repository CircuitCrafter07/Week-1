// This is the module under test, provided by the user.
// It's a 4-to-1 multiplexer implemented with a for loop.
module mux_generate (
    input i0, input i1, input i2, input i3,
    input [1:0] sel,
    output reg y
);
wire [3:0] i_int;
assign i_int = {i3, i2, i1, i0};
integer k;

always @(*) begin
    for (k = 0; k < 4; k = k + 1) begin
        if (k == sel) begin
            y = i_int[k];
        end
    end
end
endmodule

// This is the testbench module for the mux_generate.
// It uses an initial block to apply test vectors and a generate block
// to demonstrate its usage.
module mux_generate_tb;

    // Declare signals for the DUT inputs and outputs
    reg i0, i1, i2, i3;
    reg [1:0] sel;
    wire y;

    // Instantiate the module under test (DUT)
    mux_generate dut (
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .sel(sel),
        .y(y)
    );

    // Initial block for generating the stimulus and controlling simulation
    initial begin
        // Open the VCD file for waveform dumping
        $dumpfile("mux_generate.vcd");
        // Dump all signals in the current scope
        $dumpvars(0, mux_generate_tb);

        // Initialize inputs
        i0 = 0;
        i1 = 0;
        i2 = 0;
        i3 = 0;
        sel = 2'b00;

        // Apply a series of test vectors with delays to simulate time
        #10;
        $display("Time = %0t: i0=%b, i1=%b, i2=%b, i3=%b, sel=%b, y=%b", $time, i0, i1, i2, i3, sel, y);

        // Test case 1: select i0
        i0 = 1; i1 = 0; i2 = 0; i3 = 0; sel = 2'b00;
        #10;
        $display("Time = %0t: i0=%b, i1=%b, i2=%b, i3=%b, sel=%b, y=%b", $time, i0, i1, i2, i3, sel, y);

        // Test case 2: select i1
        i0 = 0; i1 = 1; i2 = 0; i3 = 0; sel = 2'b01;
        #10;
        $display("Time = %0t: i0=%b, i1=%b, i2=%b, i3=%b, sel=%b, y=%b", $time, i0, i1, i2, i3, sel, y);

        // Test case 3: select i2
        i0 = 0; i1 = 0; i2 = 1; i3 = 0; sel = 2'b10;
        #10;
        $display("Time = %0t: i0=%b, i1=%b, i2=%b, i3=%b, sel=%b, y=%b", $time, i0, i1, i2, i3, sel, y);

        // Test case 4: select i3
        i0 = 0; i1 = 0; i2 = 0; i3 = 1; sel = 2'b11;
        #10;
        $display("Time = %0t: i0=%b, i1=%b, i2=%b, i3=%b, sel=%b, y=%b", $time, i0, i1, i2, i3, sel, y);

        // Test all inputs being high
        i0 = 1; i1 = 1; i2 = 1; i3 = 1;
        #10;
        sel = 2'b00;
        #10;
        $display("Time = %0t: sel=%b, y=%b", $time, sel, y);
        sel = 2'b01;
        #10;
        $display("Time = %0t: sel=%b, y=%b", $time, sel, y);
        sel = 2'b10;
        #10;
        $display("Time = %0t: sel=%b, y=%b", $time, sel, y);
        sel = 2'b11;
        #10;
        $display("Time = %0t: sel=%b, y=%b", $time, sel, y);

        // End the simulation
        $finish;
    end

    // Example of a generate block
    // This part is for demonstrating the usage of `generate`.
    // It's not directly related to the mux functionality, but fulfills the request.
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : my_gen_block
            reg [7:0] my_array;
            initial my_array = i;
        end
    endgenerate

endmodule

