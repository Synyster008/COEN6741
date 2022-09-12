module register (clock, source1, source2, destination, reg1, reg2, write_value1, write_value2, WRITEBACK);
    input clock, WRITEBACK;
    input [4:0] source1, source2, destination;
    input [31:0] write_value1, write_value2;
    output reg1, reg2;
    reg [31:0] register_memory [0:33];
    integer i;

    always @ (posedge clock) begin
        if (WRITEBACK == 2'b01) begin
            register_memory[destination] <= write_value1;
        end
        else if (WRITEBACK == 2'b11) begin
            register_memory[32] <= write_value1;
            register_memory[33] <= write_value2;
        end
        
    end

    assign reg1 = (register_memory[source1]);
    assign reg2 = (register_memory[source2]);
endmodule