`timescale 1ns / 1ps
//Addition of two register values and store it back in register
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2024 18:21:56
// Design Name: 
// Module Name: testMips
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


module test_mips32;
reg clk1,clk2;
integer k;

pipe_MIPS32 mips(clk1,clk2);

initial
begin
    clk1=0; clk2=0;         //Generating two phase clock
    repeat(20) begin
    #5 clk1=1; #5 clk1=0;
    #5 clk2=1; #5 clk2=0;
    end
end
initial
begin
    for(k=0; k<31; k=k+1)
        mips.Reg[k]=k;
                        //OP CODE=[INST-rs-rt-rd-immediate]
        mips.Mem[0]=32'h2801000a;       //ADDI R1, R0, 10
        mips.Mem[1]=32'h28020014;       //ADDI R2, R0, 20
        mips.Mem[2]=32'h28030019;       //ADDI R3, R0, 25
        mips.Mem[3]=32'h0ce77800;       //OR R7, R7, R7 --DUMMY INST
        mips.Mem[4]=32'h0ce77800;       //OR R7, R7, R7 --DUMMY INST
        mips.Mem[5]=32'h00222000;       //ADD R4, R1, R2
        mips.Mem[6]=32'h0ce77800;       //OR R7, R7, R7 --DUMMY INST(to avoid data hazard)
        mips.Mem[7]=32'h00832800;       //ADD R5, R4, R3
        mips.Mem[8]=32'hfc000000;       //HALT
        
        mips.HALTED=0;
        mips.PC=0;
        mips.TAKEN_BRANCH=0;
        
        #280
        for(k=0; k<6; k=k+1)
            $display ("R%1d-%2d", k, mips.Reg[k]);
end        
initial
begin
    $dumpfile("mips1.vcd");
    $dumpvars(0, test_mips32);
    #300 $finish;
end
endmodule
