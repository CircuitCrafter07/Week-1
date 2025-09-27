// This is the module under test, provided by the user.
// It's an 8-to-1 demultiplexer implemented with a for loop.
module demux_generate (
    output o0, output o1, output o2, output o3,
    output o4, output o5, output o6, output o7,
    input [2:0] sel,
    input i
);
reg [7:0] y_int;
assign {o7, o6, o5, o4, o3, o2, o1, o0} = y_int;
integer k;

always @(*) begin
    y_int = 8'b0;
    for (k = 0; k < 8; k = k + 1) begin
        if (k == sel) begin
            y_int[k] = i;
        end
    end
end
endmodule

// This is the testbench module for the demux_generate.
// It provides stimulus and verifies the behavior of the demultiplexer.
module demux_generate_tb;

    // Declare signals for the DUT inputs and outputs
    reg [2:0] sel;
    reg i;
    wire o0, o1, o2, o3, o4, o5, o6, o7;

    // Instantiate the module under test (DUT)
    demux_generate dut (
        .o0(o0), .o1(o1), .o2(o2), .o3(o3),
        .o4(o4), .o5(o5), .o6(o6), .o7(o7),
        .sel(sel),
        .i(i)
    );

    // Initial block to generate test vectors and control the simulation
    initial begin
        // Open the VCD file for waveform dumping
        $dumpfile("demux_generate.vcd");
        // Dump all signals in the current scope for viewing in a waveform viewer
        $dumpvars(0, demux_generate_tb);

        // Initialize inputs
        sel = 3'b000;
        i = 1'b0;

        // Apply a series of test vectors to check all 8 select lines
        $display("Time = %0t: Initial state, i=%b, sel=%b, outputs={%b%b%b%b%b%b%b%b}", $time, i, sel, o7, o6, o5, o4, o3, o2, o1, o0);

        // Test with i = 1
        i = 1'b1;
        #10;

        // Loop through all possible select values
        for (integer k = 0; k < 8; k = k + 1) begin
            sel = k;
            #10;
            $display("Time = %0t: i=%b, sel=%b, outputs={%b%b%b%b%b%b%b%b}", $time, i, sel, o7, o6, o5, o4, o3, o2, o1, o0);
        end

        // Test with i = 0
        i = 1'b0;
        #10;
        $display("Time = %0t: i=%b, sel=%b, outputs={%b%b%b%b%b%b%b%b}", $time, i, sel, o7, o6, o5, o4, o3, o2, o1, o0);

        // End the simulation
        #10;
        $finish;
    end
    
    // Example of a generate block as requested.
    // This block is used for structural generation and won't affect the
    // demultiplexer's behavior, but it demonstrates the requested feature.
    genvar gv;
    generate
        for (gv = 0; gv < 8; gv = gv + 1) begin : demux_output_check
            // A simple task that prints which output is selected, if i=1
            always @(sel) begin
                if (sel == gv) begin
                    $display("Generate Block: Output o%0d is selected at time %0t", gv, $time);
                end
            end
        end
    endgenerate

endmodule

