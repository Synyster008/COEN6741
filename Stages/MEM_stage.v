module MEM_stage (clock1, clock2, result_ALU1_MEMORY, result_ALU2_MEMORY, result_ALU1_WRITEBACK, result_ALU2_WRITEBACK, store_input, memory_out_MEMORY, memory_out_WRITEBACK, MEMORY_READ, MEMORY_WRITE,
    MEMORY_READ_WRITEBACK, WRITEBACK_MEMORY, WRITEBACK_WRITEBACK, destination_MEMORY, destination_WRITEBACK);

    input clock1, clock2, MEMORY_READ, MEMORY_WRITE; 
    input [1:0] WRITEBACK_MEMORY;
    input [4:0] destination_MEMORY;
    input [31:0] result_ALU1_MEMORY, result_ALU2_MEMORY, store_input;
    output MEMORY_READ_WRITEBACK;
    output [1:0] WRITEBACK_WRITEBACK;
    output [4:0] destination_WRITEBACK;
    output [31:0] memory_out_MEMORY, memory_out_WRITEBACK, result_ALU1_WRITEBACK, result_ALU2_WRITEBACK;

    data_memory data_memory(
        .clock1 (clock1), 
        .clock2 (clock2), 
        .address (result_ALU1_MEMORY), 
        .data_input (store_input), 
        .data_output (memory_out_MEMORY), 
        .MEMORY_READ (MEMORY_READ), 
        .MEMORY_WRITE (MEMORY_WRITE)
    );

    MEM_WB MEM_WB_buffer(
        .clock2(clock2), 
        .destination_input(destination_MEMORY), 
        .destination_output(destination_WRITEBACK), 
        .result_input1(result_ALU1_MEMORY), 
        .result_input2(result_ALU2_MEMORY), 
        .result_output1(result_ALU1_WRITEBACK), 
        .result_output2(result_ALU2_WRITEBACK), 
        .loadvalue_input(memory_out_MEMORY), 
        .loadvalue_output(memory_out_WRITEBACK), 
        .MEMORY_READ_input(MEMORY_READ), 
        .MEMORY_READ_output(MEMORY_READ_WRITEBACK), 
        .WRITEBACK_input(WRITEBACK_MEMORY), 
        .WRITEBACK_output(WRITEBACK_WRITEBACK)
    );

endmodule
