module mux2to1 (
    input  wire a,      // Input 0
    input  wire b,      // Input 1
    input  wire sel,    // Select line
    output wire y       // Output
);
    // Using conditional/ternary operator
    assign y = (sel) ? b : a;
endmodule

