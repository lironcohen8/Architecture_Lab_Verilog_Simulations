`include "../ex3/fulladder.v"

module  add4( sum, co, a, b, ci);

  input   [3:0] a, b;
  input   ci;
  output  [3:0] sum;
  output  co;

  wire [2:0] c;

  fulladder a0(sum[0], c[0], a[0], b[0], ci);
  fulladder a1(sum[1], c[1], a[1], b[1], c[0]);
  fulladder a2(sum[2], c[2], a[2], b[2], c[1]);
  fulladder a3(sum[3], co  , a[3], b[3], c[2]);

endmodule
