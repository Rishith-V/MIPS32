//only have to set program counter PC and load instructions
//Add 10, 20, 25 by initializing them into R1, R2, R3 and store them using R4 and R5
/*
ADDI R1, R0, 10     001010 00000 00001 0000000000001010
ADDI R2, R0, 20     001010 00000 00010 0000000000010100
ADDI R3, R0, 25     001010 00000 00011 0000000000011001
ADD R4, R1, R2      000000 00001 00010 00100 00000 000000
ADD R5, R4, R3      000000 00100 00011 00101 00000 000000
HTL                 111111 00000 00000 00000 00000 000000

did not use ADD R2, R1, 20 in second instruction because 'Data Hazard' isn't handled in this project, or add dummy
instructions, since we use 2 phase clock, one dummy instruction will be sufficient. Add that for 4th and 5th insts.
*/
module test_mips32();
    
    reg clk1, clk2;
    integer k;
    
    pipe_mips32 DUT (clk1, clk2);
    
    initial
        begin
            clk1 = 0;
            clk2 = 0;
            repeat (20)
                begin
                    #5 clk1 = 1;
                    #5 clk1 = 0;
                    #5 clk2 = 1;
                    #5 clk2 = 0;
                end
        end
                              
    initial
        begin   
            for(k = 0; k < 31; k = k+1) //Initializing instructions
                DUT.Reg[k] = k;
                        
            DUT.Mem[0] = 32'h2801000a;  //ADDI R1, R0, 10
            DUT.Mem[1] = 32'h28020014;  //ADD R2, R0, 20
            DUT.Mem[2] = 32'h28030019;
            DUT.Mem[3] = 32'h00222000;
            DUT.Mem[4] = 32'h0ce77800;  //OR R7, R7, R7 => Dummy Instruction
            DUT.Mem[5] = 32'h00832800;
            DUT.Mem[6] = 32'hfc000000;
            
            DUT.HALTED = 0;
            DUT.PC = 0;
            DUT.TAKEN_BRANCH = 0;
            
            #500
            for(k=0; k<32; k = k+1)
                $display("R%1d = %2d", k, DUT.Reg[k]);
        end
                
    initial
        $monitor($time, "PC : %d, R1 : %d, R2 : %d, R3 : %d, R4 : %d, R5 : %d", DUT.PC, DUT.Reg[1], DUT.Reg[2], DUT.Reg[3],
                                                                                DUT.Reg[4], DUT.Reg[5]);
                                                                            
endmodule   