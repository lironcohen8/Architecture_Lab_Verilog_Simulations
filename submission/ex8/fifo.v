module fifo(clk, reset, in, push, pop, out, full);
   parameter N=4; // determines the maximum number of words in queue.
   parameter M=2; // determines the bit-width of each word, stored in the queue.

   input clk, reset, push, pop;
   input [M-1:0] in;
   output [M-1:0] out;
   output full;

   
   integer cnt;
   integer is_full;
   reg [M*N-1:0] words;
   reg [M-1:0] word_out;

   always @ (posedge clk or reset)
        begin
	// reset
	if (reset)
		begin
			cnt <= 0;
			is_full <= 0;
			words <= 0;
			word_out <= 0;
		end
	else
		begin

		// calulating is_full
		if (cnt < N)
			begin
				is_full <= 0;
			end
		else
			begin
				is_full <= 1;
			end

		// calulating word_out 
		if (cnt > 0)
			begin
				word_out <= words & ((1 << M) - 1);
			end
		else
			begin
				word_out <= 0;
			end

		// Updating words and cnt

		// empty queue
		if (cnt == 0)
			begin
				if (push)
					begin
						words <= in;
						cnt <= 1;
					end
				else
					begin
						words <= words;
						cnt <= cnt;						
					end
			end
		
		// queue is partially full 
		else if (cnt < N) 
			begin
				if (push && pop) // push and pop
					begin
						words <= (in << (M * (cnt - 1))) | (words >>> M);
						cnt <= cnt;				
					end
				if (push && ~pop) // only push
					begin
						words <= (in << (M * cnt)) | words;
						cnt <= cnt + 1;					
					end
				if (~push && pop) // only pop
					begin
						words <= (words >>> M);
						cnt <= cnt - 1;					
					end
				if (~push && ~pop) // no push and no pop
					begin
						words <= words;
						cnt <= cnt;					
					end
			end

		// queue is full 
		else if (cnt == N)
			begin
				if (push && pop) // push and pop
					begin
						words <= (in << (M * (cnt - 1))) | (words >>> M);
						cnt <= cnt;					
					end
				if (push && ~pop) // only push
					begin
						words <= words;
						cnt <= cnt;					
					end
				if (~push && pop) // only pop
					begin
						words <= (words >>> M);
						cnt <= cnt - 1;					
					end
				if (~push && ~pop) // no push and no pop
					begin
						words <= words;
						cnt <= cnt;					
					end
			end
		end
	end
	
	assign full = is_full;
	assign out = word_out;			

endmodule
