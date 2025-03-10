`timescale 1ns/1ns

`include "full_sub_using_adder_1bit.v"

module ripple_sub_using_adder_4bit(a, b, sub, bout);

input [3:0] a, b;
output [3:0] sub;
output bout;

wire [2:0] c0;
wire [3:0] two_comp;

full_sub_using_adder_1bit fas0(a[0], b[0], 1'b1, two_comp[0], c0[0]);
full_sub_using_adder_1bit fas1(a[1], b[1], c0[0], two_comp[1], c0[1]);
full_sub_using_adder_1bit fas2(a[2], b[2], c0[1], two_comp[2], c0[2]);
full_sub_using_adder_1bit fas3(a[3], b[3], c0[2], two_comp[3], bout);

assign sub = two_comp[3] ? ~two_comp+1 : two_comp; // as MSB of result is one, the number is negative hence again take 2's complement of the number to get the actual negative magnitude.

endmodule


//------------------TEST BENCH----------------------

module tb();

reg [3:0] a, b;
wire [3:0] sub;
wire bout;

ripple_sub_using_adder_4bit dut(a, b, sub, bout);


initial begin
	
	$monitor("time=%0t, a=%0d, b=%0d, bout=%0d, sub=%0d", $time, a, b, bout, sub);
	
	a=6; b=9; #5;
	a=4; b=10; #5;
	a=$random; b=$random; #5;
	a=$random; b=$random; #5;
	a=$random; b=$random; #5;

	$finish;
end

endmodule

