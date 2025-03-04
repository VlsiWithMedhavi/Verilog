`timescale 1ns/1ns
`include "mux_4x1.v"
`include "mux_2x1.v"


module mux_8x1(inp, sel, out);

input [7:0] inp;
input [2:0]sel;
output out;

wire [1:0] out0;

mux_4x1 m1(inp[3:0], sel[1:0], out0[0]);
mux_4x1 m2(inp[7:4], sel[1:0], out0[1]);
mux_2x1 m3(out0, sel[2], out);

endmodule


//-------------------TEST BENCH------------------

module tb();

reg [7:0] inp;
reg [2:0] sel;
wire out;

mux_8x1 dut(inp, sel, out);

initial begin
	$monitor("time=%0t, inp=%0b, sel=%0d, out=%0b", $time, inp, sel, out);
	
	inp=8'b10110011; 
	sel=3'b000; #5;
	sel=3'b001; #5;
	sel=3'b010; #5;
	sel=3'b011; #5;
	sel=3'b100; #5;
	sel=3'b101; #5;
	sel=3'b110; #5;
	sel=3'b111; #5;

	$finish;
end

endmodule
