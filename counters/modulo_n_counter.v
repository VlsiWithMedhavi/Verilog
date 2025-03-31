module modulo_n_counter(clk, rst, count);

parameter MODULO=6;
parameter BIT=$clog2(MODULO);

input clk, rst;
output reg [BIT-1:0] count;

initial begin
	count=0;
end

always @(posedge clk) begin
	if(rst) 
		count<=0; 
	else begin
		if(count < MODULO-1)
			count <= count+1;
		else
		count <= 0;
	end
end

endmodule



//--------------------TEST BENCH-------------------

module tb();

parameter MODULO=6;
parameter BIT=$clog2(MODULO);

reg clk, rst;
wire [BIT-1:0] count;

modulo_n_counter dut(clk, rst, count);


initial begin
	clk=0;
	forever #5 clk=~clk;
end

initial begin 
	$monitor("time=%0t, count=%0d", $time, count);
	rst=1; #10;
	rst=0;

	#100;	
	$finish;
end

endmodule
