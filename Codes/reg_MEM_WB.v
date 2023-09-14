module reg_MEM_WB (clk, rst, W, mem_d_out, ALU_out, RD_n_out, W_out, mem_d_out_out, ALU_out_out, RD_n_out_out);
  input [63:0] mem_d_out, ALU_out;
  input [4:0] RD_n_out;
  input [2:0] W;
  input rst, clk;
  output [63:0] mem_d_out_out, ALU_out_out;
  output [4:0] RD_n_out_out;
  output [2:0] W_out;
  reg [63:0] mem_d_out_out, ALU_out_out;
  reg [4:0] RD_n_out_out;
  reg [2:0] W_out;
  
  always @(posedge clk)
  begin
    if (rst==1'b1)begin
       W_out <= 3'b0;
       ALU_out_out <= 64'b0;
       mem_d_out_out <= 64'b0;
       RD_n_out_out <= 5'b0;
    end
    else begin
       W_out <=W;
       ALU_out_out <= ALU_out;
       mem_d_out_out <= mem_d_out;
       RD_n_out_out <= RD_n_out;
    end
  end
  
  
endmodule




