module cpu_tb();

 reg clk1, clk2;
 cpu  mips(clk1, clk2);
 
 initial begin 
    clk1 = 0;
    clk2 = 0;
    repeat(50) begin
    #50 clk1 = ~clk1;
    #50 clk2 = ~clk2;
    end
 end
 endmodule
