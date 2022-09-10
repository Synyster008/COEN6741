// Adder Module

module adder(in1, in2, out);

  input [31:0] in1, in2; //Defining Input Register size
  output [31:0] out; // Defining Input Register size

assign out = in1 +in2;

endmodule
