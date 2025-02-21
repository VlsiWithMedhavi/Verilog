module reg_as_wire_storage(a, b, f1, f2);
	input a, b;
	output reg f1, f2;

	always @(a or b) begin
		f1=f2&b; // need to store value of f2, hence storage required
		f2=a|b;  // continously driver hence acts as a wire
	end
endmodule


//-----------TEST BENCH-----------------


module tb();

reg a, b;
wire f1, f2;

reg_as_wire_storage dut(a, b, f1, f2);

initial begin
	a=1'b0; b=1'b0; #5;
	a=1'b0; b=1'b1; #5;
	a=1'b1; b=1'b0; #5;
	a=1'b1; b=1'b1; 
	#100;
	$finish;
end

initial begin
	$monitor("time=%0t, a=%0b, b=%0b, f1=%0b, f2=%0b", $time, a, b, f1, f2);
end


endmodule
