module mux5_2x1 (a, b, sel, out);
	input wire [4:0]a;
	input wire [4:0]b;
	input wire sel;
	output wire [4:0]out;
	
	assign out = (sel) ? b : a;
endmodule 