module EXE_stage (clock2, input1_select, input2_select, store_select, input1, input2, result_forwarding_MEMORY, result_forwarding_WRITEBACK, result_ALU1, result_ALU2, store_input, store_output, EXECUTE_command, 
    PC_EXECUTE, PC_MEMORY, MEMORY_READ_EXECUTE, MEMORY_WRITE_EXECUTE, MEMORY_READ_MEMORY, MEMORY_WRITE_MEMORY, WRITEBACK_EXECUTE, WRITEBACK_MEMORY, result_ALU1_MEMORY, result_ALU2_MEMORY, store_value_MEMORY, 
    destination_EXECUTE, destination_MEMORY);

    input clock2, MEMORY_READ_EXECUTE, MEMORY_WRITE_EXECUTE; 
    input [1:0] input1_select, input2_select, store_select, WRITEBACK_EXECUTE;
    input [3:0] EXECUTE_command;
    input [4:0] destination_EXECUTE;
    input [31:0] input1, input2, result_forwarding_MEMORY, result_forwarding_WRITEBACK, store_input, PC_EXECUTE;
    output MEMORY_READ_MEMORY, MEMORY_WRITE_MEMORY;
    output [1:0] WRITEBACK_MEMORY;
    output [4:0] destination_MEMORY;
    output [31:0] result_ALU1, result_ALU2, store_output, PC_MEMORY, store_value_MEMORY, result_ALU1_MEMORY, result_ALU2_MEMORY;

    wire [31:0] ALU_input1, ALU_input2;

    mux3_1 #(.LENGTH(32)) mux_ALU_input1(
        .in1(input1),
        .in2(result_forwarding_MEMORY),
        .in3(result_forwarding_WRITEBACK),
        .select(input1_select),
        .out(ALU_input1)
    );

    mux3_1 #(.LENGTH(32)) mux_ALU_input2(
        .in1(input2),
        .in2(result_forwarding_MEMORY),
        .in3(result_forwarding_WRITEBACK),
        .select(input2_select),
        .out(ALU_input2)
    );

    mux3_1 #(.LENGTH(32)) mux_ALU_store(
        .in1(store_input),
        .in2(result_forwarding_MEMORY),
        .in3(result_forwarding_WRITEBACK),
        .select(store_select),
        .out(store_output)
    );

    alu ALU (
        .in1(ALU_input1),
        .in2(ALU_input2),
        .EXECUTE_command(EXECUTE_command),
        .out1(result_ALU1),
        .out2(result_ALU2)
    );

    EXE_MEM EXE_MEM_buffer(
        .clock2(clock2), 
        .PC_input(PC_EXECUTE),
        .PC_output(PC_MEMORY), 
        .store_input(store_output), 
        .store_output(store_value_MEMORY), 
        .result1_input(result_ALU1), 
        .result2_input(result_ALU2), 
        .result1_output(result_ALU1_MEMORY), 
        .result2_output(result_ALU2_MEMORY), 
        .destination_input(destination_EXECUTE), 
        .destination_output(destination_MEMORY),
        .MEMORY_READ_input(MEMORY_READ_EXECUTE), 
        .MEMORY_READ_output(MEMORY_READ_MEMORY), 
        .MEMORY_WRITE_input(MEMORY_WRITE_EXECUTE), 
        .MEMORY_WRITE_output(MEMORY_WRITE_MEMORY), 
        .WRITEBACK_input(WRITEBACK_EXECUTE), 
        .WRITEBACK_output(WRITEBACK_MEMORY)
    );

endmodule
