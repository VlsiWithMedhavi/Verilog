`timescale 1ns/1ns

module alu_function(num1, num2, oper, result);

parameter BIT=4;

parameter ADD=3'b001;
parameter SUB=3'b010;
parameter MUL=3'b011;
parameter DIV=3'b100;
parameter SHIFT_RIGHT=3'b101;
parameter SHIFT_LEFT=3'b110;
parameter POW=3'b111;

input [BIT-1:0] num1, num2;
input [2:0] oper;
output reg [BIT-1:0] result;


always @(*) begin
	case(oper)
		ADD : begin 
				$display("ADD RESULT");
				result=num1+num2;
			end
		SUB : begin 
				$display("SUB RESULT");
				result=num1-num2;
			end
		MUL : begin 
				$display("MUL RESULT");
				result=num1*num2;
			end
		DIV : begin 
				$display("DIV RESULT");
				result=num1/num2;
			end
		SHIFT_RIGHT : begin 
				$display("SHIFT_RIGHT RESULT");
				result=num1>>num2;
			end
		SHIFT_LEFT : begin 
				$display("SHIFT_LEFT RESULT");
				result=num1<<num2;
			end
		POW : begin 
				$display("POW RESULT");
				result=num1**num2;
			end
		default : begin 
				result=4'bX;
			end
	endcase
end

endmodule


//---------------------TEST BENCH--------------------

module tb();

parameter BIT=4;

reg [BIT-1:0] num1, num2;
reg [2:0] oper;
wire [BIT-1:0] result;

alu_function dut(num1, num2, oper, result);

initial begin
	$monitor("time=%0t, num1=%0d, num2=%0d, oper=%0d, result=%0d", $time, num1, num2, oper, result);

	num1=$random; num2=$random; oper=3'b000; #5;
	num1=$random; num2=$random; oper=3'b001; #5;
	num1=$random; num2=$random; oper=3'b010; #5;
	num1=$random; num2=$random; oper=3'b011; #5;
	num1=$random; num2=$random; oper=3'b100; #5;
	num1=$random; num2=$random; oper=3'b101; #5;
	num1=$random; num2=$random; oper=3'b110; #5;
	num1=2; num2=3; oper=3'b111; #5;
end

endmodule
