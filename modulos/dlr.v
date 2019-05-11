module dlr (data, dlrcontrol, out);
    input wire [31:0] data;
    input wire [1:0] dlrcontrol;
    output wire [31:0] out;

    assign out = (dlrcontrol[1]) ? data : ((dlrcontrol[0]) ? {16'b0000000000000000, data[15:0]} : {24'b000000000000000000000000, data[7:0]}); //ver se ta certo
endmodule