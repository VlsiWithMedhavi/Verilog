module encoder_8_to_3(inp, out);

parameter INP_BIT=8;
parameter OUT_BIT=$clog2(INP_BIT);

input [INP_BIT-1:0] inp;
output reg [OUT_BIT-1:0] out;

always @(inp) begin
	case(inp)
	8'b0000_0001: out=3'b000; 
	8'b0000_0010: out=3'b001;
	8'b0000_0100: out=3'b010;
	8'b0000_1000: out=3'b011;
	8'b0001_0000: out=3'b100;
	8'b0010_0000: out=3'b101;
	8'b0100_0000: out=3'b110;
	8'b1000_0000: out=3'b111;
	endcase
end

endmodule



//---------------TEST BENCH--------------

module tb();

parameter INP_BIT=8;
parameter OUT_BIT=$clog2(INP_BIT);

reg [INP_BIT-1:0] inp;
wire [OUT_BIT-1:0] out;

encoder_8_to_3 dut(inp, out);

initial begin
	$monitor("time=%0t, inp=%0d, out=%3b", $time, inp, out);
	inp=0; #5;
	inp=1; #5;
	inp=2; #5;
	inp=3; #5;
	inp=4; #5;
	inp=5; #5;
	inp=6; #5;
	inp=7; #5;
end

endmodule
