`include "fa.v"

module fa_8bit(a, b, cin, sum, cout);

parameter BIT=8;

input [BIT-1:0] a, b;
input cin;
output [BIT-1:0] sum; 
output cout;

wire [BIT:0] c0;

assign c0[0]=cin;
assign cout=c0[BIT-1];

genvar i;

for(i=0; i<BIT; i=i+1)
	fa fa1(a[i], b[i], c0[i], sum[i], c0[i+1]);

endmodule

//----------------TEST BENCH----------------
module tb();

parameter BIT=8;

reg [BIT-1:0] a, b;
reg cin;
wire [BIT-1:0] sum;
wire cout;

fa_8bit dut(a, b, cin, sum, cout);

initial begin 
	$monitor("time=%0t, a=%0d, b=%0d, cin=%0d, sum=%0d, cout=%0d", $time, a, b, cin, sum, cout);

	repeat(5) begin
		a=$random; b=$random; cin=$random; #5;	
	end

end

endmodule
