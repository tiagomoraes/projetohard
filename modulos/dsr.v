module dsr (b, data, dsrcontrol, out);
    input wire [31:0] b;
    input wire [31:0] data;
    input wire [1:0] dsrcontrol;
    output wire [31:0] out;

    assign out = (dsrcontrol[1]) ? b : ((dsrcontrol[0]) ? {data[31:16], b[15:0]} : {data[31:8], b[7:0]}); //ver se ta certo
endmodule