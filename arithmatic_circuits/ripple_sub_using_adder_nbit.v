`timescale 1ns/1ns

`include "full_sub_using_adder_1bit.v"

module ripple_sub_using_adder_nbit(a, b, sub, bout);

parameter NUM_BIT=8;

input [NUM_BIT-1:0] a, b;
output [NUM_BIT-1:0] sub;
output bout;

wire [NUM_BIT:0] c0;
wire [NUM_BIT-1:0] two_comp;

assign c0[0]=1'b1;
assign bout = c0[NUM_BIT];

genvar i;
	for(i=0; i<NUM_BIT; i=i+1)
		full_sub_using_adder_1bit fas(a[i], b[i], c0[i], two_comp[i], c0[i+1]);

assign sub = two_comp[NUM_BIT-1] ? ~two_comp+1 : two_comp; 

endmodule


//------------------TEST BENCH----------------------

module tb();

parameter NUM_BIT=8;

reg [NUM_BIT-1:0] a, b;
wire [NUM_BIT-1:0] sub;
wire bout;

ripple_sub_using_adder_nbit dut(a, b, sub, bout);


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

