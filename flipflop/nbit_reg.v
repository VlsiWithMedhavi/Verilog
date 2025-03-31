module nbit_reg(clk, rst, d, out);

parameter BIT=8;
input clk, rst;
input [BIT-1:0] d;
output reg [BIT-1:0] out;

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

parameter BIT=8;
reg clk, rst;
reg [BIT-1:0] d;
wire [BIT-1:0] out;


nbit_reg dut(clk, rst, d, out);

initial begin
	clk=0; 
	rst=0; d=0;
	forever #5 clk= ~clk;
end

initial begin
	$monitor("$time=%0t, rst=%0d, d=%0d, out=%0d", $time, rst, d, out);

	rst=1; #10;
	rst=0;
	
	d=$random; #10;
	d=$random; #10;
	$finish;

end

endmodule

