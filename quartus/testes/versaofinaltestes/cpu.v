module cpu (clk, reset, pc_out, reg_alu_out, mem_adress_in, mdr_out, dsr_out, dlr_out, opcode, rs, rt, epc_out, stateout, imediate, rd);

	//inputs

	input wire clk;
	input wire reset;
	output wire [31:0]pc_out;
	output wire [31:0]reg_alu_out;
	output wire [31:0]mem_adress_in;
	output wire [31:0]mdr_out;
	output wire [31:0]dsr_out;
	output wire [31:0]dlr_out;
	output wire [5:0]opcode;
	output wire [4:0]rs;
	output wire [4:0]rt;
	output wire [31:0]epc_out;
	output wire [6:0]stateout;
	output wire [15:0]imediate;
	output wire [4:0]rd = imediate[15:11];

	parameter stack_pointer = 5'd29; // $29
	parameter stack_top = 32'd227;
	parameter return_adress = 5'd31; // $31
	parameter opcode_exp = 32'd253; // nopcode
	parameter over_exp = 32'd254; // overflow
	parameter div_exp = 32'd255; // div0
	parameter alu_4 = 32'd4;
	parameter alu_1 = 32'd1;
	parameter undefined = 32'd0; 

	//fios - ver depois os fios que vao precisar pra outras instrucoes alem do add (conferir se tudo do add ta ai)

	wire lt;
	wire gt;
	wire et;
	wire [31:0]lt_32;
	wire [31:0]pc_in;
	wire [31:0]branch;
	wire [4:0]shift_amt;
	wire [31:0]shift_in;
	wire [5:0]funct = imediate[5:0];
	wire [31:0]incdecadr;
	wire [25:0]instruction_26 = {rs, rt, imediate};
	wire [27:0]instruction_28;
	wire [31:0]jump_adr = {pc_out[31:28], instruction_28};
	wire [31:0]read_data_a;
	wire [31:0]read_data_b;
	wire [31:0]reg_out_a;
	wire [31:0]reg_out_b;
	wire [4:0]write_register;
	wire [31:0]write_data;
	wire [31:0]write_data_mem;
	wire [31:0]alu_in_a;
	wire [31:0]alu_in_b;
	wire [31:0]alu_result;
	wire [31:0]shift_out;
	wire [31:0]imediate_lui;
	wire [31:0]mult_high_out;
	wire [31:0]mult_low_out;
	wire [31:0]div_high_out;
	wire [31:0]div_low_out;
	wire [31:0]high_in;
	wire [31:0]low_in;
	wire [31:0]high_out;
	wire [31:0]low_out;
	
	wire [31:0]imediate_extend;
	wire [31:0]mem_out;

	//fios do controle

	wire multend;
	wire divend;
	wire alu_logic_out;
	wire pcwrite;
	wire pcwritecond;
	wire pcwritecondand = pcwritecond & alu_logic_out;
	wire pcwriteor = pcwrite | pcwritecondand;
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
	
	//Controle

	control ctrl (
		.clk(clk),
		.reset(reset),
		.opCode(opcode),
		.funct(funct),
		.overFlow(overflowalu), 
		.divZero(divzero),
		.multend(multend),
		.divend(divend),
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
		.alulogic(alulogic),
		.state(stateout)
	);

	//extensores

	signextend16_32 extend16_32 (.in(imediate), .out(imediate_extend));
	shiftleft2_32_32 shift_extend32_32 (.imediate(imediate_extend), .imediate_shifted(branch));
	shiftleft2_26_28 shift_extend26_28 (.instruction_26(instruction_26), .instruction_28(instruction_28));
	shiftleft16_16_32 shift_extend16_32 (.imediate(imediate), .imediate_shifted(imediate_lui));
	signextend1_32 extend1_32 (.lt(lt), .lt_32(lt_32));
	unsignextend26_32 extend26_32 (.instruction_26(instruction_26), .instruction_32(incdecadr));

	//registradores

	Registrador pc (.Clk(clk), .Reset(reset), .Load(pcwriteor), .Entrada(pc_in), .Saida(pc_out));
	Registrador rega (.Clk(clk), .Reset(reset), .Load(awrite), .Entrada(read_data_a), .Saida(reg_out_a));
	Registrador regb (.Clk(clk), .Reset(reset), .Load(bwrite), .Entrada(read_data_b), .Saida(reg_out_b));
	Registrador aluout (.Clk(clk), .Reset(reset), .Load(aluoutwrite), .Entrada(alu_result), .Saida(reg_alu_out));
	Registrador epc (.Clk(clk), .Reset(reset), .Load(epcwrite), .Entrada(alu_result), .Saida(epc_out));
	Registrador high (.Clk(clk), .Reset(reset), .Load(highwrite), .Entrada(high_in), .Saida(high_out));
	Registrador low (.Clk(clk), .Reset(reset), .Load(lowwrite), .Entrada(low_in), .Saida(low_out));
	Registrador mdr (.Clk(clk), .Reset(reset), .Load(mdrwrite), .Entrada(mem_out), .Saida(mdr_out));

	Instr_Reg ir (.Clk(clk), .Reset(reset), .Load_ir(irwrite), .Entrada(mem_out), .Instr31_26(opcode), .Instr25_21(rs), .Instr20_16(rt), .Instr15_0(imediate));

	//muxes

	mux32_8x1 mux_iord ( //done
		.a(pc_out),
		.b(incdecadr),
		.c(opcode_exp),
		.d(over_exp),
		.e(div_exp),
		.f(reg_alu_out),
		.g(undefined), //not used
		.h(undefined), //not used
		.sel(iord),
		.out(mem_adress_in)
	);
	mux5_4x1 mux_regdest ( //done
		.a(rt), 
		.b(rd), 
		.c(return_adress), 
		.d(stack_pointer), 
		.sel(regdest), 
		.out(write_register)
	);
	mux32_8x1 mux_memtoreg ( //done
		.a(stack_top),
		.b(imediate_lui),
		.c(lt_32),
		.d(reg_alu_out),
		.e(shift_out),
		.f(low_out), 
		.g(high_out),
		.h(dlr_out), 
		.sel(memtoreg),
		.out(write_data)
	);
	mux32_4x1 mux_alusrca ( // done
		.a(pc_out),
		.b(mdr_out),
		.c(reg_out_a),
		.d(undefined), //not used
		.sel(alusrca),
		.out(alu_in_a)
	);
	mux32_8x1 mux_alusrcb ( // done
		.a(reg_out_b),
		.b(alu_1),
		.c(alu_4),
		.d(imediate_extend),
		.e(branch),
		.f(undefined), //not used
		.g(undefined), //not used
		.h(undefined), //not used
		.sel(alusrcb), 
		.out(alu_in_b)
	);
	mux32_8x1 mux_pcsrc ( //done
		.a(alu_result),
		.b(epc_out),
		.c(dlr_out),
		.d(jump_adr),
		.e(reg_alu_out),
		.f(reg_out_a),
		.g(undefined), // not used
		.h(undefined), // not used
		.sel(pcsrc),
		.out(pc_in)
	);
	mux5_2x1 mux_shamtcontrol ( //done
		.a(imediate[10:6]),
		.b(reg_out_b[4:0]),
		.sel(shamtcontrol),
		.out(shift_amt)
	);
	mux32_2x1 mux_shiftval ( //done
		.a(reg_out_b),
		.b(reg_out_a),
		.sel(shiftval),
		.out(shift_in)
	);
	mux32_2x1 mux_high ( //done
		.a(mult_high_out),
		.b(div_high_out),
		.sel(muxhigh),
		.out(high_in)
	);
	mux32_2x1 mux_low ( //done
		.a(mult_low_out),
		.b(div_low_out),
		.sel(muxlow),
		.out(low_in)
	);
	mux32_2x1 mux_inc ( //done
		.a(reg_alu_out),
		.b(dsr_out),
		.sel(inccontrol),
		.out(write_data_mem)
	);
	mux1_4x1 mux_alulogic ( //done
		.a(et),
		.b(~et),
		.c(gt),
		.d(~gt),
		.sel(alulogic),
		.out(alu_logic_out)
	);

	//banco de reg

	Banco_reg bancoreg ( // done
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

	//registrador de deslocamento

	RegDesloc shift_reg ( // done
		.Clk(clk),
		.Reset(reset),
		.Shift(shiftcontrol),
		.N(shift_amt),
		.Entrada(shift_in),
		.Saida(shift_out)
	);

	//alu

	ula32 alu ( // done 
		.A(alu_in_a),
		.B(alu_in_b),
		.Seletor(aluop),
		.S(alu_result),
		.Overflow(overflowalu),
		.Menor(lt),
		.Igual(et),
		.Maior(gt)
	);

	//mult

	mult MULT (
		.clk(clk),
		.mult(mloadab),
		.reset(reset),
		.a(reg_out_a),
		.b(reg_out_b),
		.high(mult_high_out),
		.low(mult_low_out),
		.mult_end(multend)
	);

	//div

	div DIV (
		.clk(clk),
		.reset(reset),
		.div(dloadab),
		.div_end(divend),
		.div_zero(divzero),
		.a(reg_out_a),
		.b(reg_out_b),
		.high(div_high_out),
		.low(div_low_out),
	);

	//memoria

	Memoria memory ( //done
		.Address(mem_adress_in),
		.Clock(clk),
		.Wr(memrw),
		.Datain(write_data_mem),
		.Dataout(mem_out)
	);

	dlr DLR (
		.data(mdr_out),
		.dlrcontrol(dlrcontrol),
		.out(dlr_out)
	);

	dsr DSR (
		.b(reg_out_b),
		.data(mdr_out),
		.dsrcontrol(dsrcontrol),
		.out(dsr_out)
	);
	
endmodule
