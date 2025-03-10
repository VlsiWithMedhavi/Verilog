`timescale 1ns/1ns

module dff_negedge(clk, d, q, qbar);

input clk, d;
output reg q, qbar;

always @(negedge clk) begin
	q=d;
	qbar=~d;
end

endmodule


//---------------TEST BENCH----------------

module tb();


reg clk, d;
wire q, qbar;

dff_negedge dut(clk, d, q, qbar);

initial begin
	clk=1'b0;
	forever #5 clk=~clk;
end

initial begin
	$monitor("time=%0t, d=%0d, q=%0d, qbar=%0d", $time, d, q, qbar);
	
	d=1'b0; #6;	
	d=1'b1; #6;	
	d=1'b0; #6;	
	#100;
	$finish;
end

endmodule
