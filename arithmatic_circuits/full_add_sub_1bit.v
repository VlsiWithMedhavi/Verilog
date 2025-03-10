`timescale 1ns/1ns

`include "half_add_sub.v"

module full_add_sub_1bit(a, b, cin, m, sum, cout);

input a, b, cin, m;
output sum, cout;
wire s1, c1, c2;

half_add_sub has1(a, b, m, s1, c1);
half_add_sub ha2(s1, cin, m, sum, c2);
or g1(cout, c1, c2);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b, cin, m;
wire sum, cout;

full_add_sub_1bit dut(a, b, cin, m, sum, cout);

initial begin
	$monitor("time=%0t, m=%0b, a=%0b, b=%0b, cin=%0b, cout=%0d, sum=%0d", $time, m, a, b, cin, cout, sum);

	m=1'b0; a=1'b0; b=1'b0; cin=1'b0; #5;
	m=1'b0; a=1'b0; b=1'b0; cin=1'b1; #5;
	m=1'b0; a=1'b0; b=1'b1; cin=1'b0; #5;
	m=1'b0; a=1'b0; b=1'b1; cin=1'b1; #5;
	m=1'b0; a=1'b1; b=1'b0; cin=1'b0; #5;
	m=1'b0; a=1'b1; b=1'b0; cin=1'b1; #5;
	m=1'b0; a=1'b1; b=1'b1; cin=1'b0; #5;
	m=1'b0; a=1'b1; b=1'b1; cin=1'b1; #5;

	m=1'b1; a=1'b0; b=1'b0; cin=1'b0; #5;
	m=1'b1; a=1'b0; b=1'b0; cin=1'b1; #5;
	m=1'b1; a=1'b0; b=1'b1; cin=1'b0; #5;
	m=1'b1; a=1'b0; b=1'b1; cin=1'b1; #5;
	m=1'b1; a=1'b1; b=1'b0; cin=1'b0; #5;
	m=1'b1; a=1'b1; b=1'b0; cin=1'b1; #5;
	m=1'b1; a=1'b1; b=1'b1; cin=1'b0; #5;
	m=1'b1; a=1'b1; b=1'b1; cin=1'b1; #5;

	$finish;
end

endmodule
