module div(clk, div, div_end, div_zero, a, b, high, low, reset);
    input wire clk;
    input wire div;
    input wire reset;
    input wire [31:0] a;
    input wire [31:0] b;
    output reg [31:0] high;
    output reg [31:0] low;
    output reg div_end;
    output reg div_zero;

    integer cont;
    reg flag;
    reg [31:0] auxa;
    reg [31:0] auxb;
    reg [31:0] remainder;
    reg [63:0] divisor;
    reg [63:0] dividend;
    reg [63:0] diff;
    reg [31:0] quotient;

    always @(posedge clk) begin
        if(reset == 1'b1) begin
            high = 32'b0;
            low = 32'b0;
            div_end = 1'b0;
            div_zero = 0;
        end

        if (div == 1) begin
            if ((a[31] && b[31]) || (~a[31] && ~b[31]))
                flag = 1'b0;
            else
                flag = 1'b1;

            if (a[31]) 
                auxa = (~a + 1'b1);
            else 
                auxa = a;
            if (b[31])
                auxb = (~b + 1'b1);
            else
                auxb = b;

            quotient = 32'b0;
            dividend = {32'b0, auxa};
            divisor = {1'b0, auxb, 31'b0};
            cont = 32;
        end
        else begin
            diff = dividend - divisor;

            quotient = quotient << 1;

            if (!diff[63]) begin
                dividend = diff;
                quotient[0] = 1'b1;
            end

            divisor = divisor >> 1;
            cont = cont - 1;

            if (cont == 0) begin
                if (flag)
                    quotient = (~quotient + 1'b1);
                
                low = quotient;
                high = dividend[31:0];
                div_end = 1'b1;

                remainder = 31'b0;
                divisor = 64'b0;
                dividend = 64'b0;
                quotient = 32'b0;
                diff = 64'b0;
                flag = 1'b0;
                cont = -1;
            end
        end

    end

endmodule