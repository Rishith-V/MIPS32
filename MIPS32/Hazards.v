/*
1.Structural - Same hardware resource used concurrently in two stages
2.Data - Same reg used in consecutive instructions
         Eg: ADD R1, R2, R3; SUB R5, R1, R3; => R1 can't be used ID of 2nd before WB of 1st.
3.Control - Branching instructions, two more instructions in pipe before actual PC generated.     
