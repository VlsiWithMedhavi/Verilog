module mux_4x1(inp, sel, out);

parameter INP_NUM=4;
parameter SEL_NUM=$clog2(INP_NUM);

input [INP_NUM-1:0] inp;
input [SEL_NUM-1:0] sel;
output reg out;

always @(inp or sel) begin

`ifdef CASE
	case(sel)
		0: out=inp[0];	
		1: out=inp[1];	
		2: out=inp[2];	
		3: out=inp[3];	
		default: out='bx;
	endcase
`endif

`ifdef IF
	if(sel==0)
		out=inp[0];
	else if(sel==1)
		out=inp[1];
	else if(sel==2)
		out=inp[2];
	else if(sel==3)
		out=inp[3];
	else 
		out='bx;
`endif

end

endmodule


//-----------------------TEST BENCH------------------
module tb();

parameter INP_NUM=4;
parameter SEL_NUM=$clog2(INP_NUM);

reg [INP_NUM-1:0] inp;
reg [SEL_NUM-1:0] sel;
wire out;
	
mux_4x1 dut(inp, sel, out);
a
initial begin
	$monitor("time=%0t, inp=%0b, sel=%0d, out=%0d", $time, inp, sel, out);

	inp=$random; 
	sel=0; #5;
	sel=1; #5;
	sel=2; #5;
	sel=3; #5;
	$finish;
end

endmodule

