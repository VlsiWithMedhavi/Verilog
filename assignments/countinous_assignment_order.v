// examples proves that the order of continous assignment does'nt change the output

module tb();

reg [7:0] a, b;
wire[7:0] c, d;

assign d=c+b;
assign c=a+b;

initial begin
	$monitor(" a=%0d, b=%0d, c=%0d, d=%0d", a, b, c, d);
	a=1; b=2;
end

endmodule
