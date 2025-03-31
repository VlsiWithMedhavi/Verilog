module ha(a, b, sum, carry);

`ifdef BEHAV
input [7:0] a, b;
`endif

`ifdef DATA_FLOW
input [7:0] a, b;
`endif

`ifdef STRUCT
input a, b;
`endif

`ifdef DATA_FLOW
output [7:0] sum;
output carry;
`endif

`ifdef BEHAV
output reg [7:0] sum;
output reg carry;
`endif

`ifdef STRUCT
output sum;
output carry;
`endif

`ifdef DATA_FLOW
assign {carry,sum} = a + b;
`endif

`ifdef BEHAV
always @(a or b) begin
	{carry,sum} = a + b;
end
`endif

`ifdef STRUCT
xor g1(sum, a, b);
and g2(carry, a, b);
`endif

endmodule



//------------------TEST BENCH-----------------

module tb();

`ifdef BEHAV
reg [7:0] a, b;
wire [7:0] sum;
wire carry;
`endif

`ifdef DATA_FLOW
reg [7:0] a, b;
wire [7:0] sum;
wire carry;
`endif

`ifdef STRUCT
reg a, b;
wire sum;
wire carry;
`endif

ha dut(a, b, sum, carry);

initial begin
	$monitor("time=%0t, a=%0d, b=%0d, sum=%0d, carry=%0d", $time, a, b, sum, carry);

	a=5; b=1; #5;
	a=3; b=7; #5;
	$finish;
end


endmodule
