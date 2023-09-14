module BEQ_Forward_unit (opcode, mem_read_EX, mem_read_MEM, RS1, RS2, RD_WB, RD_MEM, RD_EX, beqFA, beqFB, Pcwrite_beq, IF_ID_Write_beq, stall_en_beq);
  input [6:0] opcode;
  input mem_read_EX, mem_read_MEM;
  input [4:0] RS1,RS2;
  input [4:0] RD_WB, RD_MEM, RD_EX;
  output [1:0] beqFA, beqFB;
  output  Pcwrite_beq, IF_ID_Write_beq, stall_en_beq;
  
  assign beqFA = ((RS1 == RD_EX) & (RD_EX != 5'd0) & (mem_read_EX == 1'b0)) ? 2'd3 : 
                 ((RS1 == RD_MEM) & (RD_MEM != 5'd0) & (mem_read_MEM == 1'b0)) ? 2'd2 :
                 ((RS1 == RD_WB) & (RD_WB != 5'd0)) ? 2'd1 :2'd0;
  assign {Pcwrite_beq, IF_ID_Write_beq, stall_en_beq} = (((RS1 == RD_EX) & (RD_EX != 5'd0) & (mem_read_EX == 1'b1) & (opcode == 7'b1100011)) | 
                                                          ((RS1 == RD_MEM) & (RD_MEM != 5'd0) & (mem_read_MEM == 1'b1) & (opcode == 7'b1100011))) ? 3'b011 : 3'b100;
                 
  assign beqFB = ((RS2 == RD_EX) & (RD_EX != 5'd0) & (mem_read_EX == 1'b0)) ? 2'd3 : 
                 ((RS2 == RD_MEM) & (RD_MEM != 5'd0) & (mem_read_MEM == 1'b0)) ? 2'd2 :
                 ((RS2 == RD_WB) & (RD_WB != 5'd0)) ? 2'd1 :2'd0;
  
endmodule