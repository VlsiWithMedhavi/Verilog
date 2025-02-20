`timescale 1ns/1ns

module sample_xnor(y, in1, in2);

input in1, in2;
output wire y; 

assign y= (~in1 & ~in2) | (in1 & in2); // bitwise opertor  

endmodule

//---------------TEST BENCH----------------------

module tb;

reg in1, in2;
wire y; 

sample_xnor dut(y, in1, in2);

initial begin
	$monitor("time=%0t, in1=%0b, in2=%0b, y=%0b",$time, in1, in2, y);

	in1=1'b0; in2=1'b0; #5;
	in1=1'b0; in2=1'b1; #5;
	in1=1'b1; in2=1'b0; #5;
	in1=1'b1; in2=1'b1;
	#100;
	$finish;
end

endmodule




