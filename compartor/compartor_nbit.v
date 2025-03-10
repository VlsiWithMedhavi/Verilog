`timescale 1ns/1ns

module comparator_nbit(num1, num2, gt, eq, ls);

parameter BIT=4;

input [BIT-1:0] num1, num2;
output reg gt, eq, ls;

always @(*) begin
	if(num1 > num2)
		gt=1'b1;
	else if(num1 < num2)
		ls=1'b1;
	else
		eq=1'b1;
end

endmodule

//-------------TEST BENCH------------------

module tb();

parameter BIT=4;

reg [BIT-1:0] num1, num2;
wire gt, eq, ls;

comparator_nbit dut(num1, num2, gt, eq, ls);

initial begin
	$monitor("time=%0t, num1=%0d, num2=%0d, gt=%0d, eq=%0d, ls=%0d", $time, num1, num2, gt, eq, ls);

	num1=9; num2=19; #5;
	num1=2; num2=8; #5;
	num1=13; num2=13; #5;
end
	
endmodule
