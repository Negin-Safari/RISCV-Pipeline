module controller ( func_alu,opcode, EQ, IF_Flush, PCsrc, WME, jalr);
              
      input [3:0] func_alu;        
      input [6:0] opcode;
      input EQ;
      output IF_Flush, PCsrc, jalr;
      output [7:0] WME;
      //  Js,JALr_en ,lw,sw;
      reg     mem_to_reg, reg_write, mem_read, mem_write, alu_src, Js, jalr;        
      reg [1:0] alu_op;     
      reg branch;   
    
//    alu_controller ALU_CTRL(alu_op, func_alu, operation);
    
    always @(opcode,func_alu)
    begin
      {alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op, Js, jalr} = 10'd0;
      case (opcode)
        // RType instructions
        7'b0110011 : {reg_write,alu_op} = 3'b110;   
        // Load Double  (ld) instruction           
        7'b0000011 :begin
        if(func_alu[2:0]==3'b011)
         {alu_src, mem_to_reg, reg_write, mem_read} = 4'b1111;  //lw pak shod
     //  else if(func_alu[2:0]==3'b010)
//         {alu_src, mem_to_reg, reg_write, mem_read,lw}=5'b11111;
       end
        // Store Double (sd) instruction
        7'b0100011 :begin
        if(func_alu[2:0]==3'b111)
         {alu_src, mem_write} = 2'b11; //sw pak shod
       //else if(func_alu[2:0]==3'b010)
//         {alu_src, mem_write,sw} = 3'b111;
        end                              
        // Branch on equal (beq) instruction
        7'b1100011 : {branch, alu_op} = 3'b101; 
        // immediate type (addi , slti) instruction
        7'b0010011: {reg_write, alu_src, alu_op} = 4'b1111;      
        // JALr 
        7'b1100111: {reg_write,jalr,Js} = 3'b111;
        // JAL
        7'b1101111: {reg_write,Js} = 2'b11;   
      endcase
    end
    
    assign PCsrc = (branch & EQ) | Js;
    assign IF_Flush = (branch & EQ) | Js;
    assign WME = {Js, reg_write, mem_to_reg, mem_read, mem_write, alu_op, alu_src};    
  
endmodule
