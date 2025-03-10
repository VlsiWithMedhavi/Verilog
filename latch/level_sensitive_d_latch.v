module level_sensitive_d_latch(d_in, q, en);

input d_in, en;
output q;

assign q = en ? d_in : q;

endmodule


//---------------TEST BENCH----------------

module tb();

reg d_in, en;
wire q;

level_sensitive_d_latch dut(d_in, q, en);

initial begin
	$monitor("$time=%0t, en=%0d, d_in=%0d, q=%0d", $time, en, d_in, q);

	en=1'b0; d_in=1'b0; #5; 
	en=1'b0; d_in=1'b1; #5; 
	en=1'b1; d_in=1'b0; #5; 
	en=1'b1; d_in=1'b1; #5; 
	$finish;
end

endmodule
