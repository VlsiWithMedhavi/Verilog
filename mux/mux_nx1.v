
`timescale 1ns/1ns


module mux_nx1(inp, sel, out);

parameter NUM_INP=8;
parameter NUM_SEL=$clog2(NUM_INP);

input [NUM_INP-1:0] inp;
input [NUM_SEL-1:0]sel;
output out;

assign out = inp[sel];

endmodule


//-------------------TEST BENCH------------------

module tb();


parameter NUM_INP=8;
parameter NUM_SEL=$clog2(NUM_INP);

reg [NUM_INP-1:0] inp;
reg [NUM_SEL-1:0]sel;
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
