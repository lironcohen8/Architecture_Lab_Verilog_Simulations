module sat_count(clk, reset, branch, taken, prediction);
   parameter N=2;
   input clk, reset, branch, taken;
   output prediction;

   reg [N-1:0] counter;


   always @ (posedge clk) begin
      if (reset)
		   counter = 0;
	  else if (branch) begin
         if (taken) begin // branch is taken
            if (counter < {2'b11}) begin // counter < 11
						counter = counter + 1;
			end
	   	 end
         else begin // branch is not taken
 			   if (counter > 0)
				   counter = counter - 1;
		 end
	  end
   end

   assign prediction = counter[N-1];

endmodule
