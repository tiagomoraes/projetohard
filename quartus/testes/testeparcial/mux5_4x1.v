module mux5_4x1 (a, b, c, d, sel, out);
	input wire [4:0]a;
	input wire [4:0]b;
	input wire [4:0]c;
	input wire [4:0]d;
	input wire [1:0]sel;
	output wire [4:0]out;

	assign out = (sel[1]) ? ((sel[0]) ? d : c) : ((sel[0]) ? b : a);
endmodule