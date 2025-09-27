module rca (
    input [7:0] num1,
    input [7:0] num2,
    output [8:0] sum
);
wire [7:0] int_sum;
wire [7:0] int_co;

genvar i;
generate
    for (i = 1; i < 8; i = i + 1) begin
        fa u_fa_1 (.a(num1[i]), .b(num2[i]), .c(int_co[i-1]), .co(int_co[i]), .sum(int_sum[i]));
    end
endgenerate

fa u_fa_0 (.a(num1[0]), .b(num2[0]), .c(1'b0), .co(int_co[0]), .sum(int_sum[0]));

assign sum[7:0] = int_sum;
assign sum[8] = int_co[7];
endmodule
module fa (input a, input b, input c, output co, output sum);
    assign {co, sum} = a + b + c;
endmodule
module rca_tb;

    // Declare signals for the DUT inputs and outputs
    reg [7:0] num1;
    reg [7:0] num2;
    wire [8:0] sum;

    // Instantiate the module under test (DUT)
    rca dut (
        .num1(num1),
        .num2(num2),
        .sum(sum)
    );

    // Initial block to generate test vectors and control the simulation
    initial begin
        // Open the VCD file for waveform dumping
        $dumpfile("rca.vcd");
        // Dump all signals in the current scope for viewing in a waveform viewer
        $dumpvars(0, rca_tb);

        // Initialize inputs
        num1 = 8'h00;
        num2 = 8'h00;
        #10;
        $display("Time = %0t: %h + %h = %h", $time, num1, num2, sum);

        // Test case 1: Simple addition
        num1 = 8'd5;
        num2 = 8'd3;
        #10;
        $display("Time = %0t: %h + %h = %h", $time, num1, num2, sum);

        // Test case 2: Check carry propagation
        num1 = 8'h0F;
        num2 = 8'h01;
        #10;
        $display("Time = %0t: %h + %h = %h", $time, num1, num2, sum);

        // Test case 3: Multi-bit carry propagation
        num1 = 8'hFF;
        num2 = 8'h01;
        #10;
        $display("Time = %0t: %h + %h = %h", $time, num1, num2, sum);

        // Test case 4: Maximum sum value
        num1 = 8'hFF;
        num2 = 8'hFF;
        #10;
        $display("Time = %0t: %h + %h = %h", $time, num1, num2, sum);

        // End the simulation
        #10;
        $finish;
    end

    // Example of a generate block in the testbench.
    // This block is used for structural generation and won't affect the
    // adder's behavior, but it demonstrates the requested feature.
    genvar gv;
    generate
        for (gv = 0; gv < 2; gv = gv + 1) begin : tb_gen_block
            reg [7:0] test_vector;
            initial begin
                test_vector = gv;
                $display("Time = %0t: Generate block instance %0d created with value %h", $time, gv, test_vector);
            end
        end
    endgenerate

endmodule

