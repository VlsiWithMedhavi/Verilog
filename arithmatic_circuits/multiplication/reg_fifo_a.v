// Simple FIFO
// functionality: synchronous to clock, loads and unload data to and from fifo
// 				  into fifo register

module reg_fifo_a(clk_i, load_i, data_i, unload_i, data_o);

parameter DATA_SIZE=8;

input clk_i, load_i, unload_i;
input [DATA_SIZE-1:0] data_i;
output reg [DATA_SIZE-1:0] data_o;
reg [DATA_SIZE-1:0] fifo_a; // register A

always @(posedge clk_i) begin
	if(load_i) // ready to load data into register A
		fifo_a <= data_i;
	if(unload_i) // ready to unload data from register A
		data_o <= fifo_a;
end

endmodule
