module gray_code_up_down_counter(clk, rst, up_down, count);

parameter BIT=3;

input clk, rst, up_down;
output reg [BIT-1:0] count;
reg [BIT-1:0] count_t; // stores binary count value

integer i;

initial begin
	count=0;
end

always @(posedge clk) begin
	if(rst) begin
		count=0; count_t=0;
	end
	else if(up_down) // 1:up_counter 0:down_counter
	begin
		count_t = count_t + 1;
		count = bin_to_gray(count_t);
	end
	else // 1:up_counter 0:down_counter
	begin
		count_t = count_t - 1;
		count = bin_to_gray(count_t);
	end
end

function [BIT-1:0] bin_to_gray(input [BIT-1:0] bin_num);
begin
	bin_to_gray[BIT-1]=bin_num[BIT-1];
	for(i=0; i<BIT-1 ; i=i+1) begin
		bin_to_gray[i] = bin_num[i+1] ^ bin_num[i];
	end	
end
endfunction

endmodule



//--------------------TEST BENCH-------------------

module tb();

parameter BIT=3;

reg clk, rst, up_down;
wire [BIT-1:0] count;

gray_code_up_down_counter dut(clk, rst, up_down, count);

initial begin
	clk=0; up_down=0;
	forever #5 clk=~clk;
end

initial begin 
	$monitor("time=%0t, updown=%0d, count=%3b", $time, up_down, count);
	rst=1; #10;
	rst=0;

	up_down=1;
	#100;	
	up_down=0;
	#100;	
	$finish;
end

endmodule
