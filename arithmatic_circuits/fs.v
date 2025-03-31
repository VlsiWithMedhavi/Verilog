module fs(a, b, cin, sub, bout);

input a, b, cin;
output sub, bout;

wire n1, n2, n3;

xor g1(sub, a, b, cin);
and g2(n1, ~a, b);
and g3(n2, ~a, cin);
and g4(n3, b, cin);
or g5(bout, n1, n2, n3);

endmodule

//-------------TEST BENCH--------------

module tb();

reg a, b, cin;
wire sub, bout;

fs dut(a, b, cin, sub, bout);

initial begin 
	$monitor("time=%0t, a=%0d, b=%0d, cin=%0d, sub=%0d, bout=%0d", $time, a, b, cin, sub, bout);

	a=0; b=1; cin=0; #5;	
	a=1; b=1; cin=0; #5;	
	a=1; b=1; cin=1; #5;	

end

endmodule
