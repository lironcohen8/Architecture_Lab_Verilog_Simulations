module main;
reg clk, reset, branch, taken;
wire prediction;
integer error_counter;

sat_count sat_count_i(clk, reset, branch, taken, prediction);

always #5 clk = ~clk;

begin
$display("time=%d:%b + %b = %b, carry = %b\n", $time, a, b, sum, carry);
end

initial
begin
$dumpfile("waves.vcd");
$dumpvars;
#10;
error_counter = 0;
clk = 0;
reset = 1;
branch = 0;
taken = 0;

#10;
reset = 0;
branch = 1; 
taken = 1;
if (prediction != 0)
    begin
        $display("error in test 1");
        error_counter = error_counter + 1;
    end

#10;
branch = 1; 
taken = 1;
if (prediction == 0)
    begin
        $display("error in test 2");
        error_counter = error_counter + 1;
    end

#10;
branch = 1; 
taken = 1;
if (prediction == 0)
    begin
        $display("error in test 3");
        error_counter = error_counter + 1;
    end

#10;
branch = 1; 
taken = 1;
if (prediction == 0)
    begin
        $display("error in test 4");
        error_counter = error_counter + 1;
    end

#10;
branch = 0; 
taken = 0;
if (prediction == 0)
    begin
        $display("error in test 5");
        error_counter = error_counter + 1;
    end

#10;
branch = 0; 
taken = 0;
if (prediction == 0)
    begin
        $display("error in test 6");
        error_counter = error_counter + 1;
    end

#10;
branch = 1; 
taken = 0;
if (prediction == 0)
    begin
        $display("error in test 7");
        error_counter = error_counter + 1;
    end

#10;
branch = 1; 
taken = 0;
if (prediction == 0)
    begin
        $display("error in test 8");
        error_counter = error_counter + 1;
    end

#10;
branch = 1; 
taken = 0;
if (prediction != 0)
    begin
        $display("error in test 9");
        error_counter = error_counter + 1;
    end

#10;
branch = 1; 
taken = 0;
if (prediction != 0)
    begin
        $display("error in test 10");
        error_counter = error_counter + 1;
    end

#10;
branch = 1; 
taken = 0;
if (prediction != 0)
    begin
        $display("error in test 11");
        error_counter = error_counter + 1;
    end

if (error_counter == 0)
    begin
        $display("PASSED ALL TESTS");
    end
    else begin
        $display("FAILED");
    end


$finish;
end
endmodule
