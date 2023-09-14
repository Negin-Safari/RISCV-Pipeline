module reg_IF_ID (adr, inst, adder1_out, Flush, Write, clk, rst, adr_out, inst_out, adder1_out_out);
  input [63:0] adr, adder1_out;
  input [31:0] inst;
  input rst, Flush, Write, clk;
  output [63:0] adr_out, adder1_out_out;
  output [31:0] inst_out;
  reg [63:0] adr_out, adder1_out_out;
  reg [31:0] inst_out;
  
  always @(posedge clk)
  begin
    if (rst==1'b1)
      adr_out <= 64'd0;
    else if (Flush)
      adr_out <= 64'd0;
    else if(Write)
      adr_out <= adr_out;
    else
      adr_out <=adr; 
  end
  
  always @(posedge clk)
  begin
    if (rst==1'b1)
      inst_out <= 32'd0;
    else if (Flush)
      inst_out <= 32'd0;
    else if(Write)
      inst_out <= inst_out;
    else
      inst_out <=inst; 
  end
  
  always @(posedge clk)
  begin
    if (rst==1'b1)
      adder1_out_out <= 64'd0;
    else if (Flush)
      adder1_out_out <= 64'd0;
    else if(Write)
      adder1_out_out <= adder1_out_out;
    else
      adder1_out_out <=adder1_out; 
  end
  
endmodule

