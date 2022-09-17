module mux3_1 #(parameter integer LENGTH) (in1, in2, in3, select, out);

input [1:0] select;
input [LENGTH-1:0] in1, in2, in3;
output reg [LENGTH-1:0] out;

always @(*) begin
    case(select)
    2'b00: out <= in1;
    2'b01: out <= in2;
    2'b10: out <= in3;
    default: out = 0;
    endcase
end


endmodule
