`timescale 1ns/1ns

module sample_not(y, in);

input in;
output wire y; // by default output is of "wire" datatype

assign #2 y=~in; // input is processed immediately but due to delay the output gets updated only after 3 units delay 

endmodule

//-------------TEST BENCH------------------

module tb;

reg in;
wire y; 

sample_not dut(y, in);

initial begin
	$monitor("time=%0t, in=%0b, y=%0b",$time, in, y);

	in=1'b0; #3;
	in=1'b1; 
	#100;
	$finish;
end

endmodule
