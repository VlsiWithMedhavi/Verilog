`timescale 1ns/1ns

module net_wire(a, b, w);

input a, b;
output w; // default of wire datatype

assign w = a;
assign w = b; // as wire "w" is driven by both a and b, their will remain a conflict and value will be undertermined 'x'.

endmodule

//----------------TEST BENCH-----------------


module tb();

reg a, b;
wire w;

net_wire dut(a, b, w);

initial begin
	a=1'b1; #5; b=1'b0;
	#100;
	$finish;
end

initial begin
	$monitor("time=%0t, a=%0b, b=%0b, w=%0b", $time, a, b, w);
end

endmodule 
