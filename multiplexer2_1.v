module mux2_1 #(parameter integer LENGTH) (in1, in2, select, out);

input select;
input [LENGTH-1:0] in1, in2;
output reg [LENGTH-1:0] out;

always @(*) begin
    case(select)
    0: out <= in1;
    1: out <= in2;
    default: out = 0;
    endcase
end


endmodule
