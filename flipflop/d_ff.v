module d_ff(clk, rst, d, out);

input clk, rst, d;
output reg out;

initial begin
	out=0;
end

`ifdef SYNC
always @(posedge clk) begin
	if(rst)
		out <= 0;
	else
		out <= d;
end
`endif

`ifdef ASYNC
always @(posedge clk or posedge rst) begin
	if(rst)
		out <= 0;
	else
		out <= d;
end
`endif

endmodule

//----------------TEST BENCH---------------

module tb();

reg clk, rst, d;
wire out;

d_ff dut(clk, rst, d, out);

initial begin
	clk=0; 
	rst=0; d=0;
	forever #5 clk= ~clk;
end

initial begin
	$monitor("$time=%0t, rst=%0d, d=%0d, out=%0d", $time, rst, d, out);

	rst=1; #10;
	rst=0;
	
	d=0; #10;
	d=1; #10;
	$finish;

end

endmodule

