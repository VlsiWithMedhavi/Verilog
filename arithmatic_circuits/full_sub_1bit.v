`timescale 1ns/1ns

`include "half_sub.v"

module full_sub_1bit(a, b, cin, sub, bout);

input a, b, cin;
output sub, bout;
wire s1, c1, c2;

half_sub ha1(a, b, s1, c1);
half_sub ha2(s1, cin, sub, c2);
or g1(bout, c1, c2);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b, cin;
wire sub, bout;

full_sub_1bit dut(a, b, cin, sub, bout);

initial begin
	$monitor("time=%0t, a=%0b, b=%0b, cin=%0b, sub=%0d, borrow=%0d", $time, a, b, cin, sub, bout);

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
