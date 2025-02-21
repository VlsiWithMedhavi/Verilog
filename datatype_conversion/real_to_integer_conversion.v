module real_to_integer_conversion();

integer num_int;
real num_real;

initial begin
	num_real=3.14;
	$display(" REAL TO INTEGER BEFORE CONVERSION : num_int=%0f, num_real=%0f", num_int, num_real);
	num_int=num_real;
	$display(" REAL TO INTEGER AFTER CONVERSION : num_int=%0f, num_real=%0f", num_int, num_real);
end

endmodule
