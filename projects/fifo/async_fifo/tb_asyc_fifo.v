`include "asyc_fifo.v"
module tb();

parameter DEPTH=16, WIDTH=8;
parameter PTR_WIDTH=$clog2(DEPTH);
reg wr_clk, rd_clk, rst, rd_en, wr_en;
reg [WIDTH-1:0] wr_data;
wire wr_error, rd_error, full, empty;
wire [WIDTH-1:0] rd_data;

integer i;
reg [8*30:0] testname;

asyc_fifo dut(wr_clk, rd_clk, rst, wr_en, rd_en, wr_error, rd_error, wr_data, rd_data, full, empty);

always begin
	rd_clk = 0; #15;
	rd_clk = 1; #15;
end
always begin
	wr_clk = 0; #5;
	wr_clk = 1; #5;
end

initial begin

	$value$plusargs("testname=%s",testname);
	rst=1;
	rd_en=0; wr_en=0;
	#20
	rst=0;

	case(testname)
		"test_full" : begin 
			write_data(DEPTH);
		end
		"test_initial_empty" : begin
			read_data(DEPTH);
		end
		"test_empty" : begin
			write_data(DEPTH);
			read_data(DEPTH);
		end
		"test_full_error" : begin
			write_data(20);
		end
		"test_empty_error" : begin 
			write_data(5);
			read_data(6);
		end
		"test_wr_rd" : begin
			repeat(16) begin
				// wr tx
    			@(posedge wr_clk);
				rd_en=0;
    			wr_en=1;
    			wr_data=1;
				@(posedge wr_clk); // wait for last tx to take effect
				wr_en=0; // disable wr tx
				@(posedge wr_clk); // wait for wr_en=0 to take effect

				// rd tx
    			@(posedge rd_clk);
				rd_en=1;
    			wr_en=0;
				@(posedge rd_clk); // wait for last tx to take effect
				rd_en=0; // disable wr tx
				@(posedge rd_clk); // wait for wr_en=0 to take effect
			end
		end
	endcase
	$finish;
end

task write_data(input integer wr_depth);
begin
	for(i=0; i<wr_depth; i=i+1) begin
    	@(posedge wr_clk);
		rd_en=0;
    	wr_en=1;
    	wr_data=i*2;
    end
	@(posedge wr_clk); // wait for last tx to take effect
	wr_en=0; // disable wr tx
	@(posedge wr_clk); // wait for wr_en=0 to take effect
end
endtask

task read_data(input integer rd_depth);
begin
	for(i=0; i<rd_depth; i=i+1) begin
    	@(posedge rd_clk);
		wr_en=0;
    	rd_en=1;
	end
	@(posedge rd_clk); // wait for last tx to take effect
	rd_en=0; // disable wr tx
	@(posedge rd_clk); // wait for wr_en=0 to take effect
end
endtask

endmodule
