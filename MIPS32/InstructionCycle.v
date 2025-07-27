/*
MIPS32 Instruction Execution Cycle
----------------------------------
a) IF  : Instruction Fetch
b) ID  : Instruction Decode / Register Fetch    //simultaneously decoding instruction and fetching regs, 16bit address and expanding its sign to 32 bits.
c) EX  : Execution / Effective Address Calculation  //simultaneously
d) MEM : Memory Access / Branch Completion
e) WB  : Register Write-back

IF:
IR(instruction reg) <--- Mem[PC];
NPC <--- PC + 1;    //for byte addressable memory, PC + 4;

ID:
//Decoding and reading reg parallely, since fields are in fixed location in instruction format
A <--- Reg[rs];
B <--- Reg[rt];
Imm <--- (IR15)16 ## (IR15..0)  //sign extension of 16-bit immediate field
Imm1 <--- (IR25)6 ## (IR25..0)  //used for J-type instructions

EX:
ALU operates on operands already made in previous cycle like A, B, Imm etc
eg:LW R3, 100(R8)
ALUout <--- A(R8) + Imm(100);   
eg:SUB R2, R5, R12
ALUout <--- A(R5) func(SUB) B(R12);
eg:SUBI R2, R5, 524
ALUout <--- A(R5) func(SUBI) Imm(524);
eg:BEQZ R2, Label
ALUout <--- NPC + Imm; (imm should be used accordingly wrt next instruction)
cond <--- (A op(==) 0);

MEM:
//only used by load, store and branch related instructions
eg:Load
PC <--- NPC;
LMD(Load Memory Data, another reg) <--- Mem[ALUout];
eg:Store
PC <--- NPC;
Mem[ALUout] <--- B;
eg:Branch
if (cond) PC <--- ALUout;
else PC <--- NPC;
eg:Other instructions
PC <--- NPC;

WB:
//may come from ALU, or memory system(load instruction-LMD)
//position of dest reg depends on type of instruction
eg:Reg-reg ALU inst
Reg[rd] <--- ALUout;
eg:Reg-imm ALU inst
Reg[rt] <--- ALUout;
eg:Load inst
Reg[rt] <--- LMD;



