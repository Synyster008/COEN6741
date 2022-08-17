module alu (in1, in2, command, out);

input [31:0] in1, in2;
input [3:0] command;
output reg [31:0] out;

always @( * ) begin
    case (command)
    4'b1010 : out <= in1 / in2; //div
    4'b1000 : out <= in1 + in2; //addi
    4'b0001 : out <= in1 + in2; //addu
    4'b1011 : out <= in1 < in2; //slti
    default out <= 0;
    endcase
end

endmodule
