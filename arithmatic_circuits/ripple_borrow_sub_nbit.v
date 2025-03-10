`timescale 1ns/1ns

`include "full_sub_1bit.v"

module ripple_borrow_sub_nbit(a, b, cin, sub, bout);

parameter NUM_BIT=8;

input [NUM_BIT-1:0] a, b;
input cin;
output [NUM_BIT-1:0] sub;
output bout;

wire [NUM_BIT:0] c0;

assign c0[0]=cin;
assign bout=c0[NUM_BIT];

genvar i;
for(i=0; i<NUM_BIT; i=i+1) begin
	full_sub_1bit fa(a[i], b[i], c0[i], sub[i], c0[i+1]);
end

endmodule


//------------------TEST BENCH---------------------

module tb();

parameter NUM_BIT=8;

reg [NUM_BIT-1:0] a, b;
reg cin;
wire [NUM_BIT-1:0] sub;
wire bout;

ripple_borrow_sub_nbit dut(a, b, cin, sub, bout);

initial begin
	$monitor("time=%0t, a=%0d, b=%0d, cin=%0d, sub=%0d, borrow=%0b", $time, a, b, cin, sub, bout);
	
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;

	$finish;
end

endmodule
