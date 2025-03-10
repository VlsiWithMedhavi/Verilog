`timescale 1ns/1ns

module half_adder(a, b, sum, cout);

input a, b;
output sum, cout;

xor g1(sum, a, b);
and g2(cout, a, b);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b;
wire sum, cout;

half_adder dut(a, b, sum, cout);

initial begin
	$monitor("time=%0t, a=%0b, b=%0b, cout=%0d, sum=%0d", $time, a, b, cout, sum);

	a=1'b0; b=1'b0; #5;
	a=1'b0; b=1'b1; #5;
	a=1'b1; b=1'b0; #5;
	a=1'b1; b=1'b1; #5;
	$finish;
end

endmodule
