module shiftleft2_32_32 (imediate, imediate_shifted);
    input wire [31:0]imediate;
    output wire [31:0]imediate_shifted;

    assign imediate_shifted = imediate <<< 2; // colocando shift aritmetico pra n dar meme
endmodule