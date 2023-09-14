module risc_tb;
  
  wire [63:0]  inst_adr;
  reg clk, rst;
  
  RISCV_Pipeline CPU(rst, clk, inst_adr);

  
  
  
  initial
  begin
    rst = 1'b1;
    clk = 1'b0;
    #20 rst = 1'b0;
    #10000 $stop;
  end
  
  always
  begin
    #8 clk = ~clk;
  end
  
endmodule
