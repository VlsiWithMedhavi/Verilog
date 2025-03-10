`timescale 1ns/1ns

`include "half_adder.v"

module full_adder_1bit(a, b, cin, sum, cout);

input a, b, cin;
output sum, cout;
wire s1, c1, c2;

half_adder ha1(a, b, s1, c1);
half_adder ha2(s1, cin, sum, c2);
or g1(cout, c1, c2);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b, cin;
wire sum, cout;

full_adder_1bit dut(a, b, cin, sum, cout);

initial begin
	$monitor("time=%0t, a=%0b, b=%0b, cin=%0b, sum=%0d", $time, a, b, cin, {cout,sum});

	a=1'b0; b=1'b0; cin=1'b0; #5;
	a=1'b0; b=1'b0; cin=1'b1; #5;
	a=1'b0; b=1'b1; cin=1'b0; #5;
	a=1'b0; b=1'b1; cin=1'b1; #5;
	a=1'b1; b=1'b0; cin=1'b0; #5;
	a=1'b1; b=1'b0; cin=1'b1; #5;
	a=1'b1; b=1'b1; cin=1'b0; #5;
	a=1'b1; b=1'b1; cin=1'b1; #5;
	$finish;
end

endmodule
