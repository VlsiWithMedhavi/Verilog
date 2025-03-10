`timescale 1ns/1ns

`include "full_add_sub_1bit.v"

module ripple_add_sub_4bit(a, b, cin, m, sum, cout);

input [3:0] a, b;
input cin, m;
output [3:0] sum;
output cout;

wire [2:0] c0;

full_add_sub_1bit fas1(a[0], b[0], cin, m, sum[0], c0[0]);
full_add_sub_1bit fas2(a[1], b[1], c0[0], m, sum[1], c0[1]);
full_add_sub_1bit fas3(a[2], b[2], c0[1], m, sum[2], c0[2]);
full_add_sub_1bit fas4(a[3], b[3], c0[2], m, sum[3], cout);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg [3:0] a, b;
reg cin, m;
wire [3:0] sum;
wire cout;

ripple_add_sub_4bit dut(a, b, cin, m, sum, cout);


initial begin
	
	$monitor("time=%0t, m=%0d, a=%0d, b=%0d, cin=%0d, cout=%0d, sum=%0d", $time, m, a, b, cin, cout, sum);

	m=1'b1; a=5; b=12; cin=0; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;
	m=$random; a=$random; b=$random; cin=$random; #5;

	$finish;
end

endmodule

