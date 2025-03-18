module down_counter(clk_i, load_c, load_count, dec_c, count);

parameter DATA_SIZE=8;

input clk_i, load_c, dec_c;
input [DATA_SIZE-1:0] load_count;
output reg [DATA_SIZE-1:0] count;

initial begin
	count <= 0;
end

always @(posedge clk_i) begin
	if(load_c)
		count <= load_count; // load counter value initially
    if(dec_c) // if decrement counter signal HIGH, dec count value
		count <= count-1;
end

endmodule
