module partial_case_assign (
    input i0, input i1, input i2,
    input [1:0] sel,
    output reg y, output reg x
);
always @(*) begin
    case(sel)
        2'b00: begin
            y = i0;
            x = i2;
        end
        2'b01: y = i1;
        default: begin
            x = i1;
            y = i2;
        end
    endcase
end
endmodule

// Testbench for the partial_case_assign module

`timescale 1ns / 1ps

module tb_partial_case_assign;

    // Declarations for the module under test (MUT)
    reg i0, i1, i2;
    reg [1:0] sel;
    wire y, x;

    // Instantiate the module under test
    partial_case_assign uut (
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .sel(sel),
        .y(y),
        .x(x)
    );

    // VCD file generation for waveform viewing
    initial begin
        $dumpfile("partial_case_assign.vcd");
        $dumpvars(0, tb_partial_case_assign);
    end

    // Monitor for real-time console output
    initial begin
        $monitor("Time=%0t: sel=%b, i0=%b, i1=%b, i2=%b, y=%b, x=%b", $time, sel, i0, i1, i2, y, x);
    end

    // Test stimulus generation
    initial begin
        // Initialize inputs
        i0 = 0; i1 = 0; i2 = 0; sel = 2'b00;
        #10;

        // Test case 1: sel = 2'b00. Both y and x are assigned.
        i0 = 1; i2 = 0;
        #10;
        i0 = 0; i2 = 1;
        #10;

        // Test case 2: sel = 2'b01. 'y' is assigned, but 'x' is not.
        // 'x' should hold its previous value, which was 1.
        sel = 2'b01;
        i1 = 1;
        #10;
        i1 = 0;
        #10;

        // Test case 3: sel = 2'b10 (default). Both y and x are assigned.
        // 'x' should update based on i1, and 'y' based on i2.
        sel = 2'b10;
        i1 = 1; i2 = 0;
        #10;
        i1 = 0; i2 = 1;
        #10;

        // Test case 4: sel = 2'b11 (default).
        sel = 2'b11;
        i1 = 1; i2 = 0;
        #10;
        
        // End the simulation
        $finish;
    end

endmodule

