module main;
   reg clk, reset, push, pop;
   reg [1:0] in;
   wire [1:0] out;
   wire full;
   integer error;

   // Correct the parameter assignment
   fifo uut #(4,2) (clk, reset, in, push, pop, out, full);

   always #5 clk = ~clk;

   initial
     begin
        $dumpfile("waves.vcd");
        $dumpvars;
        clk = 1;
	error = 0;

   #10
   // test 1 - initial state, should be full = 0, out = 0, <>
   reset = 1;
   in = 0;
   push = 0;
   pop = 0;

   #10 
   if (full != 0 | out != 0)
	begin
		error <= 1;
	end

   #10
   // test 2 - pop from empty queue, should be full = 0, out = 0, <>
   reset = 0;
   in = 2;
   push = 0;
   pop = 1;

   #10 
   if (full != 0 | out != 0)
	begin
		error <= 2;
	end

   #10
   // test 3 - push to empty queue, should be full = 0, out = 0, n = 1 , <3>
   reset = 0;
   in = 3;
   push = 1;
   pop = 0;

   #10 
   if (full != 0 | out != 0)
	begin
		error <= 3;
	end

   #10
   // test 4 - pop one word from queue, should be full = 0, out = 3, n = 0 , <>
   reset = 0;
   in = 0;
   push = 0;
   pop = 1;

   #10 
   if (full != 0 | out != 3)
	begin
		error <= 4;
	end

   #10
   // test 5 - pop and push from empty queue, should be full = 0, out = 0, n = 1 , <1>
   reset = 0;
   in = 1;
   push = 1;
   pop = 1;

   #10 
   if (full != 0 | out != 0)
	begin
		error <= 5;
	end

   #10
   // test 6 - push to paritally full queue, should be full = 0, out = 1, n = 2 , <2,1>
   reset = 0;
   in = 2;
   push = 1;
   pop = 0;

   #10 
   if (full != 0 | out != 1)
	begin
		error <= 6;
	end

   #10
   // test 7 - push to paritally full queue, should be full = 0, out = 1, n = 3 , <3,2,1>
   reset = 0;
   in = 3;
   push = 1;
   pop = 0;

   #10 
   if (full != 0 | out != 1)
	begin
		error <= 7;
	end

   #10
   // test 8 - push to paritally full queue, should be full = 0, out = 1, n = 4 , <3,3,2,1>
   reset = 0;
   in = 3;
   push = 1;
   pop = 0;

   #10 
   if (full != 0 | out != 1)
	begin
		error <= 8;
	end

   #10
   // test 9 - push to a full queue, should be full = 1, out = 1, n = 4 , <3,3,2,1>
   reset = 0;
   in = 2;
   push = 1;
   pop = 0;

   #10 
   if (full != 1 | out != 1)
	begin
		error <= 9;
	end

   #10
   // test 10 - pop from a full queue, should be full = 1, out = 1, n = 3 , <3,3,2>
   reset = 0;
   in = 0;
   push = 0;
   pop = 1;

   #10 
   if (full != 1 | out != 1)
	begin
		error <= 10;
	end

   #10
   // test 11 - pop from a partially full queue, should be full = 0, out = 2, n = 2 , <3,3>
   reset = 0;
   in = 0;
   push = 0;
   pop = 1;

   #10 
   if (full != 0 | out != 2)
	begin
		error <= 11;
	end

   #10
   // test 12 - checking reset, should be full = 0, out = 0, <>
   reset = 1;
   in = 0;
   push = 0;
   pop = 0;

   #10 
   if (full != 0 | out != 0)
	begin
		error <= 12;
	end

   #10
   if (error == 0)
	begin
		$display("PASSED ALL TESTS");
	end
   else
	begin
		$display("DID NOT PASS TESTS. ERROR IN %d", error)
	end

   $finish;
   end

endmodule
