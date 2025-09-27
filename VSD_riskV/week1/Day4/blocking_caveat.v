module blocking_caveat (input a, input b, input c, output reg d);
  reg x;
  always @ (*) begin
  x = a | b;
  d = x & c;
end
endmodule
