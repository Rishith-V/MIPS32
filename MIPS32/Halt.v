/*
A specialized flip flop Halted, on detecting a HLT inst
in it's ID stage, is made 1, due to which the writing
into memory and registers for succeeding insts is disabled.