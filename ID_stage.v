module ID_stage (clock1, hazard, immediate_check, store_check, instruction_ID, value1_ID, value2_ID, value1_EXECUTE, value2_EXECUTE, source1_address, source2_address1, source2_address2, source1_EXECUTE, 
source2_EXECUTE, destination_WRITEBACK, destination_address, destination_EXECUTE, MEMORY_READ, MEMORY_READ_EXECUTE, MEMORY_WRITE, MEMORY_WRITE_EXECUTE, WRITEBACK, WRITEBACK_EXECUTE, EXECUTE_command, 
EXECUTE_command_EXECUTE, branch_command, branch, branch_EXECUTE, PC_ID, PC_EXECUTE);
    
    input clock1, hazard;
    input [4:0] destination_WRITEBACK;
    input [31:0] PC_ID, instruction_ID;
    output branch, branch_EXECUTE, MEMORY_READ, MEMORY_READ_EXECUTE, MEMORY_WRITE, MEMORY_WRITE_EXECUTE, immediate_check, store_check;
    output [1:0] WRITEBACK, WRITEBACK_EXECUTE, branch_command;
    output [3:0] EXECUTE_command, EXECUTE_command_EXECUTE;
    output [4:0] source1_address, source2_address1, source2_address2, source1_EXECUTE, source2_EXECUTE, destination_address, destination_EXECUTE;
    output [31:0] value1_ID, value2_ID, value1_EXECUTE, value2_EXECUTE, PC_EXECUTE;

    wire condition_control, condition_check, sign;
    wire [1:0] branch_condition;
    wire immediate, store;
    wire [5:0] opcode;
    wire [31:0] sign_extended, value2;

    assign opcode = instruction_ID[31:26];

    control_unit control(
       .opcode(opcode), 
       .branch(condition_control), 
       .EXECUTE_command(EXECUTE_command), 
       .branch_command(branch_condition), 
       .immediate_check(immediate), 
       .store_check(store),
       .sign_check(sign), 
       .WRITEBACK(WRITEBACK), 
       .MEMORY_READ(MEMORY_READ), 
       .MEMORY_WRITE(MEMORY_WRITE), 
       .hazard(hazard)
    );

    mux2_1 #(.LENGTH(5)) mux_source2( //check if operation is LOAD/STORE or Register operation
        .in1(instruction_ID[15:11]),
        .in2(instruction_ID[25:21]),
        .select(store),
        .out(source2_address1)
    );

    assign source1_address = instruction_ID [20:16];

    register register_bank(
        .clock(clock1), 
        .source1(source1_address),
        .source2(source2_address1), 
        .destination(destination_WRITEBACK), 
        .reg1(value1_ID), 
        .reg2(value2_ID), 
        .write_value1(32'b0), 
        .write_value2(32'b0), 
        .WRITEBACK(2'b0)                        // because in ID_stage we are only reading the value from the register, the writing will be done in writeback stage
    );

    mux2_1 #(.LENGTH(5)) mux_source2_immediate( //check if the operation is immediate or Register
        .in1(instruction_ID[15:11]),
        .in2(5'b0),
        .select(immediate),
        .out(source2_address2)
    );

    sign_extender sign_extender(
        .in(instruction_ID[15:0]),
        .sign_check(sign),
        .out(sign_extended)
    );

    mux2_1 #(.LENGTH(32)) mux_output2( //if operation is immediate, pass the signed value
        .in1(value2_ID),
        .in2(sign_extended),
        .select(immediate),
        .out(value2)
    );

    condition_checker condition_checker(
        .in1(value1_ID),
        .in2(value2_ID),                    // for BEQ, which takes two register values, so ID_value2 is used instead of value2
        .branch_command(branch_command),
        .condition(condition_check)
    );

    assign branch = condition_control && condition_check;
    assign immediate_check = immediate;
    assign store_check = store;
    assign branch_command = branch_condition;
    assign destination_address = instruction_ID [25:21];

    ID_EXE ID_EXE_buffer(
        .clock1(clock1), 
        .PC_input(PC_ID), 
        .PC_output(PC_EXECUTE), 
        .source1_input(source1_address), 
        .source2_input(source2_address2), 
        .source1_output(source1_EXECUTE), 
        .source2_output(source2_EXECUTE), 
        .destination_input(destination_address), 
        .destination_output(destination_EXECUTE),
        .branch_input(branch), 
        .branch_output(branch_EXECUTE), 
        .store_input(store_check), 
        .store_output(store_EXECUTE), 
        .value1_input(value1_ID),
        .value2_input(value2), 
        .value1_output(value1_EXECUTE), 
        .value2_output(value2_EXECUTE), 
        .EXECUTE_command_input(EXECUTE_command), 
        .EXECUTE_command_output(EXECUTE_command_EXECUTE), 
        .MEMORY_READ_input(MEMORY_READ), 
        .MEMORY_READ_output(MEMORY_READ_EXECUTE), 
        .MEMORY_WRITE_input(MEMORY_WRITE), 
        .MEMORY_WRITE_output(MEMORY_WRITE_EXECUTE), 
        .WRITEBACK_input(WRITEBACK), 
        .WRITEBACK_output(WRITEBACK_EXECUTE)
    );


endmodule
