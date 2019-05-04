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
	output reg [31:0]out;
	
	always@(sel or a or b or c or d or e or f or g or h) begin
		case(sel)
			3`b000: out <= a;
			3`b001: out <= b;
			3`b010: out <= c;
			3`b011: out <= d;
			3`b100: out <= e;
			3`b101: out <= f;
			3`b110: out <= g;
			3`b111: out <= h;
		endcase
	end							
endmodule
