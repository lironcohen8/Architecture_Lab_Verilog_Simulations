`include "../ex3/fulladder.v"

module  add4( sum, co, a, b, ci);

  input   [3:0] a, b;
  input   ci;
  output  [3:0] sum;
  output  co;

  wire [2:0] r;

  fulladder g0(sum[0], r[0], a[0], b[0], ci);
  fulladder g0(sum[1], r[1], a[1], b[0], r[0]);
  fulladder g0(sum[2], r[2], a[2], b[0], r[1]);
  fulladder g0(sum[3], c0  , a[3], b[0], r[2]);

endmodule