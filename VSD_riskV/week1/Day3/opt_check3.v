module opt_check3 (
    input  a,
    input  b,
    input  c,
    output y
);

  // Use a continuous assignment with a ternary operator to model the logic.
  // The expression is equivalent to: y = a & b & c;
  assign y =  a & b & c;

endmodule
