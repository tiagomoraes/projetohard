module div(clk, div, div_end, div_zero, a, b, high, low, reset);
    input wire clk;
    input wire div;
    input wire reset;
    input wire [31:0] a;
    input wire [31:0] b;
    output reg [31:0] high;
    output reg [31:0] low;
    output reg div_end;
    output reg div_zero;//deu errado -> troca por fio

    integer cont;
    reg [64:0] remainder;
    reg [31:0] quotient, divisor;

    always @(posedge clk) begin
        if(reset == 1'b1) begin
            high = 32'b0;
            low = 32'b0;
            div_end = 1'b0;
            div_zero = 0;//atÃ© segunda ordem Ã© assim
        end

        if(div == 1'b1) begin
            remainder = {a,33'b0};
            divisor = {b};
            cont = 32;
            div_end = 1'b0;
        end

    if(divisor == 0) begin
        div_zero = 1;
    end

    remainder = (remainder - divisor);

    if(remainder >= 0) begin
        quotient = quotient << 1;
        quotient[0] = 1'b1;
    end

           if(remainder < 0) begin
        remainder = (divisor + remainder);
        quotient = quotient << 1; //Existe uma possibilidade um tanto quanto grande de termos que setar o bit 0 para 0, boa noite!
    end

    divisor = divisor >> 1;

        if(cont > 0) begin
            cont = (cont - 1);
        end

        if(cont == 0) begin
            high = remainder[64:33];
            low = remainder[32:1];
            div_end = 1'b1;

            // reseting
            remainder = 65'b0;
            quotient = 32'b0;
            divisor = 32'b0;
            cont = -1;
        end
    end

endmodule