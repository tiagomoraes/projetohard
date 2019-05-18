module signextend16_32 (in, out);
    input wire [15:0]in;
    output wire [31:0]out;

    assign out = (in[15]) ? {16'b1111111111111111, in[15:0]} : {16'b0000000000000000, in[15:0]};
endmodule