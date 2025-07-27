/*
A specialized flip flop, Taken Branch, if in EX stage of 
BEQZ the condition demands the branch to be taken, is made
1, due to which write into memory and regs for the insts 
which have entered the pipe after the branch insts. 