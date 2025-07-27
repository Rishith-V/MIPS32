/*
MIPS32 processor with
1.A small subset of its ISA(RISC based).
2.Pipelined implementation.
3.32 32-bit registers.
4.R0 always contains 0(can't be overwritten).
5.Program Counter(PC) has address to next instruction.
6.No flag registers.
7.Few addressing modes.
8.Only 2 instructions - load and store, can access memory,
all other instructions operate on CPU registers.
9.Memory is word addressable, word size = 32bits(assumption).


*/