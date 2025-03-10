module up_down_sync_clr_counter(clk, en, clr, pre_load, mode, count, data_load_f);

parameter BIT=4;

input clk, en, clr, mode;
input [BIT-1:0] pre_load;
output reg [BIT-1:0] count;
output reg data_load_f; // 0 = data not loaded, 1 = data loaded

initial begin
	data_load_f=0; count=0;
end

always @(posedge clk) begin
	if(en && !data_load_f) begin
		count=pre_load;
		data_load_f=1;
	end
	else if(clr) begin
		count=0;
		data_load_f=0;
	end
	else if(mode) begin
		count=count+1; // mode=1, up-counter
		end
	else
		count=count-1; // mode=0, down-counter
end

endmodule



//----------TEST CASE-----------

module tb();

parameter BIT=4;

reg clk, en, clr, mode;
reg [BIT-1:0] pre_load;
wire [BIT-1:0] count;
wire data_load_f;

up_down_sync_clr_counter dut(clk, en, clr, pre_load, mode, count, data_load_f);

initial begin
	clk=1'b0;
	forever #5 clk=~clk;
end

initial begin
	$monitor("time=%0t, en=%0d, clr=%0d, pre_load=%0d, mode=%0d, count=%0d, data_load_f=%0d", $time, en, clr, pre_load, mode, count, data_load_f);
	
	pre_load=3; mode=1;
	en=1'b0; #5;
	
	en=1'b1; clr=1'b0;
	#60;

	clr=1'b1; #5;
	clr=1'b0; pre_load=10; mode=0;
	#40;
	mode=1; #50;

	$finish;		
end

endmodule
