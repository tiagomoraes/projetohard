module dlr (data, dlrcontrol, out);
    input wire [31:0] data;
    input wire [1:0] dlrcontrol;
    output reg [31:0] out;
	
	always begin 
		case (dlrcontrol)
			2'b00: out = {24'b0, data[7:0]};
			2'b01: out = {16'b0, data[15:0]};
			2'b10: out = data;
		endcase
	end
    //assign out = (dlrcontrol[1]) ? data : ((dlrcontrol[0]) ? {16'b0000000000000000, data[15:0]} : {24'b000000000000000000000000, data[7:0]}); //ver se ta certo
endmodule