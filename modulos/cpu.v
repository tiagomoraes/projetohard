module cpu (clk, reset);
	
	//inputs
	
	input wire clk;
	input wire reset;
	
	//outputs (precisa? , já da pra ver os regs no waveform)
	
	//parametros - ver se dá pra passar um como argumento para algum módulo ou se te que criar alguma variavel pro valor(provavel q tenha q mudar)
	
	parameter stack_pointer = 5'd29; // $29
	parameter stack_top = 32'd227;
	parameter return_adress = 5'd31; // $31
	parameter opcode_exp = 32'd253; // nopcode
	parameter over_exp = 32'd254; // overflow
	parameter div_exp = 32'd255; // div0
	parameter alu_4 = 32'd4;
	parameter alu_1 = 32'd1;
	
	//fios - ver depois os fios que vao precisar pra outras instrucoes alem do add (conferir se tudo do add ta ai)
	//nao precisa da excecao pra quinta
	
	wire [31:0]pc_in;
	wire [31:0]pc_out;
	wire [31:0]mem_adress_in;
	wire [31:0]mem_data_in;
	wire [31:0]mem_out;
	wire [31:0]reg_alu_out; //fio que sai de aluout
	//wire [31:0]incdecadr; endereço inc/dec - entrada do mux do q vai ler na memoria - ainda n precisa
	//wire [31:0]mdrout; ainda n precisa
	//wire [31:0]ir_out; (nao e assim: ver saidas do modulo Instr_Reg)
	wire [31:0]read_data_a;
	wire [31:0]read_data_b;
	wire [31:0]reg_out_a;
	wire [31:0]reg_out_b;
	wire [31:0]write_register; 
	wire [31:0]write_data;
	wire [31:0]alu_result;
	
	//fios do controle - todos estão descritos porem pro add nao vai precisar de tudo
	
	wire pcwrite;
	wire pcwritecond;
	wire inccontrol;
	wire memrw;
	wire irwrite;
	wire mdrwrite;
	wire mloadab;
	wire dloadab;
	wire mult;
	wire div;
	wire divzero;
	wire muxhigh;
	wire muxlow;
	wire highwrite;
	wire lowwrite;
	wire regwrite;
	wire awrite;
	wire bwrite;
	wire aluoutwrite;
	wire epcwrite;
	wire shamtcontrol;
	wire shiftval;
	wire overflowmult;
	wire overflowalu;
	wire [1:0]alulogic;
	wire [1:0]alusrca;
	wire [2:0]alusrcb;
	wire [1:0]regdest;
	wire [1:0]dlrcontrol;
	wire [1:0]dsrcontrol;
	wire [2:0]iord;
	wire [2:0]memtoreg;
	wire [2:0]aluop;
	wire [2:0]shitfcontrol;
	wire [2:0]pcsrc;
	
	//modulos da cpu
	//instanciar os modulos com a seguinte sintaxe:
	
	// modulo nomedomodulo (.Arg1(var1), ... , .Argn(varn)) 
	Registrador rega (.Clk(clk), .Reset(reset), .Load(awrite), .Entrada(read_data_a), .Saida(reg_out_a));
	
endmodule 