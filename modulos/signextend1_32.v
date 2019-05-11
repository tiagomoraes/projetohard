module signextend1_32 (lt, lt_32);
    input wire lt;
    output wire [31:0]lt_32;

    assign lt_32 = 32'd0 + lt;
endmodule