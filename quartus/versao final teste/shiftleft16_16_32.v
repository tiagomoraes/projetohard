module shiftleft16_16_32 (imediate, imediate_shifted);
    input wire [15:0]imediate;
    output wire [31:0]imediate_shifted;

    assign imediate_shifted = {imediate, 16'b0000000000000000};
endmodule