`timescale 1ns/1ns

`include "full_adder_1bit.v"

module ripple_carry_adder_nbit(a, b, cin, sum, cout);

parameter NUM_BIT=8;

input [NUM_BIT-1:0] a, b;
input cin;
output [NUM_BIT-1:0] sum;
output cout;

wire [NUM_BIT:0] c0;

assign c0[0]=cin;
assign cout=c0[NUM_BIT];

genvar i;
for(i=0; i<NUM_BIT; i=i+1) begin
	full_adder_1bit fa(a[i], b[i], c0[i], sum[i], c0[i+1]);
end

endmodule


//------------------TEST BENCH---------------------

module tb();

parameter NUM_BIT=8;

reg [NUM_BIT-1:0] a, b;
reg cin;
wire [NUM_BIT-1:0] sum;
wire cout;

ripple_carry_adder_nbit dut(a, b, cin, sum, cout);

initial begin
	$monitor("time=%0t, a=%0d, b=%0d, cin=%0d, sum=%0d", $time, a, b, cin, {cout,sum});
	
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;

	$finish;
end

endmodule
