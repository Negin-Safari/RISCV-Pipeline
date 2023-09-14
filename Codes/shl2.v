module shl1 (d_in, d_out);
  input [63:0] d_in;
  output [63:0] d_out;
  
  assign d_out = d_in << 1;
  
endmodule
