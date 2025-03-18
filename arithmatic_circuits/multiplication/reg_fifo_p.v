// Simple FIFO
// functionality: synchronous to clock, loads and unload data to and from fifo
// 				  into fifo register. clears the data of fifo using "clr"
// 				  signal

module reg_fifo_p(clk_i, clr_i, load_i, data_i, unload_i, data_o);

parameter DATA_SIZE=8;

input clk_i, clr_i, load_i, unload_i;
input [DATA_SIZE-1:0] data_i;
output reg [DATA_SIZE-1:0] data_o;

reg [DATA_SIZE-1:0] fifo_p; // register p

always @(posedge clk_i) begin
	if(clr_i)
		fifo_p <= 0; // clear the fifo content
	if(load_i) // ready to load data into register P
		fifo_p <= data_i;
	if(unload_i) // ready to unload data from register P
		data_o <= fifo_p;
end

endmodule
