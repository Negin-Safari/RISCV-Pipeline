module datapath ( clk, rst, WME, PcSrc, PcWrite, IF_Flush, IF_ID_Write, stall_en, ForwardA, ForwardB, 
                alu_ctrl,      EQ, Regwrite_MEM, Regwrite_WB, mem_read, func_alu_out, alu_op, RD_n_MEM, RD_n_WB, 
                RS1_n_EX, RS2_n_EX, RD_old_EX, RS1_new_ID, RS2_new_ID, opcode, adr, func_alu, opcode_new, jalr
                 );
  input [7:0] WME;
  input clk, rst, PcSrc, PcWrite, IF_Flush, IF_ID_Write, stall_en, jalr;
  input [1:0] ForwardA, ForwardB;
  input [3:0] alu_ctrl;
  output EQ, Regwrite_MEM, Regwrite_WB,mem_read;
  output [3:0] func_alu_out;
  output [3:0] func_alu;
  output [1:0] alu_op;
  output [4:0] RD_n_MEM;
  output [4:0] RD_n_WB;
  output [4:0] RS1_n_EX, RS2_n_EX,RD_old_EX;
  output [4:0] RS1_new_ID, RS2_new_ID; 
  output [6:0] opcode;
  output [6:0] opcode_new;
  
  
  wire [63:0] adder1_out;
  wire [63:0] adder2_out;
  wire [63:0] mux1_out;
  wire [7:0] mux2_out;
  wire [63:0] mux3_out;
  wire [63:0] mux4_out;
  wire [63:0] mux5_out;
  wire [63:0] mux6_out;
  wire [63:0] mux7_out;
  wire [63:0] mux8_out;
  wire [63:0] mux9_out;
  wire [63:0] mux10_out;
  wire [63:0] mux11_out;
  wire [63:0] pc_out;
  wire [31:0] inst_mem;
  output [63:0] adr;
  wire [31:0] inst;
  wire [63:0] read_data1;
  wire [63:0] read_data2;
  wire [63:0] Imm_Gen_out;
  wire [63:0] shl1_out;
  wire [7:0] WME_out;
  wire [63:0] read_data1_out;
  wire [63:0] read_data2_out;
  wire [63:0] ALU_result;
  wire [63:0] ALU_out;
  wire [63:0] Imm_EX;
  wire [4:0] RS1_n;
  wire [4:0] RS2_n;
  wire [4:0] RD_n;
  wire [4:0] WM_out;
  wire [4:0] RD_n_out;
  wire [63:0] mem_d_in;
  wire [63:0] mem_d_out;
  wire [2:0] W;
  wire [63:0] mem_d_out_out;
  wire [63:0] ALU_out_out;
  wire [4:0] RD_n_out_out;
  wire [1:0] beq_FA, beq_FB;
  wire Pcwrite_beq, IF_ID_Write_beq, stall_en_beq;
  wire [63:0] adder1_out_out;
  wire [63:0] return_adr;
  wire [63:0] adder3_out;
  
  mux2to1_64b MUX1(adder1_out, adder2_out, PcSrc, mux1_out); 
  
  reg_64b PC(mux1_out, rst, (PcWrite & Pcwrite_beq) , clk, pc_out);
  
  adder_64b ADD1(pc_out , 64'd4, 1'b0, ,adder1_out);
  
  inst_mem  IM(pc_out, inst_mem);
  
  reg_IF_ID IFID(pc_out, inst_mem, adder1_out, IF_Flush, (IF_ID_Write | IF_ID_Write_beq), clk, rst, adr, inst, adder1_out_out);
  
  mux2to1_64b MUX10(mux6_out, return_adr, W[2], mux10_out);
  
  reg_64b REGADR(adder1_out_out, rst, WME[7], clk, return_adr);
  
  reg_file  RF(mux10_out, inst[19:15], inst[24:20], RD_n_out_out, W[1], rst, clk, read_data1, read_data2);
  
  adder_64b ADD3(Imm_Gen_out, read_data1, 1'b0, ,adder3_out);
  
  Imm_Gen IMM_GEN(inst, Imm_Gen_out);
  
  mux2to1_64b MUX11(Imm_Gen_out, adder3_out, jalr, mux11_out);
  
  shl1 SHL1(mux11_out, shl1_out);
  
  adder_64b ADD2(shl1_out, adr, 1'b0, , adder2_out);
  
  mux2to1_8b MUX2(WME, 8'b0, (stall_en | stall_en_beq), mux2_out);
  
  BEQ_Forward_unit BEQF(opcode, WME_out[4], WM_out[1], inst[19:15], inst[24:20], RD_n_out_out, 
                        RD_n_out, RD_n, beq_FA, beq_FB, Pcwrite_beq, IF_ID_Write_beq, stall_en_beq);
  
  mux4to1_64b MUX7(read_data1, mux6_out,ALU_out, ALU_result, beq_FA, mux7_out);
  
  mux4to1_64b MUX8(read_data2, mux6_out,ALU_out, ALU_result, beq_FB, mux8_out);
  
  EQ_Detect EQ_D(mux7_out, mux8_out, EQ);
  
  assign func_alu={inst[30],inst[14:12]};
  
 reg_ID_EX IDEX(opcode, func_alu, mux2_out, read_data1, read_data2, Imm_Gen_out, inst[19:15], inst[24:20], inst[11:7], clk, rst, 
                  WME_out, read_data1_out, read_data2_out, Imm_EX, RS1_n, RS2_n, RD_n, func_alu_out, opcode_new);
                
                
  mux3to1_64b MUX3(read_data1_out, mux6_out, ALU_out, ForwardA, mux3_out);
  
  mux3to1_64b MUX4(mux5_out, mux6_out, ALU_out, ForwardB, mux4_out);
  
  mux2to1_64b MUX5(read_data2_out, Imm_EX, WME_out[0], mux5_out);
  
  alu ALU(mux3_out, mux4_out, alu_ctrl, ALU_result, );
  
  assign alu_op = WME_out[2:1];
  assign RD_n_MEM = RD_n_out;
  assign RD_n_WB = RD_n_out_out;
  assign RS1_n_EX = RS1_n;
  assign RS2_n_EX = RS2_n;  
  assign Regwrite_MEM = WM_out[3];
  assign Regwrite_WB = W[1];
  
  mux3to1_64b MUX9(read_data2_out, mux6_out, ALU_out, ForwardB, mux9_out);
  
  reg_EX_MEM EXMEM(clk, rst, WME_out[7:3], ALU_result, mux9_out, RD_n, WM_out, ALU_out, mem_d_in, RD_n_out);
  
  data_mem DM(ALU_out, mem_d_in, WM_out[1], WM_out[0], clk, mem_d_out);
  
  reg_MEM_WB MEMWB(clk, rst, WM_out[4:2], mem_d_out, ALU_out, RD_n_out, W, mem_d_out_out, ALU_out_out, RD_n_out_out);
  
  mux2to1_64b MUX6(ALU_out_out, mem_d_out_out, W[0], mux6_out);
  
  assign opcode=inst[6:0];
  assign mem_read = WME_out[4];
  assign RD_old_EX = RD_n;
  assign RS1_new_ID = inst[19:15];
  assign RS2_new_ID = inst[24:20];
  
  
endmodule
