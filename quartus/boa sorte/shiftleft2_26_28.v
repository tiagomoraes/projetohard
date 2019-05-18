module shiftleft2_26_28 (instruction_26, instruction_28);
    input wire [25:0]instruction_26;
    output wire [27:0]instruction_28;

    assign instruction_28 = {instruction_26, 2'b00};
endmodule