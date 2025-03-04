`timescale 1ns/1ns
`include "mux_2x1.v"

module mux_4x1(inp, sel, out);

input [3:0] inp;
input [1:0]sel;
output out;

wire [1:0] out0;

mux_2x1 m1(inp[1:0], sel[0], out0[0]);
mux_2x1 m2(inp[3:2], sel[0], out0[1]);
mux_2x1 m3(out0, sel[1], out);

endmodule


//-------------------TEST BENCH------------------

module tb();

reg [3:0] inp;
reg [1:0] sel;
wire out;

mux_4x1 dut(inp, sel, out);

initial begin
	$monitor("time=%0t, inp=%0b, sel=%0b, out=%0b", $time, inp, sel, out);
	
	inp=4'b1011; 
	sel=2'b00; #5;
	sel=2'b01; #5;
	sel=2'b10; #5;
	sel=2'b11; #5;

	$finish;
end

endmodule
