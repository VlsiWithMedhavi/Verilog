//=========================================================================
//=========================================================================
//                             JOHNSON COUNTER
//=========================================================================
//
//	Functionality: inverted output of last ff is fed as input to first ff
//	States: for n ff --> 2n states
//
//=========================================================================
//=========================================================================


module johnson_counter(clk, rst, out);

parameter NUM_FF=4;

input clk, rst;
output reg [NUM_FF-1:0] out;

always @(posedge clk) begin
	if(rst)
		out='b0; // reset state start with "0000"
	else 
		out <= {~out[0], out[NUM_FF-1:1]};
end

endmodule

//----------------------------TEST BENCH------------------

module tb();

parameter NUM_FF=4;

reg clk, rst;
wire [NUM_FF-1:0] out;

johnson_counter #(.NUM_FF(4)) dut(clk, rst, out);

initial begin
	clk=0;
	forever #5 clk=~clk;
end

initial begin
	$monitor("time=%0t, rst=%0d, out=%b", $time, rst, out);

	rst=1; #10;
	rst=0;
	#100;
	$finish;
end
	
endmodule
