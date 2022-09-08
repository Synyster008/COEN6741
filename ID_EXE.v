module ID_EXE (clock, PC_input, PC_output, source1_input, source2_input, source1_output, source2_output, destination_input, destination_output, branch_input, branch_output, store_input, store_output, value1_input,
    value2_input, value1_output, value2_output, EXECUTE_command_input, EXECUTE_command_output, MEMORY_READ_input, MEMORY_READ_output, MEMORY_WRITE_input, MEMORY_WRITE_output, WRITEBACK_input, WRITEBACK_output);
    
    input clock, MEMORY_READ_input, MEMORY_WRITE_input, WRITEBACK_input, branch_input;
    input [3:0] EXECUTE_command_input;
    input [4:0] source1_input, source2_input, destination_input;
    input [31:0] store_input, value1_input, value2_input, PC_input;
    
    output reg MEMORY_READ_output, MEMORY_WRITE_output, WRITEBACK_output, branch_output;
    output reg [3:0] EXECUTE_command_output;
    output reg [4:0] source1_output, source2_output, destination_output;
    output reg [31:0] store_output, value1_output, value2_output, PC_output;

    always @(posedge clock) begin
        MEMORY_READ_output <= MEMORY_READ_input;
        MEMORY_WRITE_output <= MEMORY_WRITE_input;
        WRITEBACK_output <= WRITEBACK_input;
        branch_output <= branch_input;
        EXECUTE_command_output <= EXECUTE_command_input;
        source1_output <= source1_input;
        source2_output <= source2_input;
        destination_output <= destination_input;
        store_output <= store_input;
        value1_output <= value1_input;
        value2_output <= value2_input;
        PC_output <= PC_input;
    end

endmodule
