module fulladder( sum, co, a, b, ci);

  input   a, b, ci;
  output  sum, co;

  assign sum = a ^ b ^ ci;
  assign co = (a & b) | (a & ci) | (b & ci);

endmodule
