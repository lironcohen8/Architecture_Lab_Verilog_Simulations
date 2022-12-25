module sat_count(clk, reset, branch, taken, prediction);
   parameter N=2;
   input clk, reset, branch, taken;
   output prediction;

   reg [N-1:0] counter;


   always @ (posedge clk) begin
      if (reset)
		   counter = 0;
	   else if (branch) begin
         if (taken) begin
            if (counter < {N{1'b1}}) begin
						counter = counter + 1;
					end
					else begin
						counter = {1'b0,{(N-1){1'b1}}};
					end
				end
         else begin
 			   if (counter > 0)
				   counter = counter - 1;
			else
				counter = 0;
		end
   end

   assign prediction = counter[N-1];

endmodule
