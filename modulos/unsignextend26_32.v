module unsignextend26_32 (instruction_26, instruction_32);
    input wire [25:0]instruction_26;
    output wire [31:0]instruction_32;

    assign instruction_32 = {6'b000000, instruction_26};
endmodule