module mux32_8x1 (a, b, c, d, e, f, g, h, sel, out);
	input wire [31:0]a;
	input wire [31:0]b;
	input wire [31:0]c;
	input wire [31:0]d;
	input wire [31:0]e;
	input wire [31:0]f;
	input wire [31:0]g;
	input wire [31:0]h;
	input wire [2:0]sel;
	output wire [31:0]out;

	assign out = (sel[2]) ? ((sel[1]) ? ((sel[0]) ? h : g) : ((sel[0]) ? f : e)) :
							((sel[1]) ? ((sel[0]) ? d : c) : ((sel[0]) ? b : a));

endmodule