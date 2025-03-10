module ring_counter(clk, clr, en, preset_inp, count);

parameter BIT=4;

input clk, clr, en, preset_inp;
output reg [BIT-1:0] count;

reg count_f; // 1: "0001" restack to --> "1000"

initial begin
	count=0; count_f=0;
end

always @(negedge clk) begin	
	if(preset_inp || count_f) begin // initial phase, as count reaches "0001" --< reset to 0 --> start again from "1000"
		count=0;
		count[BIT-1]=1;
		count_f=0;  // as count restacked to 1 on MSB again reset to 0
	end
	else if (clr) begin
		count=0; count_f=0;
	end
	else if(en) begin
		count=count>>1;
		if(count[0]==1)
			count_f=1;
	end
	else
		count=0;
end

endmodule


//---------------TEST BENCH-----------------

module tb();

parameter BIT=4;

reg clk, clr, en, preset_inp
;
wire [BIT-1:0] count;

ring_counter dut(clk, clr, en, preset_inp, count);

initial begin
	clk=1'b0;
	forever #5 clk=~clk;
end

initial begin

	$monitor("time=%0t, en=%0d, clr=%0d, count=%4b", $time, en, clr, count);

	en=1'b0; clr=1'b1; preset_inp=0; #15;
	en=1'b1; clr=1'b0; preset_inp=1; #10;
	preset_inp=0;
	#300;
	$finish;
end

endmodule
