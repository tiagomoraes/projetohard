module control(
	input clk,
	input reset,
	input [5:0] opCode,
	input [5:0] funct,
	input overFlow, 
	input divZero,
    input multend,
    input divend,
	
	output reg [2:0] iord,
	output reg memrw,
	output reg irwrite,
	output reg [1:0] regdest,
	output reg [2:0] memtoreg,
	output reg regwrite,
	output reg awrite,
	output reg bwrite,
	output reg [1:0] alusrca,
	output reg [2:0] alusrcb,
	output reg [2:0] aluop,
	output reg aluoutwrite,
	output reg [2:0] pcsrc,
	output reg pcwrite,
	output reg pcwritecond,
	output reg [1:0] dsrcontrol,
	output reg inccontrol,
	output reg mdrwrite,
	output reg mloadab,
	output reg mult,
	output reg dloadab,
	output reg div,
	output reg muxhigh,
	output reg muxlow,
	output reg highwrite,
	output reg lowwrite,
	output reg [1:0] dlrcontrol,
	output reg shamtcontrol,
	output reg shiftval,
	output reg [2:0] shiftcontrol,
	output reg epcwrite,
	output reg [1:0] alulogic,
    output reg [5:0]state
);

parameter RESET = 6'd0;
parameter FETCH = 6'd1;
parameter WAIT = 6'd2;
parameter DECODE = 6'd3;
parameter ADD = 6'd4;
parameter AND = 6'd5;
parameter SUB = 6'd6;
parameter WRITERD_ARIT = 6'd7;
parameter SHIFT_SHAMT = 6'd8;
parameter SLL = 6'd9;
parameter SRA = 6'd10;
parameter SRL = 6'd11;
parameter SHIFT_REG = 6'd12;
parameter SLLV = 6'd13;
parameter SRAV = 6'd14;
parameter WRITERD_SHIFT = 6'd15;
parameter MFHI = 6'd16;
parameter MFLO = 6'd17;
parameter SLT = 6'd18;
parameter JR = 6'd19;
parameter RTE = 6'd20;
parameter BREAK = 6'd21;
parameter MULT_LOAD = 6'd22;
parameter MULT_CALC = 6'd23;
parameter MULT_RESULT = 6'd24;
parameter DIV_LOAD = 6'd25;
parameter DIV_CALC = 6'd26;
parameter DIV_RESULT = 6'd27;
parameter JAL = 6'd28;
parameter RETURN_ADDRESS = 6'd29;
parameter J = 6'd30;
parameter INCDEC = 6'd31;
parameter INCDEC_WAIT = 6'd32;
parameter DEC_OP = 6'd33;
parameter INC_OP = 6'd34;
parameter INCDEC_ST = 6'd35;
parameter ADDIU = 6'd36;
parameter ADDI = 6'd37;
parameter REG_WRITE = 6'd38;
parameter BEQ = 6'd39;
parameter BNE = 6'd40;
parameter BLE = 6'd41;
parameter BGT = 6'd42;
parameter LUI = 6'd43;
parameter SLTI = 6'd44;
parameter LS_CALC = 6'd45;
parameter LS_START = 6'd46;
parameter LS_WAIT = 6'd47;
parameter SB_END = 6'd48;
parameter SH_END = 6'd49;
parameter SW_END = 6'd50;
parameter LB_END = 6'd51;
parameter LH_END = 6'd52;
parameter LW_END = 6'd53;
parameter OVERFLOW = 6'd54;
parameter DIVZERO = 6'd55;
parameter NOPCODE = 6'd56;
parameter EXP_WAIT = 6'd57;
parameter EXP_WRITE = 6'd58;
parameter WAIT_2 = 6'd59;
parameter INCDEC_WAIT_2 = 6'd60;
parameter LS_WAIT_2 = 6'd61;
parameter EXP_WAIT_2 = 6'd62;

reg [5:0]nextState;

always@(posedge clk or posedge reset) begin
	if (reset)
		state = RESET;
	else
		state = nextState;
end 

