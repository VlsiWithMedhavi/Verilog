module syn_nbit_counter(clk, rst, count);

parameter BITS=32;

input clk, rst;
output reg [BITS-1:0] count;

always @(posedge clk) begin
	if(rst)
		count=0;
	else
		count=count+1;
end

endmodule



//-----------------TEST BENCH-------------------


module tb();

parameter BITS=32;

reg clk, rst;
wire [BITS-1:0] count;

syn_nbit_counter dut(clk, rst, count);

always begin
	clk=1'b0; #5;
	clk=1'b1; #5;
end

initial begin
	rst=1'b1; 
	repeat(2) begin
		@(posedge clk);
	end
	rst=1'b0;
	#500;
	$finish;
end

initial begin
	$monitor("time=%0t, rst=%0b, clk=%0b, count=%0d", $time, rst, clk, count);
end

endmodule
