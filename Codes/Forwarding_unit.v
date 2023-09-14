module Forwarding_unit(opcode_new, RD_n_MEM, RD_n_WB, RS1_n_EX, RS2_n_EX, Regwrite_MEM, Regwrite_WB, 
                      ForwardA, ForwardB);
  input [6:0] opcode_new;
  input [4:0] RD_n_MEM;
  input [4:0] RD_n_WB;
  input [4:0] RS1_n_EX, RS2_n_EX;
  input Regwrite_MEM, Regwrite_WB;
  output [1:0] ForwardA, ForwardB;
  reg [1:0] ForwardA, ForwardB;
  always@(opcode_new, RD_n_MEM, RD_n_WB, RS1_n_EX, RS2_n_EX, Regwrite_MEM, Regwrite_WB)begin
    if( (opcode_new == 7'b0100011) | (opcode_new == 7'b0110011) | (opcode_new == 7'b1100011))begin
      if((Regwrite_MEM == 1'b1) & (RD_n_MEM !=5'b0) & (RD_n_MEM == RS1_n_EX))
        ForwardA = 2'b10;
      else if((Regwrite_WB == 1'b1) & (RD_n_WB !=5'b0) & (RD_n_WB == RS1_n_EX))
        ForwardA = 2'b01;
      else
        ForwardA = 2'b00;
        
      if((Regwrite_MEM == 1'b1) & (RD_n_MEM !=5'b0) & (RD_n_MEM == RS2_n_EX))
        ForwardB = 2'b10;
      else if((Regwrite_WB == 1'b1) & (RD_n_WB !=5'b0) & (RD_n_WB == RS2_n_EX))
        ForwardB = 2'b01;
      else
        ForwardB = 2'b00;
    end
    else if( (opcode_new == 7'b0000011) | (opcode_new == 7'b0010011) | (opcode_new == 7'b1100111))begin
      if((Regwrite_MEM == 1'b1) & (RD_n_MEM !=5'b0) & (RD_n_MEM == RS1_n_EX))
        ForwardA = 2'b10;
      else if((Regwrite_WB == 1'b1) & (RD_n_WB !=5'b0) & (RD_n_WB == RS1_n_EX))
        ForwardA = 2'b01;
      else
        ForwardA = 2'b00;
        
      ForwardB=2'b00;
    end
      else begin
        ForwardA=2'b00;
        ForwardB=2'b00;
        end
  end
endmodule