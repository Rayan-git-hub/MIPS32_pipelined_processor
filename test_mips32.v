`timescale 1ns / 1ps
//Adding two numbers and store it in Memory.
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2024 19:31:29
// Design Name: 
// Module Name: test_mips32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test2_mips32;
    reg clk1,clk2;
    integer k;
    
    pipe_MIPS32 mips(clk1,clk2);
    
initial
begin
    clk1=0; clk2=0;
    repeat(50)
    begin
        #5 clk1=1; #5 clk1=0;
        #5 clk2=1; #5 clk2=0;
        end
    end
initial 
begin
    for(k=0;k<31;k=k+1)
        mips.Reg[k]=k;
            mips.Mem[0] = 32'h28010078;      //ADDI R1, R0, 150
            mips.Mem[1] = 32'h0c631800;      //OR R3, R3, R3
            mips.Mem[2] = 32'h20220000;      //LW R2, 0(R1)
            mips.Mem[3] = 32'h0c631800;
            mips.Mem[4] = 32'h2842002d;      //ADDI R2, R2, 45
            mips.Mem[5] = 32'h0c631800;
            mips.Mem[6] = 32'h24220001;      //SW R2, 1(R1)  1 is for storing in next location
            mips.Mem[7] = 32'hfc000000;      //HLT
            
            mips.Mem[120] = 85 ;
    mips.PC = 0;
    mips.HALTED = 0;
    mips.TAKEN_BRANCH = 0;
    
    #500  $display ("Mem[120]: %4d \nMem[121]: %4d", mips.Mem[120], mips.Mem[121]);
    end
initial
    begin
        #600 $finish;
    end
endmodule
