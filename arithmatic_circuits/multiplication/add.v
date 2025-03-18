module add(inp1, inp2, sum);
 
parameter BIT_SIZE=8;

input [BIT_SIZE-1:0] inp1, inp2;
output reg [7:0] sum;

initial begin
	sum=0;
end

always @(*)
	sum=inp1+inp2;
endmodule
