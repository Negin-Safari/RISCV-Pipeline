module Hazard_Detection_unit(mem_read, RD_old_EX, RS1_new_ID, RS2_new_ID,
                               PcWrite, IF_ID_Write, stall_en);
  input mem_read;
  input [4:0] RD_old_EX;
  input [4:0] RS1_new_ID,RS2_new_ID;
  output PcWrite, IF_ID_Write, stall_en;
  reg PcWrite, IF_ID_Write, stall_en;
  
  always@(mem_read, RD_old_EX, RS1_new_ID, RS2_new_ID)begin
    if((mem_read == 1'b1) & (RD_old_EX != 1'b0) & ((RD_old_EX == RS1_new_ID)| (RD_old_EX == RS2_new_ID)))
      {PcWrite, IF_ID_Write, stall_en} = 3'b011;
    else
      {PcWrite, IF_ID_Write, stall_en} = 3'b100;
    end
  endmodule
      
