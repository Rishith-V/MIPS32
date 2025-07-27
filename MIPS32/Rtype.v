/* 
R-type Instruction Encoding
 
- opcode : [31:26] → 6-bit operation code (always 000000 for R-type) //6 bits = 64 Rtype instructions
- rs     : [25:21] → Source register 1 //5 bits = 32 registers
- rt     : [20:16] → Source register 2
- rd     : [15:11] → Destination register
- shamt  : [10:6]  → Shift amount (unused here) //not used in this project
- funct  : [5:0]   → Function code (specifies actual operation like ADD, SUB, etc.)//not used in this project

Note : Not all fields are required for all instructions

| Instruction | Opcode  | Description                 |
|-------------|---------|-----------------------------|
| ADD         | 000000  | R[rd] = R[rs] + R[rt]        |
| SUB         | 000001  | R[rd] = R[rs] - R[rt]        |
| AND         | 000010  | R[rd] = R[rs] & R[rt]        |
| OR          | 000011  | R[rd] = R[rs] | R[rt]        |
| SLT         | 000100  | R[rd] = (R[rs] < R[rt]) ? 1 : 0
| MUL         | 000101  | R[rd] = R[rs] * R[rt]        |
| HLT         | 111111  | Halt execution              |

All instructions except HTL required 3 regs

eg: SUB R5, R12, R25 => 000001(sub) 01100(R12) 11001(R25) 00101(R5) 00000 00000
                        = 05992800(in hex)
