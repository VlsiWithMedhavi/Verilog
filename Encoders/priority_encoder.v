`timescale 1ns/1ns

module priority_encoder(inp, out);

parameter INPUT_BIT=8;
parameter OUTPUT_BIT=$clog2(INPUT_BIT);

input [INPUT_BIT-1:0] inp;
output reg [OUTPUT_BIT-1:0] out;

always @(inp) begin
	casex(inp) // csex will try to match input to one of the dont care combinations i.e take dont care into conditions
		8'b1 : out=3'b000;
		8'b1X : out=3'b001;
		8'b1XX : out=3'b010;
		8'b1XXX : out=3'b011;
		8'b1_XXXX : out=3'b100;
		8'b1X_XXXX : out=3'b101;
		8'b1XX_XXXX : out=3'b110;
		8'b1XXX_XXXX : out=3'b111;
		default : out=3'bX;
	endcase
end

endmodule


//---------------TEST BENCH-----------------

module tb();

parameter INPUT_BIT=8;
parameter OUTPUT_BIT=$clog2(INPUT_BIT);

reg [INPUT_BIT-1:0] inp;
wire [OUTPUT_BIT-1:0] out;

priority_encoder dut(inp, out);

initial begin
	$monitor("time=%0t, inp=%0b, out=%0d", $time, inp, out);

	inp=8'b0000_0001; #5;
	inp=8'b0000_0010; #5;
	inp=8'b0000_0100; #5;
	inp=8'b0000_1000; #5;
	inp=8'b0001_0000; #5;
	inp=8'b0010_0000; #5;
	inp=8'b0100_0000; #5;
	inp=8'b1000_0000; #5;

	inp=8'b1000_0100; #5;
	inp=8'b0000_0011; #5;
	inp=8'b0010_0010; #5;
end

endmodule
