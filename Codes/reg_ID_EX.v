module reg_ID_EX (opcode_new, func_alu, WBE, read_data1, read_data2, Imm, RS1_n, RS2_n, RD_n, clk, rst, 
                  WBE_out, read_data1_out, read_data2_out, Imm_out, RS1_n_out, RS2_n_out, RD_n_out, func_alu_out, opcode_new_out);
  input [63:0] read_data1, read_data2, Imm;
  input [6:0] opcode_new;
  input [7:0] WBE;
  input [4:0] RS1_n, RS2_n, RD_n;
  input [3:0] func_alu;
  input rst, clk;
  output [63:0] read_data1_out, read_data2_out, Imm_out;
  output [6:0]  opcode_new_out;
  output [7:0] WBE_out;
  output [4:0] RS1_n_out, RS2_n_out, RD_n_out;
  output [3:0] func_alu_out;
  reg [63:0] read_data1_out, read_data2_out, Imm_out;
  reg  [6:0] opcode_new_out;
  reg [7:0] WBE_out;
  reg [4:0] RS1_n_out, RS2_n_out, RD_n_out;
  reg [3:0] func_alu_out;
  
  always @(posedge clk)
  begin
    if (rst==1'b1)begin
       WBE_out <= 8'b0;
       read_data1_out <= 64'b0;
       read_data2_out <= 64'b0;
       Imm_out <= 64'b0;
       RS1_n_out <= 5'b0;
       RS2_n_out <= 5'b0;
       RD_n_out <= 5'b0;
       func_alu_out <=4'b0;
       opcode_new_out <= 7'b0;
    end
    else begin
      WBE_out <= WBE;
       read_data1_out <= read_data1;
       read_data2_out <= read_data2;
       Imm_out <= Imm;
       RS1_n_out <= RS1_n;
       RS2_n_out <= RS2_n;
       RD_n_out <= RD_n;
       func_alu_out <=func_alu;
       opcode_new_out <= opcode_new;
    end
  end
  
  
endmodule


