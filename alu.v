module alu (in1, in2, EXECUTE_command, out);

input [31:0] in1, in2;
input [3:0] EXECUTE_command;
output reg [31:0] out;

always @( * ) begin
    case (EXECUTE_command)
    4'b0001 : out <= in1 + in2; //addition 
    4'b0010 : out <= in1 - in2; //subtraction
    4'b0011 : out <= in1 / in2; //division
    4'b0100 : out <= in1 < in2; //set less than immediate
    4'b0101 : out <= in2 << 16; //load upper immediate
    default out <= 0;
    endcase
end

endmodule
