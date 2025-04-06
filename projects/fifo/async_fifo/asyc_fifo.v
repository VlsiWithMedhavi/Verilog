module asyc_fifo(wr_clk, rd_clk, rst, wr_en, rd_en, wr_error, rd_error, wr_data, rd_data, full, empty);

parameter DEPTH=16, WIDTH=8;
parameter PTR_WIDTH=$clog2(DEPTH);

input wr_clk, rd_clk, rst, rd_en, wr_en;
input [WIDTH-1:0] wr_data;
output reg wr_error, rd_error, full, empty;
output reg [WIDTH-1:0] rd_data;

reg [WIDTH-1:0] mem [DEPTH-1:0];
reg [PTR_WIDTH:0] wr_ptr, rd_ptr; // want to count till DEPTH=16 so
reg [PTR_WIDTH:0] wr_ptr_g, rd_ptr_g; // want to count till DEPTH=16 so
reg [PTR_WIDTH:0] wr_ptr_rd_clk, rd_ptr_wr_clk; // synchronize signal to diff rd and wr clocks
integer i;

always @(posedge wr_clk) begin
	if(rst == 1) begin
		wr_error=0;	rd_error=0;
		full=0; empty=0;
		rd_data=0;
		wr_ptr=0; rd_ptr=0;
		for(i=0; i<DEPTH; i=i+1)
			mem[i]=0;
	end
	
	else begin
		if(wr_en == 1) begin
			if(full == 0) begin
				mem[wr_ptr]=wr_data;
				wr_error=0;
				wr_ptr=wr_ptr+1; // write inc only during data write times
				wr_ptr_g=b_g(wr_ptr); // convert binary to gray code to avoid glitches i.e intermediatory states
			end
			else
				wr_error=1; // full=1
		end
	end
end

always @(posedge wr_clk)
	rd_ptr_wr_clk <= rd_ptr_g; // synchronize rd_ptr to write clock

always @(posedge rd_clk) begin
	if(rst == 1) begin
		full=0; empty=0;
	end
	else begin
		if(rd_en == 1) begin
			if(empty == 0) begin
				rd_data=mem[rd_ptr];
				rd_error=0;
				rd_ptr=rd_ptr+1;
				rd_ptr_g=b_g(rd_ptr); // convert binary to gray code to avoid glitches i.e intermediatory states
			end
			else begin
				rd_error=1; // full=1
			end
		end
	end
end

always @(posedge rd_clk)
	wr_ptr_rd_clk <= wr_ptr_g; // synchronize wr_ptr to read clock


always @(*) begin
	// condition for "full"
	if(wr_ptr_g>=DEPTH && rd_ptr_wr_clk==1'b0) 
	begin
		full=1; // fifo is full flag eneabled
		empty=0;
	end
	// condition for "empty"
	else if(rd_ptr_g >= wr_ptr_rd_clk) 
	begin
		empty=1; // fifo is full flag eneabled
		full=0;
	end
	else begin
		full=0; empty=0;
	end
end

function reg [PTR_WIDTH:0] b_g(input [PTR_WIDTH:0] bin_num);
begin
	for(i=0; i<PTR_WIDTH; i=i+1)
		b_g[i]=bin_num[i]^bin_num[i+1];
	b_g[PTR_WIDTH]=bin_num[PTR_WIDTH];
end
endfunction 

endmodule
