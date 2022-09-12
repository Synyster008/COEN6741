module MEM_stage (clock1, clock2, result_ALU1, store_input, memory_out, MEMORY_READ, MEMORY_WRITE);

    input clock1, clock2, MEMORY_READ, MEMORY_WRITE;
    input [31:0] result_ALU1, store_input;
    output [31:0] memory_out;

    data_memory data_memory(
        .clock1 (clock1), 
        .clock2 (clock2), 
        .address (result_ALU1), 
        .data_input (store_input), 
        .data_output (memory_out), 
        .MEMORY_READ (MEMORY_READ), 
        .MEMORY_WRITE (MEMORY_WRITE)
    );


endmodule
