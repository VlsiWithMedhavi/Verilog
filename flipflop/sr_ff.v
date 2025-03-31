module sr_ff(clk, s, r, q, qbar);

input clk, s, r;
output q, qbar;

wire n1, n2;

nand g1(n1, clk, s);
nand g2(n2, clk, r);
nand g3(q, n1, qbar);
nand g4(qbar, n2, q);

endmodule

//----------------TEST BENCH---------------

module tb();

reg clk, s, r;
wire q, qbar;

sr_ff dut(clk, s, r, q, qbar);

initial begin
	$monitor("$time=%0t, clk=%0d, s=%0d, r=%0d, q=%0d, qbar=%0d", $time, clk, s, r, q, qbar);

	clk=1; s=0; r=0; #5;
	clk=1; s=0; r=1; #5;
	clk=1; s=1; r=0; #5;
	clk=1; s=1; r=1; #5;
	clk=0; s=0; r=0; #5;
	clk=0; s=0; r=1; #5;
	clk=0; s=1; r=0; #5;
	clk=0; s=1; r=1; #5;
	
	$finish;

end

endmodule

