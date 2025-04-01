//**********************************************************************************************
//**********************************************************************************************
//									 DUAL PORT RAM MEMORY
//
//	Functionality: read and writes data to and from memory bank
//				   We have a seperate addr buses for write and read so that the
//				   txs can be executed simultaneously and speedily
//
//	Signals:
//			clk_i: synchronizes data information during read and write cycles
//			rst_i: resets the memory contents to zero
//			valid_i: recieves a signal signaling a valid transaction is being made 
//			ready_o: memory signals that it is ready to recieves information
//			wr_en_i: write tx is enabled(1), disable(0)
//			rd_en_i: read tx is enabled(1), disable(0)
//			wr_addr_i: write memory addr 
//			rd_addr_i: read memory addr
//			wr_data_i: data that user wants to write to a specific memory location
//			rd_data_o: data that user wants to read from a specific memory location
//
//	Author: Medhavi Kosta (M.Tech in VLSI and Embedded design Engineering)
//
//**********************************************************************************************
//**********************************************************************************************

module dual_port_ram(clk_i, rst_i, valid_i, ready_o, wr_en_i, rd_en_i, wr_addr_i, rd_addr_i, wr_data_i, rd_data_o);

// creating 1KB of memory = 8*128
parameter MEM_DEPTH=128;
parameter ADDR_WIDTH=$clog2(MEM_DEPTH);
parameter DATA_WIDTH=8;

input clk_i, rst_i, valid_i, wr_en_i, rd_en_i;
input [ADDR_WIDTH-1:0] wr_addr_i, rd_addr_i;
input [DATA_WIDTH-1:0] wr_data_i;
output reg [DATA_WIDTH-1:0] rd_data_o;
output reg ready_o;

reg [DATA_WIDTH-1:0] mem [MEM_DEPTH-1:0];

integer i;

always @(posedge clk_i) begin
	if(rst_i) begin
		rd_data_o=0; ready_o=0;
		for(i=0; i<MEM_DEPTH; i=i+1) 
			mem[i]=0;
	end
	else begin
		if(valid_i) begin
			ready_o=1;
			if(wr_en_i) 
				mem[wr_addr_i]=wr_data_i;
			if(rd_en_i) 
				rd_data_o=mem[rd_addr_i];
		end
		else
			ready_o=0;
	end
end

endmodule

//**********************************************************************************************
//**********************************************************************************************
//                                    TEST BENCH
//**********************************************************************************************
//**********************************************************************************************

module tb();

parameter MEM_DEPTH=128;
parameter ADDR_WIDTH=$clog2(MEM_DEPTH);
parameter DATA_WIDTH=8;

reg clk_i, rst_i, valid_i, wr_en_i, rd_en_i;
reg [ADDR_WIDTH-1:0] wr_addr_i, rd_addr_i;
reg [DATA_WIDTH-1:0] wr_data_i;
wire [DATA_WIDTH-1:0] rd_data_o;
wire ready_o;

integer i;

dual_port_ram dut(clk_i, rst_i, valid_i, ready_o, wr_en_i, rd_en_i, wr_addr_i, rd_addr_i, wr_data_i, rd_data_o);

initial begin
	clk_i=0;
	forever #5 clk_i=~clk_i;
end

initial begin
	valid_i=0; wr_en_i=0; rd_en_i=0;
	wr_addr_i=0; rd_addr_i=0;
	wr_data_i=0;

	rst_i=1;
	repeat(2)
		@(posedge clk_i);
	rst_i=0;
	
	valid_i=1;
	// wr data to all location	valid_i=1;
	wait(ready_o==1'b1);
	wr_en_i=1;
	for(i=0; i<MEM_DEPTH; i=i+1) 
	begin
		wr_addr_i=i;
		wr_data_i=i*2;
		@(posedge clk_i);
	end

	wr_en_i=0;
	valid_i=0;
	wait(ready_o==1'b0);
	
	// wr/rd data at the same time
	valid_i=1;
	wait(ready_o==1'b1);
	rd_en_i=1;
	rd_addr_i=22;
	wr_en_i=1;
	wr_addr_i=33; // because of dual port data will be read from 22 and written to 33
	wr_data_i=33;
	@(posedge clk_i);
	@(posedge clk_i);

	$finish;
	
end

endmodule
