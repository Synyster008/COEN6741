module mux #(parameter integer LENGTH) (in1, in2, in3, select, out);

input [1:0] select;
input [31:0] in1, in2, in3;
output [31:0] out;

assign out = (select == 2'd0) ? in1 : 
            (select == 2'd1)  ? in2 : in3;
endmodule
