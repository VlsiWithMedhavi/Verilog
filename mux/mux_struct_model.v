module mux(i0, i1, s, out);

input i0, i1, s;
output out;

wire t1, t2, t3, t4, y1, y2, y3, y4;

// structural modeling
nand g1(t1, s, s); // ~s
nand g2(t2, t1, i0); // ~(~si0)
nand g3(y1, t2, t2); // ~si0
nand g4(t3, s, i1); // ~(si1)
nand g5(y2, t3, t3); // si1
nand g6(y3, y2, y2); // 
nand g7(y4, y1, y1);
nand g8(out, y4, y3);

// 4x1 mux using data flow modeling
//assign y = s1 ? ( (s0 ? i3 : i2) ) : ( (s0 ? i1 : i0));
endmodule


//------------------------TEST CASE===================

module tb();

reg i0, i1, s;
wire out;

mux dut(i0, i1, s, out);

initial begin
	$monitor("i0=%0d, i1=%0d, s=%0d, out=%0d", i0, i1, s, out);
	i0=0; i1=0; s=0; #5;
	i0=0; i1=0; s=1; #5;
	i0=0; i1=1; s=0; #5;
	i0=0; i1=1; s=1; #5;
	i0=1; i1=0; s=0; #5;
	i0=1; i1=0; s=1; #5;
	i0=1; i1=1; s=0; #5;
	i0=1; i1=1; s=1; #5;
end
endmodule
