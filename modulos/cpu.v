module cpu (clk, reset);

	//inputs

	input wire clk;
	input wire reset;

	//outputs (precisa? , j� da pra ver os regs no waveform)

	//parametros - ver se d� pra passar um como argumento para algum m�dulo ou se te que criar alguma variavel pro valor(provavel q tenha q mudar)

	parameter stack_pointer = 5'd29; // $29
	parameter stack_top = 32'd227;
	parameter return_adress = 5'd31; // $31
	parameter opcode_exp = 32'd253; // nopcode
	parameter over_exp = 32'd254; // overflow
	parameter div_exp = 32'd255; // div0
	parameter alu_4 = 32'd4;
	parameter alu_1 = 32'd1;
	parameter undefined = 32'd0; // parametro pra preecheer mux (pra os fios q ainda não estão feitos)

	//fios - ver depois os fios que vao precisar pra outras instrucoes alem do add (conferir se tudo do add ta ai)
	//nao precisa da excecao pra quinta

	wire [31:0]pc_in;
	wire [31:0]pc_out;
	wire [31:0]mem_adress_in;
	wire [31:0]mem_data_in;
	wire [31:0]mem_out;
	wire [31:0]reg_alu_out; //fio que sai de aluout
	//wire [31:0]incdecadr; endere�o inc/dec - entrada do mux do q vai ler na memoria - ainda n precisa
	//wire [31:0]mdrout; ainda n precisa
	//wire [31:0]ir_out; (nao e assim: ver saidas do modulo Instr_Reg)
	wire [5:0]opcode;
	wire [4:0]rs;
	wire [4:0]rt;
	wire [15:0]imediate;
	wire [4:0]rd = imediate[15:11]; // se der merda checar se essas atriuicoes tao de boa
	wire [5:0]funct = imediate[5:0];
	wire [31:0]read_data_a;
	wire [31:0]read_data_b;
	wire [31:0]reg_out_a;
	wire [31:0]reg_out_b;
	wire [4:0]write_register;
	wire [31:0]write_data;
	wire [31:0]alu_in_a;
	wire [31:0]alu_in_b;
	wire [31:0]alu_result;
	wire [31:0]epc_out;

	//fios do controle - todos est�o descritos porem pro add nao vai precisar de tudo

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
	wire [2:0]shiftcontrol;
	wire [2:0]pcsrc;

	//modulos da cpu
	//instanciar os modulos com a seguinte sintaxe:

	// modulo nomedomodulo (.Arg1(var1), ... , .Argn(varn))
	
	//Controle

	control ctrl (
		.clk(clk),
		.reset(reset),
		.opCode(opcode),
		.funct(funct),
		.overFlow(overflowalu), // por enquanto mandando o overflow da alu direto - mudar dps
		.divZero(divzero),// divzero ainda tem nada
		.iord(iord),
		.memrw(memrw),
		.irwrite(irwrite),
		.regdest(regdest),
		.memtoreg(memtoreg),
		.regwrite(regwrite),
		.awrite(awrite),
		.bwrite(bwrite),
		.alusrca(alusrca),
		.alusrcb(alusrcb),
		.aluop(aluop),
		.aluoutwrite(aluoutwrite),
		.pcsrc(pcsrc),
		.pcwrite(pcwrite),
		.pcwritecond(pcwritecond),
		.dsrcontrol(dsrcontrol),
		.inccontrol(inccontrol),
		.mdrwrite(mdrwrite),
		.mloadab(mloadab),
		.mult(mult),
		.dloadab(dloadab),
		.div(div),
		.muxhigh(muxhigh),
		.muxlow(muxlow),
		.highwrite(highwrite),
		.lowwrite(lowwrite),
		.dlrcontrol(dlrcontrol),
		.shamtcontrol(shamtcontrol),
		.shiftval(shiftval),
		.shiftcontrol(shiftcontrol),
		.epcwrite(epcwrite),
		.alulogic(alulogic)
	);

	//registradores

	Registrador pc (.Clk(clk), .Reset(reset), .Load(pcwrite), .Entrada(pc_in), .Saida(pc_out));
	Registrador rega (.Clk(clk), .Reset(reset), .Load(awrite), .Entrada(read_data_a), .Saida(reg_out_a));
	Registrador regb (.Clk(clk), .Reset(reset), .Load(bwrite), .Entrada(read_data_b), .Saida(reg_out_b));
	Registrador aluout (.Clk(clk), .Reset(reset), .Load(aluoutwrite), .Entrada(alu_result), .Saida(reg_alu_out));
	Registrador epc (.Clk(clk), .Reset(reset), .Load(epcwrite), .Entrada(alu_result), .Saida(epc_out));

	Instr_Reg ir (.Clk(clk), .Reset(reset), .Load_ir(irwrite), .Entrada(mem_out), .Instr31_26(opcode), .Instr25_21(rs), .Instr20_16(rt), .Instr15_0(imediate));

	//muxes

	mux32_8x1 mux_iord (
		.a(pc_out),
		.b(undefined),
		.c(opcode_exp),
		.d(over_exp),
		.e(div_exp),
		.f(reg_alu_out),
		.sel(iord),
		.out(mem_data_in)
	);
	mux5_4x1 mux_regdest (
		.a(rt), 
		.b(rd), 
		.c(return_adress), 
		.d(stack_pointer), 
		.sel(regdest), 
		.out(write_register)
	);
	mux32_8x1 mux_memtoreg (
		.a(stack_top),
		.b(undefined),
		.c(undefined),
		.d(reg_alu_out),
		.e(undefined),
		.f(undefined),
		.g(undefined),
		.h(undefined),
		.sel(memtoreg),
		.out(write_data)
	);
	mux32_4x1 mux_alusrca (
		.a(pc_out),
		.b(undefined),
		.c(reg_out_a),
		.d(undefined),
		.sel(alusrca),
		.out(alu_in_a)
	);
	mux32_8x1 mux_alusrcb (
		.a(reg_out_b),
		.b(alu_1),
		.c(alu_4),
		.d(undefined),
		.e(undefined),
		.f(undefined),
		.g(undefined),
		.h(undefined),
		.sel(alusrcb), 
		.out(alu_in_b)
	);
	mux32_8x1 mux_pcsrc (
		.a(alu_result),
		.b(epc_out),
		.c(undefined),
		.d(undefined),
		.e(reg_alu_out),
		.f(reg_out_a),
		.g(undefined),
		.h(undefined),
		.sel(pcsrc),
		.out(pc_in)
	);

	//banco de reg

	Banco_reg bancoreg (
		.Clk(clk),
		.Reset(reset),
		.RegWrite(regwrite),
		.ReadReg1(rs),
		.ReadReg2(rt),
		.WriteReg(write_register),
		.WriteData(write_data),
		.ReadData1(read_data_a),
		.ReadData2(read_data_b)
	);

	//alu

	ula32 alu (
		.A(alu_in_a),
		.B(alu_in_b),
		.Seletor(aluop),
		.S(alu_result),
		.Overflow(overflowalu),
		// declarar as outras saidas dps
	);

	//memoria

	Memoria memory (
		.Address(mem_adress_in),
		.Clock(clk),
		.Wr(memrw),
		.Datain(mem_data_in),
		.Dataout(mem_out)
	);
	
endmodule
