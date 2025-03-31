`include "fs.v"

module fs_3bit(a, b, cin, sub, bout);

parameter BIT=3;

input [BIT-1:0] a, b;
input cin;
output [BIT-1:0] sub;
output bout;

wire [BIT:0] c0;

assign c0[0]=cin;
assign bout=c0[BIT];

genvar i;
for(i=0; i<BIT; i=i+1)
	fs fs1(a[i], b[i], c0[i], sub[i], c0[i+1]);

endmodule

//-------------TEST BENCH--------------

module tb();

parameter BIT=3;

reg [BIT-1:0] a, b;
reg cin;
wire [BIT-1:0] sub;
wire bout;


fs_3bit dut(a, b, cin, sub, bout);

initial begin 
	$monitor("time=%0t, a=%0d, b=%0d, cin=%0d, sub=%0d, bout=%0d", $time, a, b, cin, sub, bout);
	
	repeat(5) begin
		a=$random; b=$random; cin=$random; #5;	
	end

end

endmodule
