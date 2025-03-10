`timescale 1ns/1ns


module full_adder_1bit_behav(a, b, cin, sum, cout);

input a, b, cin;
output sum, cout;

assign {cout,sum}=a+b+cin;
endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b, cin;
wire sum, cout;

full_adder_1bit_behav dut(a, b, cin, sum, cout);

initial begin
	$monitor("time=%0t, a=%0b, b=%0b, cin=%0b, sum=%0d", $time, a, b, cin, {cout,sum});

	a=1'b0; b=1'b0; cin=1'b0; #5;
	a=1'b0; b=1'b0; cin=1'b1; #5;
	a=1'b0; b=1'b1; cin=1'b0; #5;
	a=1'b0; b=1'b1; cin=1'b1; #5;
	a=1'b1; b=1'b0; cin=1'b0; #5;
	a=1'b1; b=1'b0; cin=1'b1; #5;
	a=1'b1; b=1'b1; cin=1'b0; #5;
	a=1'b1; b=1'b1; cin=1'b1; #5;
	$finish;
end

endmodule
