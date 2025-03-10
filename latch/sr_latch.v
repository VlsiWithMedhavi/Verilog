`timescale 1ns/1ns

module sr_latch(s, r, q, qbar);

input s, r;
output q, qbar;

assign q = ~(r & qbar);
assign qbar = ~(s & q);

endmodule


//-------------- TEST BENCH------------

module tb();

reg s, r;
wire q, qbar;


sr_latch dut(s, r, q, qbar);

initial begin
	$monitor("time=%0t, s=%0d, r=%0d, q=%0d, qbar=%0d", $time, s, r, q, qbar);

	s=1'b0; r=1'b0; #5;
	s=1'b0; r=1'b1; #5;
	s=1'b1; r=1'b0; #5;
	s=1'b1; r=1'b1; #5;
	s=1'b0; r=1'b1; #5;
	s=1'b1; r=1'b1; #5;
	$finish;
end

endmodule
