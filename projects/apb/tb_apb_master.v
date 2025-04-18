`include "apb_master.v"

module tb();

parameter ADDR_WIDTH=32;
parameter DATA_WIDTH=32;

reg apb_transfer_i, apb_wr_rd_i;
reg [ADDR_WIDTH-1:0] apb_write_addr_i, apb_read_addr_i;
reg [DATA_WIDTH-1:0] apb_write_data_i;
wire [DATA_WIDTH-1:0] apb_read_data_o;

reg pclk_i, prst_i;
wire pready_i;
wire [DATA_WIDTH-1:0] prdata_i;
wire pwrite_o, penable_o, psel1_o; 
wire [ADDR_WIDTH-1:0] paddr_o;
wire [DATA_WIDTH-1:0] pwdata_o;

apb_master dut(  
					pclk_i, prst_i, paddr_o, penable_o, psel1_o, pwrite_o, pwdata_o, pready_i, prdata_i,
					// AHB|ASB interface to APB master bridge
				 	apb_transfer_i, apb_wr_rd_i, apb_write_addr_i, apb_read_addr_i, apb_write_data_i, apb_read_data_o
			);

initial begin
	pclk_i=0;
	forever #5 pclk_i=~pclk_i;
end

initial begin
	prst_i=0; // enabling ACTIVE LOW reset
	apb_transfer_i=0; apb_wr_rd_i=0; apb_write_addr_i=0; apb_read_addr_i=0; apb_write_data_i=0;
	repeat(2)	
		@(posedge pclk_i);
	prst_i=1;
	apb_write_to_slave(10,20);
	apb_write_to_slave(20,40);
	apb_write_to_slave(30,60);
	apb_read_from_slave(10);
	apb_read_from_slave(20);
	apb_read_from_slave(30);
	#100;
	$finish;
end


task apb_write_to_slave( input [ADDR_WIDTH-1:0] slave_addr_i, input [DATA_WIDTH-1:0] slave_data_i);
begin
	apb_transfer_i=1;
	apb_wr_rd_i=1;
	apb_write_addr_i=slave_addr_i;
	apb_write_data_i=slave_data_i;
	wait(pready_i==1);
	wait(psel1_o==0); //indicates tx successfully finished its execution
	apb_transfer_i=0;
	apb_wr_rd_i=0;
	@(posedge pclk_i);
end
endtask

task apb_read_from_slave( input [ADDR_WIDTH-1:0] slave_addr_i);
begin
	apb_transfer_i=1;
	apb_wr_rd_i=0;
	apb_read_addr_i=slave_addr_i;
	wait(pready_i==1);
	wait(psel1_o==0); //indicates tx successfully finished its execution
	apb_transfer_i=0;
end
endtask

endmodule
