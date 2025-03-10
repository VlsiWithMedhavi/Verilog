`timescale 1ns/1ns

module half_add_sub(a, b, m, sum, cout);

input a, b, m;
output sum, cout;
wire t1;

xor g1(sum, a, b);
xor g2(t1, a, m);
and g3(cout, b, t1);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b, m;
wire sum, cout;

half_add_sub dut(a, b, m, sum, cout);

initial begin
	$monitor("time=%0t, m=%0b, a=%0b, b=%0b, cout=%0d, sum=%0d", $time, m, a, b, cout, sum);

	a=1'b0; b=1'b0; m=1'b0; #5;
	a=1'b0; b=1'b0; m=1'b1; #5;
	a=1'b0; b=1'b1; m=1'b0; #5;
	a=1'b0; b=1'b1; m=1'b1; #5;
	a=1'b1; b=1'b0; m=1'b0; #5;
	a=1'b1; b=1'b0; m=1'b1; #5;
	a=1'b1; b=1'b1; m=1'b0; #5;
	a=1'b1; b=1'b1; m=1'b1; #5;
	$finish;
end

endmodule
