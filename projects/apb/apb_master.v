//====================================================================================================
//====================================================================================================
//                            ADVANCED PERIPHERAL BUS PROTOCOL (APB)
//                            	 AMBA APB protocol ARM : MASTER
//====================================================================================================
//====================================================================================================

// Signals:
// 	pclk_i : processor clock for synchronization of data transfers
// 	prst_i : ACTIVE LOW reset signal
// 	paddr_o : APB 32-bit bus address
// 	pprot_o : data protection type modes: "normal" "privileged" "secure" i.e data/instruction access (OPTIONAL SIGNAL)
//	pselx_o : peripheral slave device selection // each slave as its own pselx_o i.e psel1_o, psel2_0 depending on number of slaves attached to peripheral bus
//	penable_o : enable APB tranfers
//	pwrite_o : APB write(HIGH} read(LOW)
//	pwdata_o : can be 8|16|32 bit wide data write
//	pstrb_o : write strobes (4-bit) as data is 32-bit. pstrb_i[0] means update [7:0] pwdata_i --> pstrb_i[3] means update [31:24] pwdata_i. NOTE: signal should not be active during pread tx (OPTIONAL SIGNAL)
//	pready_i : slave indicates its ready for tx
//	prdata_i : 8|16|32 bit data read
//	pslverr_i: slave data transfer error 

`include "apb_slave1.v"

module apb_master(  
					pclk_i, prst_i, paddr_o, penable_o, psel1_o, pwrite_o, pwdata_o, pready_i, prdata_i,
					// AHB|ASB interface to APB master bridge
				 	apb_transfer_i, apb_wr_rd_i, apb_write_addr_i, apb_read_addr_i, apb_write_data_i, apb_read_data_o
				);

parameter ADDR_WIDTH=32;
parameter DATA_WIDTH=32;
parameter NUM_STATES=3;

parameter STATE_IDLE=3'b001; // default state of APB transfer
parameter STATE_SETUP=3'b010; // assert pselx_o to initiate transfer
parameter STATE_ACCESS=3'b100; // assert penable_o to start tx

input apb_transfer_i, apb_wr_rd_i;
input [ADDR_WIDTH-1:0] apb_write_addr_i, apb_read_addr_i;
input [DATA_WIDTH-1:0] apb_write_data_i;
output reg [DATA_WIDTH-1:0] apb_read_data_o;

input pclk_i, prst_i, pready_i;
input [DATA_WIDTH-1:0] prdata_i;
output reg pwrite_o, penable_o, psel1_o; 
output reg [ADDR_WIDTH-1:0] paddr_o;
output reg [DATA_WIDTH-1:0] pwdata_o;

reg [NUM_STATES-1:0] state, next_state; // one hot encoding method for STATES to avoid glitches

apb_slave1 dut1(pclk_i, prst_i, paddr_o, penable_o, psel1_o, pwrite_o, pwdata_o, pready_i, prdata_i);

always @(posedge pclk_i) begin
	if(!prst_i) begin // ACTIVE LOW reset
		pwrite_o=0; penable_o=0; psel1_o=0;
		paddr_o=0; pwdata_o=0; apb_read_data_o=0;
		state=STATE_IDLE; next_state=STATE_IDLE;
	end

	else begin
		case(state)
		STATE_IDLE: begin
			if(!apb_transfer_i) begin // processor informs APB bridge to initiate APB tx to slave
				psel1_o=0; // donot intiate SETUP
				penable_o=0; // donot intiate any transfer
				next_state=STATE_IDLE; // no apb tx req intiated by MCU
			end
			else
				next_state=STATE_SETUP; // processor informs APB bridge to initiate APB tx to slave
		end
		STATE_SETUP: begin // initiate transfer req from MCU
			psel1_o=1;
			penable_o=0;
			// driving pwrite_o, paddr_o, pwdata_o in SETUP stage 
			if(apb_wr_rd_i) begin // check for wr|rd tx request from microcontroller "1" write else read
				pwrite_o=1; // write pwdata_o to slave device at paddr_o location
				paddr_o=apb_write_addr_i; 
				pwdata_o=apb_write_data_i;
			end
			else begin
				pwrite_o=0; // read slave data from  slave paddr_o location to prdata_o
				paddr_o=apb_read_addr_i; 
			end
			next_state=STATE_ACCESS;
		end
		
		STATE_ACCESS: begin
			penable_o=1; // intiate ACCESS APB stage tx
			if(pready_i) begin // slave indicates its ready for valid txs, used to include wait states in transfer after success write transfer
				if(!apb_wr_rd_i) // requested rd tx
					apb_read_data_o=prdata_i; // data read from slave is given back to MCU over AHB|ASB 
				// deassert penable_o, psel1_o after successfull tx
				psel1_o=0; penable_o=0;
				next_state=STATE_IDLE; //further rd|wr tx
			end
			else
				next_state=STATE_SETUP; //slave was not ready, re-initiate the transfer
		end
		endcase
	end

end

always @(next_state)
	state = next_state;

endmodule
