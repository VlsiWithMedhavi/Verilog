`timescale 1ns/1ns

`include "full_adder_1bit.v"

module full_addsub_using_adder_1bit (a, b, cin, m, result, cout);

input [3:0] a, b;
input cin, m;
output [3:0] result;
output cout;

wire [2:0] c0;
wire [3:0] two_comp;

full_adder_1bit fas0(a[0], b[0]^m, c0[0], two_comp[0], c0[1]);
full_adder_1bit fas1(a[1], b[1]^m, c0[1], two_comp[1], c0[2]);
full_adder_1bit fas2(a[2], b[2]^m, c0[2], two_comp[2], c0[3]);
full_adder_1bit fas3(a[3], b[3]^m, c0[3], two_comp[3], cout);

assign c0[0] = m ? 1'b1 : cin;

assign result = two_comp[3] && m ? ~two_comp+1 : two_comp; // as MSB of result is one, the number is negative hence again take 2's complement of the number to get the actual negative magnitude.


endmodule


//------------------TEST BENCH----------------------

module tb();

reg [3:0] a, b;
reg cin, m;
wire [3:0] result;
wire cout;

full_addsub_using_adder_1bit dut(a, b, cin, m, result, cout);


initial begin
	
	$monitor("time=%0t, m=%0d, a=%0d, b=%0d, cin=%0d, cout=%0d, result=%0d", $time, m, a, b, cin, cout, result);
	
	m=1'b0; a=$random; b=$random; cin=1'b0; #5;
	m=1'b0; a=$random; b=$random; cin=1'b0; #5;
	m=1'b0; a=$random; b=$random; cin=1'b0; #5;
	m=1'b0; a=$random; b=$random; cin=1'b0; #5;
	m=1'b1; a=$random; b=$random; cin=1'b0; #5;
	m=1'b1; a=$random; b=$random; cin=1'b0; #5;
	m=1'b1; a=$random; b=$random; cin=1'b0; #5;
	m=1'b1; a=$random; b=$random; cin=1'b0; #5;

	$finish;
end

endmodule

