module mult(clk, mult, mult_end, a, b, high, low, reset);
    input wire clk;
    input wire mult;
    input wire reset;
    input wire [31:0] a;
    input wire [31:0] b;
    output reg [31:0] high;
    output reg [31:0] low;
    output reg mult_end;

    integer cont;
    reg [64:0] add, sub, prod;
    reg [31:0] comp;

    always @(posedge clk) begin
        if(reset == 1'b1) begin
            high = 32'b0;
            low = 32'b0;
            mult_end = 1'b0;
        end

        if(mult == 1'b1) begin
            add = {a, 33'b0};
            comp = (~a + 1'b1);
            sub = {comp, 33'b0};
            prod = {32'b0, b, 1'b0};
            cont = 32;
            mult_end = 1'b0;
        end

        case (prod[1:0])
            2'b01: prod = prod + add;
            2'b10: prod = prod + sub;
        endcase

        prod = prod >> 1;
        if(prod[63] == 1'b1) begin
            prod[64] = 1'b1;
        end
        
        if(cont > 0) begin
            cont = (cont - 1);
        end

        if(cont == 0) begin
            high = prod[64:33];
            low = prod[32:1];
            mult_end = 1'b1;

            // reseting
            add = 65'b0;
            sub = 65'b0;
            prod = 65'b0;
        end
    end

endmodule

