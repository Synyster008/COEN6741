module register (clock, reset, source1, source2, destination, reg1, reg2, write_value, write_back);
    input clock, reset, write_back;
    input [4:0] source1, source2, destination;
    input [31:0] write_value;
    output reg1, reg2;
    reg [31:0] register_memory [0:31];
    integer i;

    always @ (posedge clock) begin
        if (reset) begin
        for (i = 0; i <= 31; i = i + 1)
            register_memory[i] <= 0;
            end

        else if (write_back) register_memory[destination] <= write_value;
        register_memory[0] <= 0;
    end

    assign reg1 = (register_memory[source1]);
    assign reg2 = (register_memory[source2]);
endmodule