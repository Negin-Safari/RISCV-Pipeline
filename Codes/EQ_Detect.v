module EQ_Detect(I0, I1, EQ);
  input[63:0] I0, I1;
  output EQ;
  assign EQ = (I0 == I1) ? 1'b1 : 1'b0;
endmodule