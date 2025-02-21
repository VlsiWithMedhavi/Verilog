module integer_to_real_conversion();

integer num_int;
real num_real;

initial begin
	num_int=3; num_real=3.14;
	$display(" INTEGER TO REAL BEFORE CONVERSION : num_int=%0f, num_real=%0f", num_int, num_real);
	num_real=num_int;
	$display(" INTEGER TO REAL AFTER CONVERSION : num_int=%0f, num_real=%0f", num_int, num_real);
end

endmodule
