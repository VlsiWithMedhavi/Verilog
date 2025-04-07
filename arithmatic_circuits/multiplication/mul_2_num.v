module tb();

integer a, b, mul;

initial begin
	a=23; b=45; mul=0;
	$display("a=%0d, b=%0d", a, b);
	mul = (b<<4) + (b<<2) + (b<<1) + (b<<0);
	$display("mul=%0d", mul);
end

endmodule


