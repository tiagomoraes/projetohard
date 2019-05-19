module dsr (b, data, dsrcontrol, out);
    input wire [31:0] b;
    input wire [31:0] data;
    input wire [1:0] dsrcontrol;
    output reg [31:0] out;

	always begin 
		case (dsrcontrol)
			2'b00: out = {data[31:8], b[7:0]};
			2'b01: out = {data[31:16], b[15:0]};
			2'b10: out = b;
		endcase
	end
    //assign out = (dsrcontrol[1]) ? b : ((dsrcontrol[0]) ? {data[31:16], b[15:0]} : {data[31:8], b[7:0]}); //ver se ta certo
endmodule