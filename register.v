module register (clock, source1, source2, destination, reg1, reg2, write_value1, write_value2, WRITEBACK);
    input clock; 
    input [1:0] WRITEBACK;
    input [4:0] source1, source2, destination;
    input [31:0] write_value1, write_value2;
    output [31:0] reg1, reg2;
    reg [31:0] register_mem [0:33];

    integer i;

    initial begin
      for (i=0; i<= 33; i=i+1)
        register_mem[i]<= 0;
    end

    always @ (posedge clock) begin
        if (WRITEBACK == 2'b01) begin
            register_mem[destination] <= write_value1;
        end
        
        else if (WRITEBACK == 2'b11) begin
            register_mem[32] <= write_value1; // LO Register
            register_mem[33] <= write_value2; // HI Register
        end
        
    end

    assign reg1 = (register_mem[source1]);
    assign reg2 = (register_mem[source2]);
endmodule