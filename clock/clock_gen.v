//**********************************************************************************************
//**********************************************************************************************
//									 CLOCK GENERATION
//
//	Functionality: Code generates a clock of user specified frequency, duty
//				   cycle and jitter.
//
//				   simulator unit delay = 1ns -> default tp
//				   simulator default freqeuncy = 1/tp -> 1/1ns -> 1 GHz
//				   user input default freq MHz --> convert to default GHz freqeuncy
//				   user inou freq / 10**3 --> converts freq to GHz
//
//	Signals:
//
//	Author: Medhavi Kosta (M.Tech in VLSI and Embedded design Engineering)
//
//**********************************************************************************************
//**********************************************************************************************

`timescale 1ns/1ps

module tb();

real freq; // user specified frequency in MHz
real jitter; // user specified jitter 0-100% range
integer duty_cycle; // user psecified duty cycle 0-100% range
real tp_jit, jitter_factor;
real tp; // calculated TP according to above 3 clock parameters

realtime next_clk_edge, cur_clk_edge;

reg clk;

initial begin
	$value$plusargs("freq=%0f", freq);
	$value$plusargs("duty=%0d", duty_cycle);
	$value$plusargs("jit=%0f", jitter);

	freq=freq/(10**3); // convert input Mhz freqeuncy to default Ghz

	tp=1/freq; 
	jitter_factor=tp*jitter/100.0; // calculating jitter factor
	tp_jit=tp;
	tp=$urandom_range((tp_jit-jitter_factor)*100, (tp_jit+jitter_factor)*100)/100.0; //want to have 2 decimal value precison hence mul/div my 100
	$display("freq=%0fGhz, tp=%0fns, duty_cycle=%0d, jitter_factor=%0f", freq, tp, duty_cycle, jitter_factor);
	
	#500; $finish;
end

initial begin
	clk=0;
	forever begin
		cur_clk_edge=$realtime;
		clk = 1'b1; #(tp*(duty_cycle/100.0)); // ON time period of wave
		clk = 1'b0; #(tp*(1-(duty_cycle/100.0))); // OFF time period of wave
		next_clk_edge=$realtime;
		$display("calculated tp=%0f ns", next_clk_edge-cur_clk_edge);
	end
end

endmodule
