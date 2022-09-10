// ALU Module 

module alu (in1, in2, EXECUTE_command, out);

    input [31:0] in1, in2; // 32 bit Input Register size
    input [3:0] EXECUTE_command; // 4 bit Execution Command Size
    output reg [31:0] out; // 32 bit Output Register size

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
