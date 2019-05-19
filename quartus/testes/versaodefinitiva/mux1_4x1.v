module mux1_4x1 (a, b, c, d, sel, out);
	input wire a;
	input wire b;
	input wire c;
	input wire d;
	input wire [1:0]sel;
	output wire out;

	assign out = (sel[1]) ? ((sel[0]) ? d : c) : ((sel[0]) ? b : a);
endmodule