always@(*) begin
	case (state)
    
		RESET: begin
			iord = 3'b000;
			memrw = 1'b0;
			irwrite = 1'b0;
			regdest = 2'b11;
			memtoreg = 3'b000;
			regwrite = 1'b1;
			awrite = 1'b0;
			bwrite = 1'b0;
			alusrca = 2'b00; 
			alusrcb = 3'b000;
			aluop = 3'b000;
			aluoutwrite = 1'b0;
			pcsrc = 3'b000;
			pcwrite = 1'b0;
			pcwritecond = 1'b0;
			dsrcontrol = 2'b00;
			inccontrol = 1'b0;
			mdrwrite = 1'b0;
			mloadab= 1'b0;
			mult = 1'b0;
			dloadab = 1'b0;
			div = 1'b0;
			muxhigh = 1'b0;
			muxlow = 1'b0;
			highwrite = 1'b0;
			lowwrite = 1'b0;
			dlrcontrol = 2'b00;
			shamtcontrol =  1'b0;
			shiftval = 1'b0;
			shiftcontrol = 3'b000;
			epcwrite = 1'b0;
			alulogic = 2'b00;

			nextState = FETCH;
		end

        FETCH: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b010;
            aluop = 3'b001;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b1;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = WAIT;
        end

        WAIT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = WAIT_2;
        end

         WAIT_2: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b1;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = DECODE;
        end

        DECODE: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b1;
            bwrite = 1'b1;
            alusrca = 2'b00; 
            alusrcb = 3'b100;
            aluop = 3'b001;
            aluoutwrite = 1'b1;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            case (opCode)
                6'h0: begin
                    case(funct)
                        6'h20: nextState = ADD;
                        6'h24: nextState = AND;
                        6'h22: nextState = SUB;
                        6'h0: nextState = SHIFT_SHAMT;
                        6'h2: nextState = SHIFT_SHAMT;
                        6'h3: nextState = SHIFT_SHAMT;
                        6'h4: nextState = SHIFT_REG;
                        6'h7: nextState = SHIFT_REG;
                        6'h10: nextState = MFHI;
                        6'h12: nextState = MFLO;
                        6'h2a: nextState = SLT;
                        6'h8: nextState = JR;
                        6'h13: nextState = RTE;
                        6'hd: nextState = BREAK;
                        6'h18: nextState = MULT_LOAD;
                        6'h1a: nextState = DIV_LOAD;
                    endcase
                end

                6'h3: nextState = JAL;
                6'h2: nextState = J;
                6'h10: nextState = INCDEC;
                6'h11: nextState = INCDEC;
                6'h8: nextState = ADDI;
                6'h9: nextState = ADDIU;
                6'h4: nextState = BEQ;
                6'h5: nextState = BNE;
                6'h6: nextState = BLE;
                6'h7: nextState = BGT;
                6'hf: nextState = LUI;
                6'ha: nextState = SLTI;
                6'h28: nextState = LS_CALC;
                6'h29: nextState = LS_CALC;
                6'h2b: nextState = LS_CALC;
                6'h20: nextState = LS_CALC;
                6'h21: nextState = LS_CALC;
                6'h23: nextState = LS_CALC;
                default: nextState = NOPCODE;
            endcase

        end

        ADD: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; 
            alusrcb = 3'b000;
            aluop = 3'b001;
            aluoutwrite = 1'b1;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            if (overFlow)
                nextState = OVERFLOW;
            else
                nextState = WRITERD_ARIT;
        end

        SUB: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; 
            alusrcb = 3'b000;
            aluop = 3'b010;
            aluoutwrite = 1'b1;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            if (overFlow)
                nextState = OVERFLOW;
            else
                nextState = WRITERD_ARIT;
        end

        AND: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; 
            alusrcb = 3'b000;
            aluop = 3'b011;
            aluoutwrite = 1'b1;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = WRITERD_ARIT;
        end

        WRITERD_ARIT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b01;
            memtoreg = 3'b011;
            regwrite = 1'b1;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end
        
        SHIFT_SHAMT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b001;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            case (funct)
                6'h0: nextState = SLL;
                6'h3: nextState = SRA;
                6'h2: nextState = SRL;
            endcase
        end

        SLL: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b010;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = WRITERD_SHIFT;
        end

        SRA: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b100;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = WRITERD_SHIFT;
        end

        SRL: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b011;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = WRITERD_SHIFT;
        end

        SHIFT_REG: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b1;
            shiftval = 1'b1;
            shiftcontrol = 3'b001;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            case (funct)
                6'h4: nextState = SLLV;
                6'h7: nextState = SRAV;
            endcase
        end

        SLLV: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b1;
            shiftval = 1'b1;
            shiftcontrol = 3'b010;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = WRITERD_SHIFT;
        end

        SRAV: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b1;
            shiftval = 1'b1;
            shiftcontrol = 3'b100;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = WRITERD_SHIFT;
        end

        WRITERD_SHIFT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b01;
            memtoreg = 3'b100;
            regwrite = 1'b1;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        MFHI: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b01;
            memtoreg = 3'b110;
            regwrite = 1'b1;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        MFLO: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b01;
            memtoreg = 3'b101;
            regwrite = 1'b1;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        SLT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b01;
            memtoreg = 3'b010;
            regwrite = 1'b1;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; 
            alusrcb = 3'b000;
            aluop = 3'b111;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        JR: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b101;
            pcwrite = 1'b1;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        RTE: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b001;
            pcwrite = 1'b1;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        BREAK: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b010;
            aluop = 3'b010;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b1;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        MULT_LOAD: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b1;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = MULT_CALC;
        end

        MULT_CALC: begin // ver se ta certo
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;
            if (multend) 
                nextState = MULT_RESULT;
            else
                nextState = MULT_CALC;
        end
        
        MULT_RESULT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b1;
            lowwrite = 1'b1;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        DIV_LOAD: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b1;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = DIV_CALC;
        end

        DIV_CALC: begin // ver se ta certo
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;
			if (divZero)
				nextState = DIVZERO;
			else begin
				if (divend)
					nextState = DIV_RESULT;
				else 
					nextState = DIV_CALC;
			end
        end

        DIV_RESULT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b1;
            muxlow = 1'b1;
            highwrite = 1'b1;
            lowwrite = 1'b1;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        JAL: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b1;
            pcsrc = 3'b011;
            pcwrite = 1'b1;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = RETURN_ADDRESS;
        end

        RETURN_ADDRESS: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b10;
            memtoreg = 3'b011;
            regwrite = 1'b1;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        J: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b011; //
            pcwrite = 1'b1; //
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        INCDEC: begin
            iord = 3'b001; //
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = INCDEC_WAIT;
        end

        INCDEC_WAIT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = INCDEC_WAIT_2;

        end

        INCDEC_WAIT_2: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b1;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            case (opCode)
                6'h11: nextState = DEC_OP;
                6'h10: nextState = INC_OP;
            endcase
        end

        DEC_OP: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b01; // 
            alusrcb = 3'b001; //
            aluop = 3'b010; //
            aluoutwrite = 1'b1; //
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            if (overFlow)
                nextState = OVERFLOW;
            else
                nextState = INCDEC_ST;
        end

        INC_OP: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b01; // 
            alusrcb = 3'b001; //
            aluop = 3'b001; //
            aluoutwrite = 1'b1; //
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            if (overFlow)
                nextState = OVERFLOW;
            else
                nextState = INCDEC_ST;
        end

        INCDEC_ST: begin
            iord = 3'b001; //
            memrw = 1'b1; //
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        ADDI: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; //
            alusrcb = 3'b011; //
            aluop = 3'b001; //
            aluoutwrite = 1'b1; //
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            if (overFlow)
                nextState = OVERFLOW;
            else
                nextState = REG_WRITE;
        end

        ADDIU: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; //
            alusrcb = 3'b011; //
            aluop = 3'b001; //
            aluoutwrite = 1'b1; //
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = REG_WRITE;
        end

        REG_WRITE: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b011; //
            regwrite = 1'b1; //
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        BEQ: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; // 
            alusrcb = 3'b000;
            aluop = 3'b111; //
            aluoutwrite = 1'b0;
            pcsrc = 3'b100; //
            pcwrite = 1'b0;
            pcwritecond = 1'b1; //
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        BNE: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; // 
            alusrcb = 3'b000;
            aluop = 3'b111; //
            aluoutwrite = 1'b0;
            pcsrc = 3'b100; //
            pcwrite = 1'b0;
            pcwritecond = 1'b1; //
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b01; //

            nextState = FETCH;
        end

        BLE: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; // 
            alusrcb = 3'b000;
            aluop = 3'b111; //
            aluoutwrite = 1'b0;
            pcsrc = 3'b100; //
            pcwrite = 1'b0;
            pcwritecond = 1'b1; //
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b11; //

            nextState = FETCH;
        end

        BGT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; // 
            alusrcb = 3'b000;
            aluop = 3'b111; //
            aluoutwrite = 1'b0;
            pcsrc = 3'b100; //
            pcwrite = 1'b0;
            pcwritecond = 1'b1; //
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b10; //

            nextState = FETCH;
        end

        LUI: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b001; //
            regwrite = 1'b1; //
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        SLTI: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b010; //
            regwrite = 1'b1; //
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; // 
            alusrcb = 3'b011; //
            aluop = 3'b111; //
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        LS_CALC: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b10; // 
            alusrcb = 3'b011; //
            aluop = 3'b001; //
            aluoutwrite = 1'b1; //
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = LS_START;
        end

        LS_START: begin
            iord = 3'b101; //
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0; //
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = LS_WAIT;
        end

        LS_WAIT: begin
            iord = 3'b101;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0; 
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = LS_WAIT_2;
        end

        LS_WAIT_2: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b1;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            case (opCode)
                6'h28: nextState = SB_END;
                6'h29: nextState = SH_END;
                6'h2b: nextState = SW_END;
                6'h20: nextState = LB_END;
                6'h21: nextState = LH_END;
                6'h23: nextState = LW_END;
            endcase
        end

        SB_END: begin
            iord = 3'b101;
            memrw = 1'b1; //
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b1; //
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        SH_END: begin
            iord = 3'b101;
            memrw = 1'b1; //
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b01; //
            inccontrol = 1'b1; //
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        SW_END: begin
            iord = 3'b101;
            memrw = 1'b1; //
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b10; //
            inccontrol = 1'b1; //
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        LB_END: begin
            iord = 3'b101;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b111; //
            regwrite = 1'b1; //
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        LH_END: begin
            iord = 3'b101;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b111; //
            regwrite = 1'b1; //
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b01; //
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        LW_END: begin
            iord = 3'b101;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b111; //
            regwrite = 1'b1; //
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b10; //
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end

        OVERFLOW: begin
            iord = 3'b011; //
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b010; //
            aluop = 3'b010; //
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b1; //
            alulogic = 2'b00;

            nextState = EXP_WAIT;
        end

        DIVZERO: begin
            iord = 3'b100; //
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b010; //
            aluop = 3'b010; //
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b1; //
            alulogic = 2'b00;

            nextState = EXP_WAIT;
        end

       NOPCODE: begin
            iord = 3'b010; //
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b010; //
            aluop = 3'b010; //
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b1; //
            alulogic = 2'b00;

            nextState = EXP_WAIT;
        end

        EXP_WAIT: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = EXP_WAIT_2;
        end

        EXP_WAIT_2: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b000;
            pcwrite = 1'b0;
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b1;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = EXP_WRITE;
        end

        EXP_WRITE: begin
            iord = 3'b000;
            memrw = 1'b0;
            irwrite = 1'b0;
            regdest = 2'b00;
            memtoreg = 3'b000;
            regwrite = 1'b0;
            awrite = 1'b0;
            bwrite = 1'b0;
            alusrca = 2'b00; 
            alusrcb = 3'b000;
            aluop = 3'b000;
            aluoutwrite = 1'b0;
            pcsrc = 3'b010;
            pcwrite = 1'b1; 
            pcwritecond = 1'b0;
            dsrcontrol = 2'b00;
            inccontrol = 1'b0;
            mdrwrite = 1'b0;
            mloadab= 1'b0;
            mult = 1'b0;
            dloadab = 1'b0;
            div = 1'b0;
            muxhigh = 1'b0;
            muxlow = 1'b0;
            highwrite = 1'b0;
            lowwrite = 1'b0;
            dlrcontrol = 2'b00;
            shamtcontrol =  1'b0;
            shiftval = 1'b0;
            shiftcontrol = 3'b000;
            epcwrite = 1'b0;
            alulogic = 2'b00;

            nextState = FETCH;
        end
    endcase
end

endmodule
