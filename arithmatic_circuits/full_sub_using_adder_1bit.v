`timescale 1ns/1ns

`include "full_adder_1bit_behav.v"

module full_sub_using_adder_1bit(a, b, cin, sub, bout);

input a, b, cin;
output sub, bout;

full_adder_1bit_behav fa(a, ~b, cin, sub, bout);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b, cin;
wire sub;
wire bout;

full_sub_using_adder_1bit dut(a, b, cin, sub, bout);

initial begin
	$monitor("time=%0t, a=%0d, b=%0d, bout=%0d, sub=%0d", $time, a, b, bout, sub);
	
	a=1'b0; b=1'b0; cin=1'b1; #5;
	a=1'b0; b=1'b1; cin=1'b1; #5;
	a=1'b1; b=1'b0; cin=1'b1; #5;
	a=1'b1; b=1'b1; cin=1'b1; #5;
	$finish;
end

endmodule
