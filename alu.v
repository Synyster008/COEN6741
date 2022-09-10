module alu (in1, in2, EXECUTE_command, out1, out2);

input [31:0] in1, in2;
input [3:0] EXECUTE_command;
output reg [31:0] out1, out2;

always @( * ) begin
    case (EXECUTE_command)
    4'b0001 : out1 <= in1 + in2; //add
    4'b0010 : out1 <= in1 - in2; //subtract
    4'b0011 : begin //division
         out1 <= in1 / in2; 
         out2 <= in1 % in2;
    end
    4'b0100 : out1 <= in1 < in2; //set less than immediate
    4'b0101 : out1 <= in2 << 16; //load upper immediate
    default: {out1, out2} <= 0;
    endcase
end

endmodule
