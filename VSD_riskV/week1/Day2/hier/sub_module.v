// sub_module.v
module sub_module (
  input wire a,
  input wire b,
  output wire out1,
  output wire out2
);

  // A simple AND gate
  assign out1 = a & b;

  // A simple OR gate
  assign out2 = a | b;

endmodule
