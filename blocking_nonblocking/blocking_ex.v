module tb();

integer a, b, c;

initial begin
	a=0; b=10; c=5;
	a = b+c; 
	b = a;
end

initial begin
	$monitor("time=%0t, a=%0d, b=%0d, c=%0d", $time, a, b, c);
end

endmodule




