/*
Micro-operations for pipelines stages
IF:
IF_ID_IR     <= Mem[PC];
IF_ID_NPC,PC <= ( (EX_MEM_IR[opcode] == branch) & EX_MEM_cond ) 
                ? EX_MEM_ALUOut     //needs flushing of IF and ID stages for branching
                : (PC + 1);
            

ID:
ID_EX_A   <= Reg[IF_ID_IR[rs]];
ID_EX_B   <= Reg[IF_ID_IR[rt]];
ID_EX_NPC <= IF_ID_NPC;
ID_EX_IR  <= IF_ID_IR;
ID_EX_Imm <= sign_extend(IF_ID_IR[15:0]);

EX:
// R-R ALU
EX_MEM_IR     <= ID_EX_IR;
EX_MEM_ALUOut <= ID_EX_A func ID_EX_B;

// R-M ALU
EX_MEM_IR     <= ID_EX_IR;
EX_MEM_ALUOut <= ID_EX_A func ID_EX_Imm;

// LOAD / STORE
EX_MEM_IR     <= ID_EX_IR;
EX_MEM_ALUOut <= ID_EX_A + ID_EX_Imm;
EX_MEM_B      <= ID_EX_B;

// BRANCH
EX_MEM_ALUOut <= ID_EX_NPC + ID_EX_Imm;
EX_MEM_cond   <= (ID_EX_A == 0);

MEM:
// ALU
MEM_WB_IR     <= EX_MEM_IR;
MEM_WB_ALUOut <= EX_MEM_ALUOut;

// LOAD
MEM_WB_IR     <= EX_MEM_IR;
MEM_WB_LMD    <= Mem[EX_MEM_ALUOut];

// STORE
MEM_WB_IR             <= EX_MEM_IR;
Mem[EX_MEM_ALUOut]    <= EX_MEM_B;

WB:
// R-R ALU
Reg[MEM_WB_IR[rd]] <= MEM_WB_ALUOut;

// R-M ALU
Reg[MEM_WB_IR[rt]] <= MEM_WB_ALUOut;

// LOAD
Reg[MEM_WB_IR[rt]] <= MEM_WB_LMD;
