module alu_tb();

reg [31:0] in1, in2;
reg [3:0] command;
wire  [31:0] out;

alu alu_test(in1, in2, command, out);

initial begin
   assign in1 = 32'h8888;
   assign in2 = 32'h2222;
   assign command = 4'b1010;
   
end


endmodule