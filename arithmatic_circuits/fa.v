`include "ha.v"

module fa(a, b, cin, sum, cout);

input a, b, cin;
output sum, cout;

wire n1, n2, n3;

ha ha1(a, b, n1, n2);
ha ha2(n1, cin, sum, n3);
or g1(cout, n2, n3);

endmodule


//----------------TEST BENCH----------------
module tb();

reg a, b, cin;
wire sum, cout;

fa dut(a, b, cin, sum, cout);

initial begin 
	$monitor("time=%0t, a=%0d, b=%0d, cin=%0d, sum=%0d, cout=%0d", $time, a, b, cin, sum, cout);

	a=0; b=1; cin=0; #5;	
	a=1; b=1; cin=0; #5;	
	a=1; b=1; cin=1; #5;	

end

endmodule
