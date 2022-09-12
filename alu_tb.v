module alu_tb();

reg [31:0] in1, in2;
reg [3:0] command;
wire  [31:0] out1, out2;

alu alu_test(in1, in2, command, out1, out2);

initial begin
   assign in2 = 32'hffffffff;
   assign in1 = 32'h0002;
   assign command = 4'b0100;
end


endmodule