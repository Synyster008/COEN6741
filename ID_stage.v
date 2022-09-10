module ID_stage (clock1, hazard, immediate_check, store_check, instruction, input_value1, input_value2, output_value1, output_value2, source1_address, source2_address, destination_address,
 MEMORY_READ, MEMORY_WRITE, WRITEBACK, EXECUTE_command, branch_command, branch);
    
    input clock1, hazard;
    input [31:0] input_value1, input_value2, instruction;
    output branch, MEMORY_READ, MEMORY_WRITE, immediate_check, store_check;
    output [1:0] WRITEBACK, branch_command;
    output [3:0] EXECUTE_command;
    output [4:0] source1_address, source2_address, destination_address;
    output [31:0] output_value1, output_value2;

    wire condition_control, condition_check, sign;
    wire [1:0] branch_condition;
    wire immediate, store;
    wire [31:0] sign_extended;

    control_unit control(
       .opcode(instruction[31:26]), 
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

    mux #(.LENGTH(5)) mux_source2(
        .in1(instruction[15:11]),
        .in2(instruction[25:21]),
        .in3(5'b0),
        .select(store),
        .out(source2_address)
    );

    mux #(.LENGTH(5)) mux_source2_immediate( //check if rt is passed or the operation is immediate
        .in1(instruction[15:11]),
        .in2(5'b0),
        .in3(5'b0),
        .select(immediate),
        .out(destination_address)
    );

    mux #(.LENGTH(32)) mux_output2( //if operation is immediate, pass the signed value
        .in1(input_value2),
        .in2(sign_extended),
        .in3(32'b0),
        .select(immediate),
        .out(output_value2)
    );

    sign_extender sign_extender(
        .in(instruction[15:0]),
        .sign_check(sign),
        .out(sign_extended)
    );

    condition_checker condition_checker(
        .in1(input_value1),
        .in2(input_value2),
        .branch_command(branch_command),
        .condition(condition_check)
    );

    assign branch = condition_control && condition_check;
    assign output_value1 = input_value1;
    assign source1_address = instruction [20:16];
    assign immediate_check = immediate;
    assign store_check = store;
    assign branch_command = branch_condition;

endmodule
