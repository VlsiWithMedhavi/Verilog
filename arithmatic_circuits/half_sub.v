`timescale 1ns/1ns

module half_sub(a, b, sub, bout);

input a, b;
output sub, bout;
wire t1;

xor g1(sub, a, b);
not g2(t1, a);
and g3(bout, t1, b);

endmodule


//------------------TEST BENCH----------------------

module tb();

reg a, b;
wire sub, bout;

half_sub dut(a, b, sub, bout);

initial begin
	$monitor("time=%0t, a=%0b, b=%0b, bout=%0d, sub=%0d", $time, a, b, bout, sub);

	a=1'b0; b=1'b0; #5;
	a=1'b0; b=1'b1; #5;
	a=1'b1; b=1'b0; #5;
	a=1'b1; b=1'b1; #5;
	$finish;
end

endmodule
