module RISCV_Pipeline (rst, clk, adr);
  input rst,clk;
  wire [7:0] WME;
  wire  PcSrc, PcWrite, IF_Flush, IF_ID_Write, stall_en, jalr;
  wire [1:0] ForwardA, ForwardB;
  wire [3:0] operation;
  wire EQ, Regwrite_MEM, Regwrite_WB,mem_read;
  wire [3:0] func_alu_out, func_alu;
  wire [1:0] alu_op;
  wire [4:0] RD_n_MEM;
  wire [4:0] RD_n_WB;
  wire [4:0] RS1_n_EX, RS2_n_EX,RD_old_EX;
  wire [4:0] RS1_new_ID, RS2_new_ID; 
  wire [6:0] opcode;
  wire [6:0] opcode_new;
  output [63:0] adr;
  
      
 datapath DP( clk, rst, WME, PcSrc, PcWrite, IF_Flush, IF_ID_Write, stall_en, ForwardA, ForwardB, 
                operation,      EQ, Regwrite_MEM, Regwrite_WB, mem_read, func_alu_out, alu_op, RD_n_MEM, RD_n_WB, 
                RS1_n_EX, RS2_n_EX, RD_old_EX, RS1_new_ID, RS2_new_ID, opcode, adr, func_alu, opcode_new, jalr
                 );
                 
 controller CU(func_alu, opcode, EQ, IF_Flush, PcSrc, WME, jalr);
 
 alu_controller ALU_CTRL(alu_op, func_alu_out, operation);
 
 Hazard_Detection_unit HDU(mem_read, RD_old_EX, RS1_new_ID, RS2_new_ID,
                               PcWrite, IF_ID_Write, stall_en);
 
 Forwarding_unit FU(opcode_new, RD_n_MEM, RD_n_WB, RS1_n_EX, RS2_n_EX, Regwrite_MEM, Regwrite_WB, 
                      ForwardA, ForwardB);
                      
endmodule
