//**********************************************************************************************
//**********************************************************************************************
//									 BASIC DIGITAL MEMORY
//
//	Functionality: read and writes data to and from memory bank
//
//	Signals:
//			clk_i: synchronizes data information during read and write cycles
//			rst_i: resets the memory contents to zero
//			valid_i: recieves a signal signaling a valid transaction is being made 
//			ready_o: memory signals that it is ready to recieves information
//			wr_en_i: write tx is enabled(1), disable(0)
//			rd_en_i: read tx is enabled(1), disable(0)
//			addr_i: address to write/read to.from memory
//			wdata_i: data that user wants to write to a specific memory location
//			rdata_o: data that user wants to read from a specific memory location
//			presp_o: address adress error flag "1", no error "0"
//			load_i: load memory with hex file image content
//			fetch_i: load memory content to another hex file image
//
//	Author: Medhavi Kosta (M.Tech in VLSI and Embedded design Engineering)
//
//**********************************************************************************************
//**********************************************************************************************


module memory_ctrl(clk_i, rst_i, valid_i, ready_o, wr_en_i, rd_en_i, addr_i, wdata_i, rdata_o, presp_o, load_i, fetch_i);

parameter MEM_DEPTH=128; // 128 different address locations in a memory
parameter ADDR_WIDTH=$clog2(MEM_DEPTH);
parameter DATA_WIDTH=8;

// we have formed a memory that stores 128*8 bits -> 1024 bits -> 1Kb memory

input clk_i, rst_i, valid_i, wr_en_i, rd_en_i, load_i, fetch_i;
input [ADDR_WIDTH-1:0] addr_i;
input [DATA_WIDTH-1:0] wdata_i;
output reg [DATA_WIDTH-1:0] rdata_o;
output reg ready_o, presp_o;

reg [DATA_WIDTH-1:0] mem [MEM_DEPTH-1:0]; // declaring memory register bank

integer i;

always @(posedge clk_i) begin // data transfer should take place at positive clock edges only
	if(rst_i) begin
		rdata_o=0; ready_o=0; presp_o=0;
		for(i=0; i<MEM_DEPTH; i=i+1)
			mem[i]=0;
	end
	else begin
		if(load_i) // load memory with hex file image
			$readmemb("image_i.hex", dut.mem, 0, MEM_DEPTH-1);
		else if(fetch_i) // load hex file with memory content			
			$writememb("image_o.hex", dut.mem, 0, MEM_DEPTH-1);
		else if(valid_i) begin // processor send a valid signal
			ready_o=1; // as input is valid, processor signals that it is ready to undergo a valid tx
			if(addr_i>0 && addr_i<MEM_DEPTH) begin // valid address range i.e (0-127)
				presp_o=0; // no addr range error
				if(wr_en_i) // if write tx is enabled
					mem[addr_i]=wdata_i;		
				if(rd_en_i) // if read tx is enabled
					rdata_o=mem[addr_i];		
			end
			else
				presp_o=1; // addr range error
		end
		else // memory control is set to not ready state if processor is not sending a valid input data
			ready_o=0;
	end
end

endmodule

//**********************************************************************************************
//**********************************************************************************************
//                            		    TEST BENCH
//**********************************************************************************************
//**********************************************************************************************

module tb();

parameter MEM_DEPTH=128; // 128 different address locations in a memory
parameter ADDR_WIDTH=$clog2(MEM_DEPTH);
parameter DATA_WIDTH=8;


reg clk_i, rst_i, valid_i, wr_en_i, rd_en_i;
reg [ADDR_WIDTH-1:0] addr_i;
reg [DATA_WIDTH-1:0] wdata_i;
wire [DATA_WIDTH-1:0] rdata_o;
wire ready_o, presp_o;

integer i;

reg [8*25-1:0] testname; // testname string declaration

memory_ctrl dut(clk_i, rst_i, valid_i, ready_o, wr_en_i, rd_en_i, addr_i, wdata_i, rdata_o, presp_o);

initial begin
	clk_i=0;
	forever #5 clk_i=~clk_i;
end


initial begin
	$monitor("time=%0t, wr=%0d, rd=%0d, addr=%0d, wdata=%0d, mem[%0d]=%0d", $time, wr_en_i, rd_en_i, addr_i, wdata_i, addr_i, dut.mem[addr_i]);

	$value$plusargs("test=%s", testname);
	
	valid_i=0; wr_en_i=0; rd_en_i=0; addr_i=0; wdata_i=0; // initializing all data to 0

	rst_i=1;
	repeat(2)
		@(posedge clk_i);
	
	rst_i=0;
	
	case(testname)
	"TEST_MEM_RESET": begin
		rst_i=1; // enabling memory reset
		repeat(2)
			@(posedge clk_i);
		rst_i=0; // mem reset finished
	end
	"TEST_FD_WRITE_READ": begin
		fd_write_mem(0, 5);
		wr_en_i=0; // disable further writing of data
		valid_i=0; // no tx further
		fd_read_mem(0, 5);
		rd_en_i=0; // disable further reading of data
		valid_i=0; // no tx further
	end 
	"TEST_BD_WRITE_READ": begin
		bd_write_mem(0, 5);
		wr_en_i=0; // disable further writing of data
		valid_i=0; // no tx further
		bd_read_mem(0, 5);
		rd_en_i=0; // disable further reading of data
		valid_i=0; // no tx further
	end 
	endcase

	$finish;
	
end

task fd_write_mem(input [ADDR_WIDTH-1:0] start_addr, input [MEM_DEPTH-1:0] num_loc);
begin
	for(i=start_addr; i<num_loc; i=i+1) begin
		valid_i=1'b1;
		wait(ready_o==1'b1);
		wr_en_i=1;
		addr_i=i;
		wdata_i=i*2;
		@(posedge clk_i); // we want to synchronise the value change with clock, i.e see the effect in value changes.   
	end
end 
endtask

task fd_read_mem(input [ADDR_WIDTH-1:0] start_addr, input [MEM_DEPTH-1:0] num_loc);
begin
	for(i=start_addr; i<num_loc; i=i+1) begin
		valid_i=1'b1;
		wait(ready_o==1'b1);
		rd_en_i=1;
		addr_i=i;
		@(posedge clk_i); // we want to synchronise the value change with clock, i.e see the effect in value changes.   
	end
	@(posedge clk_i); // wait for the last rd tx to complete
end
endtask

task bd_write_mem(input [ADDR_WIDTH-1:0] start_addr, input [MEM_DEPTH-1:0] num_loc);
begin
	for(i=start_addr; i<num_loc; i=i+1) begin
		dut.mem[i]=i*2; // need to manually write data into memory
	end
		$writememb("mem_bd.hex", dut.mem, start_addr, start_addr+num_loc-1);
end 
endtask

task bd_read_mem(input [ADDR_WIDTH-1:0] start_addr, input [MEM_DEPTH-1:0] num_loc);
begin
	$readmemb("mem_bd.hex", dut.mem, start_addr, start_addr+num_loc-1);
end
endtask

endmodule



