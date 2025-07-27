/*
(a)Instruction: ADD R2, R5, R10

IF: 
IR <--- mem[PC];
NPC <--- PC + 1;

ID:
A <--- Reg[rs];
B <--- Reg[rt];
//Imm and Imm1 are computed too, but not used and hence not shown

EX:
ALUout <--- A + B;

MEM:
PC <--- NPC;

WB:
Reg[rd] <--- ALUout;

(b)Instruction: ADDI R2, R5, 150

IF:
IR  <--- mem[PC];
NPC <--- PC + 1;

ID:
A    <--- Reg[rs];              // rs = R5
Imm  <--- (IR15)16 ## (IR15..0) // sign-extended 16-bit immediate = 150
//B and Imm1 computed, not shown

EX:
ALUout <--- A + Imm;

MEM:
PC <--- NPC;

WB:
Reg[rt] <--- ALUout;           // rt = R2

(c) Instruction: LW R2, 200(R6)

IF:
  IR  <---  Mem[PC];
  NPC <---  PC + 1;

ID:
  A   <---  Reg[rs];        // rs = R6
  Imm <---  (IR15)16 ## IR15..0;

EX:
  ALUOut <--- A + Imm;

MEM:
  PC  <--- NPC;
  LMD <--- Mem[ALUOut];

WB:
  Reg[rt] <--- LMD;         // rt = R2

(d) Instruction: SW R3, 25(R10)

IF:
  IR  <---  Mem[PC];
  NPC <---  PC + 1;

ID:
  A   <---  Reg[rs];         // rs = R10 (base address)
  B   <---  Reg[rt];         // rt = R3 (data to store)
  Imm <---  (IR15)16 ## IR15..0;

EX:
  ALUOut <--- A + Imm;

MEM:
  PC         <--- NPC;
  Mem[ALUOut] <--- B;

WB:
  -            // No write-back in store instruction

(e) Instruction: BEQZ R3, Label

IF:
  IR  <--- Mem[PC];
  NPC <--- PC + 1;

ID:
  A   <--- Reg[rs];         // rs = R3
  Imm <--- (IR15)16 ## IR15..0; //address of label

EX:
  ALUOut <--- NPC + Imm;
  cond   <--- (A == 0);

MEM:
  PC <--- NPC;
  if (cond) PC <--- ALUOut; //can add 'else' after this inside which PC<--NPC from above

WB:
  -                     // No register write-back in branch


*/