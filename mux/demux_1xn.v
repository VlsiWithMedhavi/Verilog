`timescale 1ns/1ns

module demux_1xn(inp, sel, out);

parameter NUM_OUT=8;
parameter NUM_SEL=$clog2(NUM_OUT);

input inp;
input [NUM_SEL-1:0] sel;
output wire [NUM_OUT-1:0] out;

assign out[sel] = inp;

endmodule


//-------------------TEST BENCH------------------

module tb();


parameter NUM_OUT=8;
parameter NUM_SEL=$clog2(NUM_OUT);

reg inp;
reg [NUM_SEL-1:0]sel;
wire [NUM_OUT-1:0] out;

demux_1xn dut(inp, sel, out);

initial begin
	$monitor("time=%0t, inp=%0b, sel=%0d, out=%0b", $time, inp, sel, out);
	
	inp=1'b1; 
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
