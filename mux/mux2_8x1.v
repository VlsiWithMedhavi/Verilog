`include "mux_4x1.v"


module mux_8x1(inp, sel, out);

parameter INP_NUM=8;
parameter SEL_NUM=$clog2(INP_NUM);

input [INP_NUM-1:0] inp;
input [SEL_NUM-1:0] sel;
output out;

wire n1, n2;

mux_4x1 m1(inp[3:0], sel[1:0], n1);
mux_4x1 m2(inp[7:4], sel[1:0], n2);
mux_4x1 m3({n2,1'b0,n1,1'b0}, {sel[2],1'b1}, out);

endmodule

//-----------------------TEST BENCH------------------
module tb();

parameter INP_NUM=8;
parameter SEL_NUM=$clog2(INP_NUM);

reg [INP_NUM-1:0] inp;
reg [SEL_NUM-1:0] sel;
wire out;
	
mux_8x1 dut(inp, sel, out);

initial begin
	$monitor("time=%0t, inp=%0b, sel=%0d, out=%0d", $time, inp, sel, out);

	inp=8'b1101_1001; 
	sel=0; #5;
	sel=1; #5;
	sel=2; #5;
	sel=3; #5;
	sel=4; #5;
	sel=5; #5;
	sel=6; #5;
	sel=7; #5;
	$finish;
end

endmodule

