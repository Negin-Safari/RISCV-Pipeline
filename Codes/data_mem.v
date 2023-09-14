module data_mem (adr, d_in, mrd, mwr, clk, d_out);
  input [63:0] adr;
  input [63:0] d_in;
  input mrd, mwr, clk;
  output [63:0] d_out;
  wire [63:0] index, min;  
  reg [7:0] mem[0:65535];
  
  assign min = {mem[2007], mem[2006], mem[2005], mem[2004],mem[2003], mem[2002], mem[2001], mem[2000]};
  assign index = {mem[2015], mem[2014], mem[2013], mem[2012],mem[2011], mem[2010], mem[2009], mem[2008]};
  
  initial
  begin
//    {mem[1007], mem[1006], mem[1005], mem[1004],mem[1003], mem[1002], mem[1001], mem[1000]} = 64'd8;    //0
//    {mem[1015], mem[1014], mem[1013], mem[1012],mem[1011], mem[1010], mem[1009], mem[1008]} = 64'd111;  //1
//    {mem[1023], mem[1022], mem[1021], mem[1020],mem[1019], mem[1018], mem[1017], mem[1016]} = 64'd11;   //2
//    {mem[1031], mem[1030], mem[1029], mem[1028],mem[1027], mem[1026], mem[1025], mem[1024]} = 64'd5;    //3
//    {mem[1039], mem[1038], mem[1037], mem[1036],mem[1035], mem[1034], mem[1033], mem[1032]} = 64'd4;    //4
//    {mem[1047], mem[1046], mem[1045], mem[1044],mem[1043], mem[1042], mem[1041], mem[1040]} = 64'd5;    //5
//    {mem[1055], mem[1054], mem[1053], mem[1052],mem[1051], mem[1050], mem[1049], mem[1048]} = 64'd6;    //6
//    {mem[1063], mem[1062], mem[1061], mem[1060],mem[1059], mem[1058], mem[1057], mem[1056]} = 64'd7;    //7
//    {mem[1071], mem[1070], mem[1069], mem[1068],mem[1067], mem[1066], mem[1065], mem[1064]} = 64'd7;    //8
//    {mem[1079], mem[1078], mem[1077], mem[1076],mem[1075], mem[1074], mem[1073], mem[1072]} = 64'd3;    //9
//    {mem[1087], mem[1086], mem[1085], mem[1084],mem[1083], mem[1082], mem[1081], mem[1080]} = 64'd101;   //10
//    {mem[1095], mem[1094], mem[1093], mem[1092],mem[1091], mem[1090], mem[1089], mem[1088]} = 64'd11;   //11
//    {mem[1103], mem[1102], mem[1101], mem[1100],mem[1099], mem[1098], mem[1097], mem[1096]} = 64'd12;   //12
//    {mem[1111], mem[1110], mem[1109], mem[1108],mem[1107], mem[1106], mem[1105], mem[1104]} = 64'd13;   //13
//    {mem[1119], mem[1118], mem[1117], mem[1116],mem[1115], mem[1114], mem[1113], mem[1112]} = 64'd5;   //14
//    {mem[1127], mem[1126], mem[1125], mem[1124],mem[1123], mem[1122], mem[1121], mem[1120]} = 64'd14;   //15
//    {mem[1135], mem[1134], mem[1133], mem[1132],mem[1131], mem[1130], mem[1129], mem[1128]} = 64'd14;   //16
//    {mem[1143], mem[1142], mem[1141], mem[1140],mem[1139], mem[1138], mem[1137], mem[1136]} = 64'd11;   //17
//    {mem[1151], mem[1150], mem[1149], mem[1148],mem[1147], mem[1146], mem[1145], mem[1144]} = 64'd11;   //18
//    {mem[1159], mem[1158], mem[1157], mem[1156],mem[1155], mem[1154], mem[1153], mem[1152]} = 64'd11; //19
//    {mem[1507], mem[1506], mem[1505], mem[1504],mem[1503], mem[1502], mem[1501], mem[1500]} = {32'd50,32'd12};
  $readmemb( "DATA.mem", mem );
  end
  

 
  always @(posedge clk)
    if (mwr==1'b1)
      {mem[adr+7], mem[adr+6], mem[adr+5], mem[adr+4],mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = d_in;
  
  assign d_out = (mrd==1'b1) ? {mem[adr+7], mem[adr+6], mem[adr+5], mem[adr+4],mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 64'd0;
  
endmodule   
