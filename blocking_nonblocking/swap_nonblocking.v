module tb();

integer num1, num2;
integer t;

initial begin
	num1=10; num2=20; t=0; #5;
	$display("before swap: num1=%0d, num2=%0d", num1, num2);
	num1 <= num2;
	num2 <= num1; #1;
	$display("after swap: num1=%0d, num2=%0d", num1, num2);
	#100; 
	$finish;
end

initial begin
	$monitor("time=%0t, num1=%0d, num2=%0d", $time, num1, num2);
end

endmodule
