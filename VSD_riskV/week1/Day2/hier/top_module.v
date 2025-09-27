// top_module.v
module top_module (
  input wire a,
  input wire b,
  input wire c,
  input wire d,
  output wire out_and,
  output wire out_or
);

  wire net1, net2;
  wire net3, net4;

  // Instantiate the sub-module for the first time
  sub_module instance1 (
    .a    (a),
    .b    (b),
    .out1 (net1),
    .out2 (net2)
  );

  // Instantiate the sub-module for the second time, with the same inputs
  // Flattened synthesis will optimize this redundancy away.
  sub_module instance2 (
    .a    (a),
    .b    (b),
    .out1 (net3),
    .out2 (net4)
  );

  // Combine the outputs of the two sub-module instances
  assign out_and = net1 & net3;
  assign out_or  = net2 | net4;

endmodule
