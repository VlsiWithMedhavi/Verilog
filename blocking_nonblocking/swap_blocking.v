module tb();

integer num1, num2;
integer t;

initial begin
	num1=10; num2=20; t=0;
	$display("before swap: num1=%0d, num2=%0d", num1, num2);
	t=num1;
	num1=num2;
	num2=t;
	$display("after swap: num1=%0d, num2=%0d", num1, num2);
end

endmodule
