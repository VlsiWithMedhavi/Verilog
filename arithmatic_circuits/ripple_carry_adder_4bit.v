`timescale 1ns/1ns

`include "full_adder_1bit.v"

module ripple_carry_adder_4bit(a, b, cin, sum, cout);

input [3:0] a, b;
input cin;
output [3:0] sum;
output cout;

wire [2:0] c0;

full_adder_1bit fa1(a[0], b[0], cin, sum[0], c0[0]);
full_adder_1bit fa2(a[1], b[1], c0[0], sum[1], c0[1]);
full_adder_1bit fa3(a[2], b[2], c0[1], sum[2], c0[2]);
full_adder_1bit fa4(a[3], b[3], c0[2], sum[3], cout);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg [3:0] a, b;
reg cin;
wire [3:0] sum;
wire cout;

ripple_carry_adder_4bit dut(a, b, cin, sum, cout);


initial begin
	$monitor("time=%0t, a=%0d, b=%0d, cin=%0d, sum=%0d", $time, a, b, cin, {cout,sum});
	
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;

	$finish;
end

endmodule
