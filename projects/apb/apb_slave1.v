//====================================================================================================
//====================================================================================================
//                            ADVANCED PERIPHERAL BUS PROTOCOL (APB)
//                            	  AMBA APB protocol ARM : SLAVE
//====================================================================================================
//====================================================================================================

// Signals:
// 	pclk_i : processor clock for synchronization of data transfers
// 	prst_i : ACTIVE LOW reset signal
// 	paddr_i : APB slave 32-bit bus address
//	pselx_i : peripheral slave device selection // each slave as its own pselx_o i.e psel1_o, psel2_0 depending on number of slaves attached to peripheral bus
//	penable_i : APB tranfers enabled from master
//	pwrite_i : APB write(HIGH} read(LOW)
//	pwdata_i : can be 8|16|32 bit wide data write
//	pready_o : slave indicates its ready for tx
//	prdata_o : data output by slave during rd tx => 8|16|32 bit data read
//	pslverr_i: slave data transfer error  (OPTIONAL)

module apb_slave1(pclk_i, prst_i, paddr_i, penable_i, psel1_i, pwrite_i, pwdata_i, pready_o, prdata_o);

parameter ADDR_WIDTH=32;
parameter DATA_WIDTH=32;
parameter SLAVE1_MEM_DEPTH=100;

parameter STATE_IDLE=3'b01; // default slave state
parameter STATE_TX_ENABLED=3'b10; // recieved assert psel1_i, penable_i to start tx

input pclk_i, prst_i, penable_i, psel1_i, pwrite_i;
input [ADDR_WIDTH-1:0] paddr_i;
input [DATA_WIDTH-1:0] pwdata_i;
output reg pready_o;
output reg [DATA_WIDTH-1:0] prdata_o;

reg [DATA_WIDTH-1:0] mem_slave1 [SLAVE1_MEM_DEPTH-1:0];
reg [1:0] state, next_state;

integer i;

always @(posedge pclk_i) begin
	if(!prst_i) begin
		pready_o=0; prdata_o=0;
		state=STATE_IDLE; next_state=STATE_IDLE;
		for(i=0; i<SLAVE1_MEM_DEPTH; i=i+1)
			mem_slave1[i]=0;
	end
	else begin
		case(state)
			STATE_IDLE: begin
				if(psel1_i) begin
					pready_o=0; // psel1 is asserted but penable_i is yet to be asserted in next state
					next_state=STATE_TX_ENABLED;
				end
				else begin
					pready_o=0; prdata_o=0;
					next_state=STATE_IDLE; // wait for APB tx to initiated 
				end
			end
			STATE_TX_ENABLED: begin
				if(penable_i) begin // access tx initited by master
					pready_o=1;
					if(pwrite_i) begin // write tx
						mem_slave1[paddr_i]=pwdata_i;
						$display("time=%0t, WRITE TX : prdata_o=%0d, mem_slave1[%0d]=%0d", $time, prdata_o, paddr_i, mem_slave1[paddr_i]);
					end
					else begin // rd tx
						prdata_o=mem_slave1[paddr_i];
						$display("time=%0t, READ TX : prdata_o=%0d, mem_slave1[%0d]=%0d", $time, prdata_o, paddr_i, mem_slave1[paddr_i]);
					end
					next_state=STATE_IDLE; // cur tx complete
				end
				else
					next_state=STATE_TX_ENABLED; // if there are any tx scheduled
			end
		endcase
	end
end

always @(next_state)
	state = next_state;

endmodule
