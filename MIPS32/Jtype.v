/*
Note: Not implemented in this project
J-type Instruction Encoding

[31:26] -> opcode (6 bits)
[25:0]  -> immediate address (26 bits), shifted left by 2 bits (×4) → 28-bit jump address

eg: J Label => 010000(J) imm_data
