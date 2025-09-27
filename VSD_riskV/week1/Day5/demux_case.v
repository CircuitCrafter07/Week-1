// This is the module under test, provided by the user.
// It's an 8-to-1 demultiplexer implemented with a case statement.
module demux_case (
    output o0, output o1, output o2, output o3,
    output o4, output o5, output o6, output o7,
    input [2:0] sel,
    input i
);
reg [7:0] y_int;
assign {o7, o6, o5, o4, o3, o2, o1, o0} = y_int;

always @(*) begin
    // Default to all zeros to prevent latches and to initialize outputs
    y_int = 8'b0;
    
    // Use a case statement to drive the selected output with the input value
    case(sel)
        3'b000 : y_int[0] = i;
        3'b001 : y_int[1] = i;
        3'b010 : y_int[2] = i;
        3'b011 : y_int[3] = i;
        3'b100 : y_int[4] = i;
        3'b101 : y_int[5] = i;
        3'b110 : y_int[6] = i;
        3'b111 : y_int[7] = i;
    endcase
end
endmodule

// This is the testbench module for the demux_case.
// It provides stimulus and verifies the behavior of the demultiplexer.
module demux_case_tb;

    // Declare signals for the DUT inputs and outputs
    reg [2:0] sel;
    reg i;
    wire o0, o1, o2, o3, o4, o5, o6, o7;

    // Instantiate the module under test (DUT)
    demux_case dut (
        .o0(o0), .o1(o1), .o2(o2), .o3(o3),
        .o4(o4), .o5(o5), .o6(o6), .o7(o7),
        .sel(sel),
        .i(i)
    );

    // Initial block to generate test vectors
    initial begin
        // Open the VCD file for waveform dumping
        $dumpfile("demux_case.vcd");
        // Dump all signals in the current scope for viewing in a waveform viewer
        $dumpvars(0, demux_case_tb);

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

