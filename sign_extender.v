module signExtend (in, out, sign_check);

  input sign_check;
  input [15:0] in;
  output reg [31:0] out;
  
  always @(*) begin

  if (sign_check) begin
    out = {16'b0000000000000000,in};
  end
  
  else begin
    out = (in[15] == 1) ? {16'b1111111111111111, in} : {16'b0000000000000000, in};
  end 
  end
endmodule 