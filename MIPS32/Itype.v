/*
I-type Instruction Encoding

[31:26] -> opcode         (6 bits)
[25:21] -> rs             (Source Register 1) or (base register)
[20:16] -> rt             (Destination Register) or (data register)
[15:0]  -> Immediate Data (16-bit signed immediate value)

-----------------------------------------------------------
|      I-type Instructions and their Opcode Mapping       |
-----------------------------------------------------------
| Instruction | Opcode  | Description                     |
|-------------|---------|---------------------------------|
|    LW       | 001000  | Load Word                       |
|    SW       | 001001  | Store Word                      |
|   ADDI      | 001010  | Add Immediate                   |
|   SUBI      | 001011  | Subtract Immediate              |
|   SLTI      | 001100  | Set if Less Than Immediate      |
|  BNEQZ      | 001101  | Branch if Not Equal to Zero     |
|   BEQZ      | 001110  | Branch if Equal to Zero         |
-----------------------------------------------------------

- Memory instructions (LW/SW) use rs as base and immediate as offset.
- Branch instructions use immediate as the branch offset.

eg: LW R20, 84(R9) => 0010000(LW) 01001(R9) 10100(R20) 0000000001010100(offset = 9)
                     =21340054(hex)

eg: BEQZ R25, Label =>  001110(BEQZ) 11001(R25) 00000(unused) yyyyyyyyyyyyyyyy(offset)
                       =3B20YYYY (hex), offset is added to PC to calculate address
