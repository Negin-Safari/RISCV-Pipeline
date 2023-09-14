module alu_controller (alu_op, func_alu, operation);
  input [1:0] alu_op;
  input [3:0] func_alu;
  output [3:0] operation;
  reg [3:0] operation;
  ////////////////////
  always @(alu_op, func_alu)
  begin
    operation = 4'b0000;
    if (alu_op == 2'b00)        // ld or sd  
      operation = 4'b0010;
    else if (alu_op == 2'b01)   // beq
      operation = 4'b0110;
    else if(alu_op ==2'b10)
      begin
        case (func_alu)
          4'b0000: operation = 4'b0010;  // add
          4'b1000: operation = 4'b0110;  // sub
          4'b0111: operation = 4'b0000;  // and
          4'b0110: operation = 4'b0001;  // or
          4'b0010: operation = 4'b0111;  // slt 
          4'b0001: operation = 4'b0011; //sll
          4'b0101: operation = 4'b0100; //srl
          default:   operation = 4'b0000;
        endcase
      end
      
    else  // i type
     begin
       case (func_alu[2:0])
       3'b010:   operation =4'b0111; //slti
       3'b000:   operation =4'b0010; //addi
     endcase
     end
      
     
  end
  
endmodule
