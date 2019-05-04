module mux32_2x1 (a, b, sel, out);
	input wire [31:0]a;
	input wire [31:0]b;
	input wire sel;
	output reg [31:0]out;
	
	always@(sel or a or b) begin
		case(sel)
			1`b0: out <= a;
			1`b1: out <= b;
		endcase
	end
endmodule 