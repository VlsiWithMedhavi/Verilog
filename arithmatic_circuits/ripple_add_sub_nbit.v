`timescale 1ns/1ns

`include "full_add_sub_1bit.v"

module ripple_add_sub_nbit(a, b, cin, m, sum, cout);

parameter NUM_BIT=8;

input [NUM_BIT-1:0] a, b;
input cin, m;
output [NUM_BIT-1:0] sum;
output cout;

wire [NUM_BIT:0] c0;

assign c0[0]=cin;
assign cout=c0[NUM_BIT];

genvar i;
for(i=0; i<NUM_BIT; i=i+1) begin
	full_add_sub_1bit fas(a[i], b[i], c0[i], m, sum[i], c0[i+1]);
end

endmodule


//------------------TEST BENCH---------------------

module tb();

parameter NUM_BIT=8;

reg [NUM_BIT-1:0] a, b;
reg cin, m;
wire [NUM_BIT-1:0] sum;
wire cout;

ripple_add_sub_nbit dut(a, b, cin, m, sum, cout);

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

	$finish;
end

endmodule
