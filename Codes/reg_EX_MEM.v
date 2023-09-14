module reg_EX_MEM (clk, rst, WM, alu_result, mux4_out, RD_n, WM_out, alu_result_out, mux4_out_out, RD_n_out);
  input [63:0] alu_result, mux4_out;
  input [4:0] RD_n;
  input [4:0] WM;
  input rst, clk;
  output [63:0] alu_result_out, mux4_out_out;
  output [4:0] RD_n_out;
  output [4:0] WM_out;
  reg [63:0] alu_result_out, mux4_out_out;
  reg [4:0] RD_n_out;
  reg [4:0] WM_out;
  
  always @(posedge clk)
  begin
    if (rst==1'b1)begin
       WM_out <= 5'b0;
       alu_result_out <= 64'b0;
       mux4_out_out <= 64'b0;
       RD_n_out <= 5'b0;
    end
    else begin
       WM_out <=WM;
       alu_result_out <= alu_result;
       mux4_out_out <= mux4_out;
       RD_n_out <= RD_n;
    end
  end
  
  
endmodule






