`timescale 1ns/1ns

module net_supply0(a, w);

input a;
output supply0 w;

assign w = a;

endmodule

//----------------TEST BENCH-----------------


module tb();

reg a;
supply0 w;

net_supply0 dut(a, w);

initial begin
	a=1'b0; #5;
	a=1'b1; #5;
	#100;
	$finish;
end

initial begin
	$monitor("time=%0t, a=%0b, w=%0b", $time, a, w);
end

endmodule 
