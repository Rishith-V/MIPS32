/*
Compute factorial of a number N stored in memory loc 200. Result in memory 198.
Initialize R10 with memory address 200
Load contents at 200 into R3
Initialize R2 with 1
Loop, multiply R3 with R2 and store in R2, dec R3 until 0
Store R2 at 198

ADDI R10, R0, 200       001010 00000 01010 0000000011001000
ADDI R2, R0, 1          001010 00000 00010 0000000000000001
LW R3, 0(R10)           001000 01010 00011 0000000000000000
Loop : MUL R2, R2, R3   000101 00010 00011 00010 00000 000000
       SUBI R3, R3, 1   001011 00011 00011 0000000000000001
       BNEQZ R3, Loop   001101 00011 00000 1111111111111101 //PC = 6, has to go to 3(Loop), -3 in 16b
SW R2, -2(R10)          001001 01010 00010 1111111111111110
HLT                     11111  00000 00000 00000 00000 000000
*/

module test_mips32();

    reg clk1, clk2;
    integer k;
    
    pipe_mips32 DUT (clk1, clk2);
    
    initial
        begin
            clk1 = 0;
            clk2 = 0;
            repeat(50)
                begin
                    #5 clk1 = 1;
                    #5 clk1 = 0;
                    #5 clk2 = 1;
                    #5 clk2 = 0;
                end
                            
        end
    
    initial 
        begin
            for (k = 0; k < 31; k = k + 1)
                DUT.Reg[k] = k;
        
            DUT.Mem[0]  = 32'h280a00c8;   // ADDI R10, R0, 200
            DUT.Mem[1]  = 32'h28020001;   // ADDI R2, R0, 1
            DUT.Mem[2]  = 32'h21430000;   // LW R3, 0(R10)
            DUT.Mem[3]  = 32'h0e94a000;   // OR R20, R20, R20 -- dummy instr.
            DUT.Mem[4]  = 32'h14431000;   // MUL R2, R2, R3
            DUT.Mem[5]  = 32'h2c630001;   // SUBI R3, R3, 1
            DUT.Mem[6]  = 32'h0e94a000;   // OR R20, R20, R20 -- dummy instr.
            DUT.Mem[7]  = 32'h3460fffc;   // BNEQZ R3, Loop  (PC=8 → PC=4 ⇒ offset = -4)
            DUT.Mem[8]  = 32'h2542fffe;   // SW R2, -2(R10)
            DUT.Mem[9]  = 32'hfc000000;   // HLT

            
            DUT.Mem[200] = 7;
            DUT.PC = 0;
            DUT.HALTED = 0;
            DUT.TAKEN_BRANCH = 0;
            
            #2000 $display("Mem[200] = %d, Mem[198] = %d", DUT.Mem[200], DUT.Mem[198]);
        
        end
        
    initial
        begin
            $monitor("Time=%0t | PC=%0d | Mem[200]=%0d | Mem[198]=%0d | R2=%0d | R10=%0d | R3=%0d | HALTED=%0b | TAKEN_BRANCH=%0b",
                      $time, DUT.PC, DUT.Mem[200], DUT.Mem[198],
                      DUT.Reg[2], DUT.Reg[10], DUT.Reg[3],
                      DUT.HALTED, DUT.TAKEN_BRANCH);
            #3000 $finish;
        end
                                          
endmodule 