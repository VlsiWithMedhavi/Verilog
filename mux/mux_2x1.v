`timescale 1ns/1ns

module mux_2x1(inp, sel, out);

input [1:0] inp;
input sel;
output out;

assign out = sel ? inp[1] : inp[0];

endmodule


//-------------------TEST BENCH------------------

module tb();

reg [1:0] inp;
reg sel;
wire out;

mux_2x1 dut(inp, sel, out);

initial begin
	$monitor("time=%0t, inp=%0b, sel=%0b, out=%0b", $time, inp, sel, out);
	
	sel=1'b0; inp=2'b10; #5;
	sel=1'b1; inp=2'b10; #5;
	$finish;
end

endmodule
