`timescale 1ns/1ns

module bcd_to_7segment(bcd_num, output_seg);

input [3:0] bcd_num;
output reg [6:0] output_seg;

always @(*) begin
	case(bcd_num) 
		0 : output_seg=7'b1111_110;
		1 : output_seg=7'b0110_000;
		2 : output_seg=7'b1101_101;
		3 : output_seg=7'b1111_001;
		4 : output_seg=7'b0110_011;
		5 : output_seg=7'b1011_011;
		6 : output_seg=7'b1011_111;
		7 : output_seg=7'b1110_000;
		8 : output_seg=7'b1111_111;
		9 : output_seg=7'b1111_011;
		default : output_seg=7'b0000_000;
	endcase
end

endmodule

//----------------TEST BENCH---------------------


module tb();

reg [3:0] bcd_num;
wire [6:0] output_seg;

bcd_to_7segment dut(bcd_num, output_seg);

initial begin
	$monitor("time=%0t, bcd_num=%0d, output_seg=%0b", $time, bcd_num, output_seg);

	bcd_num=0; #5;
	bcd_num=1; #5;
	bcd_num=2; #5;
	bcd_num=3; #5;
	bcd_num=4; #5;
	bcd_num=5; #5;
	bcd_num=6; #5;
	bcd_num=7; #5;
	bcd_num=8; #5;
	bcd_num=9; #5;
	$finish;
end
endmodule
