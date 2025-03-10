`timescale 1ns/1ns

`include "full_sub_1bit.v"

module ripple_borrow_sub_4bit(a, b, cin, sub, bout);

input [3:0] a, b;
input cin;
output [3:0] sub;
output bout;

wire [2:0] c0;

full_sub_1bit fs1(a[0], b[0], cin, sub[0], c0[0]);
full_sub_1bit fs2(a[1], b[1], c0[0], sub[1], c0[1]);
full_sub_1bit fs3(a[2], b[2], c0[1], sub[2], c0[2]);
full_sub_1bit fs4(a[3], b[3], c0[2], sub[3], bout);

//assign sub=~(sub) +1;

endmodule


//------------------TEST BENCH----------------------

module tb();

reg [3:0] a, b;
reg cin;
wire [3:0] sub;
wire bout;

ripple_borrow_sub_4bit dut(a, b, cin, sub, bout);


initial begin
	$monitor("time=%0t, a=%0d, b=%0d, cin=%0d, sub=%0b, borrow=%0b", $time, a, b, cin, sub, bout);
	
	a=2; b=3; cin=0; #5;
	a=6; b=8; cin=0; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;
	a=$random; b=$random; cin=$random; #5;

	$finish;
end

endmodule
