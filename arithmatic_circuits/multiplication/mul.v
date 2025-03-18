//************************************************************************************************ 
//************************************************************************************************ 
// 					 MULTIPLICATION using REPEATATIVE ADDITION
//
//	Functionality: 
// 			   	 The below circuit is designed to give the multiplicative
// 				 output of 2 numbers.
//	Logic: 
//		 Say we want to multiple 5*3 -> equivalent to adding 5 three times
//	
//	Requirement:
//		1 fifo register a : fifo_a (stores number that will be repitatively added)
//		1 fifo register p : fifo_p (product register will store the repitative sum)
//		1 adder circuit : to add two numbers
//		1 down counter : count down the multiplier number
//		1 comparator : untill count remains non zero -> keep on adding number to product register 
//
//	Note: The above functinlity is carried out using state machine
//
//	Signals:
//  - clk_i: clock for synchronization
//  - load_a_o: signals fifo a to enable loading a number into it
//  - unload_a_o: signals fifo a to enable unloading a number from it to an output signal
//  - bus_i: data bus line
//  - clr_p_o: enables clearing the product register fifo 
//  - load_p_o: signals fifo p to enable data loading into it
//  - unload_p_o: signals fifo to enable data unloading from it to an output signal
//  - load_b_o: enable loading the multiplier value to down counter
//  - dec_count: signals the count to perform a decrement by 1 to the count value 
//  - result_o: final multiplication result
//************************************************************************************************ 
//************************************************************************************************ 


`include "reg_fifo_a.v"
`include "reg_fifo_p.v"
`include "down_counter.v"
`include "add.v"

module mul_ctrl(clk_i, load_a_o, unload_a_o, bus_i, clr_p_o, load_p_o, unload_p_o, load_b_o, dec_count, result_o);

parameter DATA_SIZE=8;

parameter STATE_IDLE=3'b000;
parameter STATE_LOAD_UNLOAD_REG_A=3'b001;
parameter STATE_CLEAR_REG_P=3'b010;
parameter STATE_LOAD_COUNTER=3'b011;
parameter STATE_ADD_RESULT=3'b100;
parameter STATE_COMPARE_RESULT=3'b101;
parameter STATE_LOAD_REG_P=3'b110;
parameter STATE_RESULT=3'b111;

input clk_i;
input [DATA_SIZE-1:0] bus_i;
output reg load_a_o, unload_a_o;
output reg load_b_o, dec_count;
output reg clr_p_o, load_p_o, unload_p_o; 
output reg [DATA_SIZE-1:0] result_o; 

reg [2:0] state, next_state;

wire [DATA_SIZE-1:0] data_a_o, data_p_o, count_o;
wire [DATA_SIZE-1:0] sum_o; 

reg_fifo_a r1(clk_i, load_a_o, bus_i, unload_a_o, data_a_o);
reg_fifo_p r2(clk_i, clr_p_o, load_p_o, sum_o, unload_p_o, data_p_o);
down_counter c1(clk_i, load_b_o, bus_i, dec_count, count_o);
add a1(data_a_o, data_p_o, sum_o);

initial begin
	load_a_o=0; unload_a_o=0;
	clr_p_o=0; load_p_o=0; unload_p_o=0;
	load_b_o=0; dec_count=0;
	state=0; next_state=0;
end

always @(posedge clk_i) begin
	case(state)
	
	STATE_IDLE : next_state=STATE_LOAD_UNLOAD_REG_A; // ideal state, simply jump to next state

	STATE_LOAD_UNLOAD_REG_A : begin // load fifo reg A with number from bus line
		load_a_o=1; // enabling data load into fifo a
		next_state=STATE_CLEAR_REG_P;
	end
	STATE_CLEAR_REG_P : begin // clearing the Product register
		load_a_o=0; // disabling loading of new data into fifo a  
		clr_p_o=1;  // clearing fifo_p reg
	    next_state=STATE_LOAD_COUNTER;
	end
	STATE_LOAD_COUNTER: begin // load data in value through BUS in down counter 
		clr_p_o=0; // disabling clearing of fifo_p
		load_b_o=1; // enable data load in counter
		next_state=STATE_ADD_RESULT;   
	end
	STATE_ADD_RESULT: begin // perform repitative addition
		load_b_o=0; // disabling further data load into down counter
		load_p_o=0; // disabling further data load into product register fifo_p
		unload_a_o=1; unload_p_o=1; // enabling unloading of data from fifo 
		dec_count=1; // dec the counter by one after addition
		next_state=STATE_COMPARE_RESULT;
	end
	STATE_COMPARE_RESULT: begin // check is count value is non zero to perform repitative addition
		unload_a_o=0; unload_p_o=0; // disable unlaoding of data from fifo
		dec_count=0; // disable dec counter else will get on decreasing at every pos edge
		if(count_o) // if count is not zero perform addition
			next_state=STATE_LOAD_REG_P;
		else begin 
			next_state=STATE_RESULT;
		end
	end
	STATE_LOAD_REG_P: begin // reload fifo_p with new addition result value
		load_p_o=1; // enable loading new result data into fifo_p
		next_state=STATE_ADD_RESULT;
	end
	STATE_RESULT: // final multiplication output
		result_o = data_p_o; // we are loading fifo_p data value to result_o as addition will again take place for one more count as their is a delay of 1 clock cycle due to clock synchronisation
	endcase
end

always @(next_state)
	state=next_state;

endmodule


//************************************************************************************************ 
//************************************************************************************************ 
//                                    TEST BENCH
//************************************************************************************************
//************************************************************************************************ 

module tb();

parameter DATA_SIZE=8;

reg clk_i;
reg [DATA_SIZE-1:0] bus_i;
wire load_a_o, unload_a_o;
wire load_b_o, dec_count;
wire clr_p_o, load_p_o, unload_p_o; 
wire [DATA_SIZE-1:0] result_o; 

mul_ctrl dut(clk_i, load_a_o, unload_a_o, bus_i, clr_p_o, load_p_o, unload_p_o, load_b_o, dec_count, result_o);

initial begin
	clk_i=1'b0;
	forever #5 clk_i=~clk_i;
end

initial begin
	bus_i=0;
end

initial begin // multipliction : 7*4=28
	bus_i=7; 
	wait(load_a_o==1'b1); // wait till data load enables
	wait(load_a_o==1'b0); // wait till data load disables

	bus_i=4; 
	
	#500; $finish;
end

endmodule

