module adder_64b (a , b, cin, cout, sum);
  input [63:0] a, b;
  input cin;
  output cout;
  output [63:0] sum;
  
  assign {cout, sum} = a + b + cin;
  
endmodule
