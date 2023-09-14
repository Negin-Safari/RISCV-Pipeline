module mux4to1_64b (i0, i1, i2, i3, sel, y);
  input [63:0] i0, i1, i2, i3;
  input [1:0] sel;
  output [63:0] y;
  
  assign y = (sel==2'b00) ? i0 :
             (sel==2'b01) ? i1 :
             (sel ==2'b10)? i2 : i3; 
  
endmodule






