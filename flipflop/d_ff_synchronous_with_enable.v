
module d_ff_synchronous_with_enable(en, clk, d, set, rst, q, qbar);

input en, clk, d, set, rst;
output reg q;
output qbar;

assign qbar = ~q;

always @(posedge clk) begin
	if(en==1'b0) begin
		q=q; // hold previous value
	end
	else begin
		if(rst==1'b1) 
			q=0;
		else if(set==1'b1) 
			q=1;
		else
			q=d;
	end
		
end

endmodule


//---------------TEST BENCH----------------

module tb();

reg en, clk, d, set, rst;
wire q, qbar;

d_ff_synchronous_with_enable dut(en, clk, d, set, rst, q, qbar);

initial begin
	clk=1'b0;
	forever #5 clk=~clk;
end

initial begin
	$monitor("$time=%0t, en=%0d, d=%0d, set=%0d, rst=%0d, q=%0d, qbar=%0d", $time, en, d, set, rst, q, qbar);
	
	en=1'b0; d=$random; set=$random; rst=$random; #10;
	en=1'b1; d=$random; set=1'b0; rst=1'b1; #10;
	en=1'b1; d=$random; set=1'b1; rst=1'b0; #10;
	en=1'b1; d=$random; set=1'b1; rst=1'b1; #10;
	en=1'b1; d=$random; set=1'b0; rst=1'b0; #10;
	en=1'b0; d=$random; set=$random; rst=$random; #10;
	#100;
	$finish;
end

endmodule
