module cpu(input clk1, input clk2);

    wire clock1 = clk1; 
    wire clock2 = clk2;
    wire [31:0] PC_IF, PC_ID, PC_EXECUTE, PC_MEMORY;
    wire [31:0] instruction_IF, instruction_ID;
    wire [31:0] register1_ID, register2_ID, store_value_EXECUTE, store_value_EXECUTE_MEMORY, store_value_MEMORY;
    wire [31:0] value1_ID, value2_ID, value1_EXECUTE, value2_EXECUTE;
    wire [31:0] result_ALU1_EXECUTE, result_ALU2_EXECUTE, result_ALU1_MEMORY, result_ALU2_MEMORY, result_ALU1_WRITEBACK, result_ALU2_WRITEBACK;
    wire [31:0] memory_out_MEMORY, memory_out_WRITEBACK, result1_WRITEBACK, result2_WRITEBACK;
    wire [4:0] destination_EXECUTE, destination_MEMORY, destination_WRITEBACK;
    wire [4:0] source1_ID, source1_EXECUTE, source2_ID1, source2_ID2, source2_EXECUTE;
    wire [3:0] EXECUTE_command_ID, EXECUTE_command_EXECUTE;
    wire [1:0] source1_select, source2_select, store_select;
    wire [1:0] branch_command;
    wire branch_ID, flush, branch_EXECUTE;
    wire MEMORY_READ_ID, MEMORY_READ_EXECUTE, MEMORY_READ_MEMORY, MEMORY_READ_WRITEBACK, MEMORY_WRITE_ID, MEMORY_WRITE_EXECUTE, MEMORY_WRITE_MEMORY;
    wire WRITEBACK_ID, WRITEBACK_EXECUTE, WRITEBACK_MEMORY, WRITEBACK_WRITEBACK;
    wire hazard, immediate_check, store_check;

    IF_stage INSTRUCTIONFETCH_stage(
        .clock1(clock1),
        .clock2(clock2), 
        .stall(hazard), 
        .branch_check(branch_ID), 
        .branch_address(value2_ID), 
        .PC(PC_IF), 
        .instruction(instruction_IF)
    );

    IF_ID IF_ID_buffer(
        .clock2(clock2), 
        .flush(flush),
        .stall(hazard), 
        .PC_input(PC_IF), 
        .PC_output(PC_ID), 
        .instruction_input(instruction_IF), 
        .instruction_output(instruction_ID)
    );

    ID_stage INSTRUCTIONDECODE_stage(
        .clock1(clock1), 
        .hazard(hazard), 
        .immediate_check(immediate_check), 
        .store_check(store_check), 
        .instruction(instruction_ID), 
        .input_value1(register1_ID), 
        .input_value2(register2_ID), 
        .output_value1(value1_ID), 
        .output_value2(value2_ID), 
        .source1_address(source1_ID), 
        .source2_address1(source2_ID1), 
        .source2_address2(source2_ID2),
        .MEMORY_READ(MEMORY_READ_ID), 
        .MEMORY_WRITE(MEMORY_WRITE_ID), 
        .WRITEBACK(WRITEBACK_ID), 
        .EXECUTE_command(EXECUTE_command_ID), 
        .branch_command(branch_command), 
        .branch(branch_ID)
    );

    register register(
        .clock(clock1), 
        .source1(source1_ID), 
        .source2(source2_ID1), 
        .destination(destination_WRITEBACK), 
        .reg1(register1_ID), 
        .reg2(register2_ID), 
        .write_value1(result_ALU1_WRITEBACK), 
        .write_value2(result_ALU2_WRITEBACK), 
        .WRITEBACK(WRITEBACK_WRITEBACK)
    );

    hazard_detector hazard_detector(
        .immediate_check(immediate_check), 
        .store_check(store_check), 
        .source1_INSTRUCTION_DECODE(source1_ID), 
        .source2_INSTRUCTION_DECODE(source2_ID1), 
        .destination_EXECUTE(destination_EXECUTE), 
        .destination_MEMORY(destination_MEMORY), 
        .hazard(hazard), 
        .writeback_EXECUTE(WRITEBACK_EXECUTE), 
        .writeback_MEMORY(writeback_MEMORY), 
        .MEMORY_READ_EXECUTE(MEMORY_READ_EXECUTE),
        .branch_command(branch_command), 
        .forward(forward)
    );

    ID_EXE ID_EXE_buffer(
        .clock1(clock1), 
        .PC_input(PC_ID), 
        .PC_output(PC_EXECUTE), 
        .source1_input(source1_ID), 
        .source2_input(source2_ID2), 
        .source1_output(source1_EXECUTE), 
        .source2_output(source2_EXECUTE), 
        .destination_input(instruction_ID[25:21]), 
        .destination_output(destination_EXECUTE), 
        .branch_input(branch_ID), 
        .branch_output(branch_EXECUTE), 
        .store_input(register2_ID), 
        .store_output(store_EXECUTE), 
        .value1_input(value1_ID),
        .value2_input(value2_ID), 
        .value1_output(value1_EXECUTE), 
        .value2_output(value2_EXECUTE), 
        .EXECUTE_command_input(EXECUTE_command_ID), 
        .EXECUTE_command_output(EXECUTE_command_EXECUTE), 
        .MEMORY_READ_input(MEMORY_READ_ID), 
        .MEMORY_READ_output(MEMORY_READ_EXECUTE), 
        .MEMORY_WRITE_input(MEMORY_WRITE_ID), 
        .MEMORY_WRITE_output(MEMORY_WRITE_EXECUTE), 
        .WRITEBACK_input(WRITEBACK_ID), 
        .WRITEBACK_output(WRITEBACK_EXECUTE)

    );

    EXE_stage EXECUTE_stage(
        .clock2(clock2), 
        .input1_select(source1_select), 
        .input2_select(source2_select), 
        .store_select(store_select), 
        .input1(value1_EXECUTE), 
        .input2(value2_EXECUTE), 
        .result_forwarding_MEMORY(result_ALU1_MEMORY), 
        .result_forwarding_WRITEBACK(result_ALU1_WRITEBACK), 
        .result_ALU1(result_ALU1_EXECUTE), 
        .result_ALU2(result_ALU2_EXECUTE), 
        .store_input(store_value_EXECUTE), 
        .store_output(store_value_EXECUTE_MEMORY), 
        .EXECUTE_command(EXECUTE_command_EXECUTE)
    );

    forwarding_unit forwarding_unit(
        .source1_EXECUTE(source1_EXECUTE), 
        .source2_EXECUTE(source2_EXECUTE), 
        .store_EXECUTE(destination_EXECUTE), 
        .destination_MEMORY(destination_MEMORY), 
        .destination_WRITEBACK(destination_WRITEBACK), 
        .writeback_MEMORY(WRITEBACK_MEMORY), 
        .writeback_WRITEBACK(WRITEBACK_WRITEBACK), 
        .source1_select(source1_select), 
        .source2_select(source2_select), 
        .store_select(store_select), 
        .forward(forward)
    );

    EXE_MEM EXE_MEM_buffer(
        .clock2(clock2), 
        .PC_input(PC_EXECUTE), 
        .PC_output(PC_MEMORY), 
        .store_input(store_value_EXECUTE_MEMORY), 
        .store_output(store_value_MEMORY), 
        .result1_input(result_ALU1_EXECUTE),
        .result2_input(result_ALU2_EXECUTE), 
        .result1_output(result_ALU1_MEMORY),
        .result2_output(result_ALU2_EXECUTE), 
        .destination_input(destination_EXECUTE), 
        .destination_output(destination_MEMORY),
        .MEMORY_READ_input(MEMORY_READ_EXECUTE), 
        .MEMORY_READ_output(MEMORY_READ_MEMORY), 
        .MEMORY_WRITE_input(MEMORY_WRITE_EXECUTE), 
        .MEMORY_WRITE_output(MEMORY_WRITE_MEMORY), 
        .WRITEBACK_input(WRITEBACK_EXECUTE), 
        .WRITEBACK_output(WRITEBACK_MEMORY)
    );

    MEM_stage MEMORY_stage(
        .clock1(clock1), 
        .clock2(clock2), 
        .result_ALU1(result_ALU1_MEMORY), 
        .store_input(store_value_MEMORY), 
        .memory_out(memory_out_MEMORY), 
        .MEMORY_READ(MEMORY_READ_MEMORY), 
        .MEMORY_WRITE(MEMORY_WRITE_MEMORY)
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
        .MEMORY_READ_input(MEMORY_READ_MEMORY), 
        .MEMORY_READ_output(MEMORY_READ_WRITEBACK), 
        .WRITEBACK_input(WRITEBACK_MEMORY), 
        .WRITEBACK_output(WRITEBACK_WRITEBACK)
    );

    WB_stage WRITEBACK_stage(
        .clock1 (clock1), 
        .MEMORY_READ(MEMORY_READ_WRITEBACK), 
        .memory_out(memory_out_WRITEBACK), 
        .result_ALU1(result1_WRITEBACK), 
        .result_ALU2(result_ALU2_WRITEBACK), 
        .result1(result1_WRITEBACK), 
        .result2(result2_WRITEBACK)
    );


    assign flush = branch_ID;

endmodule
