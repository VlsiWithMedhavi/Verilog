module priority_encoder(inp, out);

parameter INP_BIT=8;
parameter OUT_BIT=$clog2(INP_BIT);

input [INP_BIT-1:0] inp;
output reg [OUT_BIT-1:0] out;

always @(inp) begin
	casex(inp)
	8'bxxxx_xxx1: out=3'b000; 
	8'bxxxx_xx1x: out=3'b001;
	8'bxxxx_x1xx: out=3'b010;
	8'bxxxx_1xxx: out=3'b011;
	8'bxxx1_xxxx: out=3'b100;
	8'bxx1x_xxxx: out=3'b101;
	8'bx1xx_xxxx: out=3'b110;
	8'b1xxx_xxxx: out=3'b111;
	endcase
end

endmodule



//---------------TEST BENCH--------------

module tb();

parameter INP_BIT=8;
parameter OUT_BIT=$clog2(INP_BIT);

reg [INP_BIT-1:0] inp;
wire [OUT_BIT-1:0] out;

priority_encoder dut(inp, out);

initial begin
	$monitor("time=%0t, inp=%8b, out=%0d", $time, inp, out);
	repeat(5) begin
		inp=$random; #5;
	end
end

endmodule
