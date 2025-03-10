`timescale 1ns/1ns

`include "full_adder_1bit.v"

module full_addsub_using_adder_1bit (a, b, cin, m, result, cout);

input a, b, cin, m;
output result, cout;


full_adder_1bit dut(a, b^m, cin, result, cout);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b, cin, m;
wire result, cout;

full_addsub_using_adder_1bit dut(a, b, cin, m, result, cout);

initial begin
	$monitor("time=%0t, m=%0b, a=%0b, b=%0b, cin=%0b, cout=%0d, result=%0d", $time, m, a, b, cin, cout, result);

	m=1'b0; a=1'b0; b=1'b0; cin=1'b0; #5;
	m=1'b0; a=1'b0; b=1'b1; cin=1'b0; #5;
	m=1'b0; a=1'b1; b=1'b0; cin=1'b0; #5;
	m=1'b0; a=1'b1; b=1'b1; cin=1'b0; #5;

	m=1'b1; a=1'b0; b=1'b0; cin=1'b1; #5;
	m=1'b1; a=1'b0; b=1'b0; cin=1'b1; #5;
	m=1'b1; a=1'b0; b=1'b1; cin=1'b1; #5;
	m=1'b1; a=1'b0; b=1'b1; cin=1'b1; #5;
	m=1'b1; a=1'b1; b=1'b0; cin=1'b1; #5;
	m=1'b1; a=1'b1; b=1'b0; cin=1'b1; #5;
	m=1'b1; a=1'b1; b=1'b1; cin=1'b1; #5;
	m=1'b1; a=1'b1; b=1'b1; cin=1'b1; #5;

	$finish;
end

endmodule
