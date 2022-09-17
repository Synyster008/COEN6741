module mux_tb();

    reg [4:0] in1, in2, in3;
    reg [1:0] select;
    wire [4:0] out;

    mux  #(.LENGTH(5)) mux_test (in1, in2, in3, select, out);

    initial begin
        assign in1 = 5'b01101;
        assign in2 = 5'b10010;
        assign in3 = 5'b10101;
        assign select = 2;
    end

    endmodule
     
