module hazard_detector(immediate_check, store_check, source1_INSTRUCTION_DECODE, source2_INSTRUCTION_DECODE, destination_EXECUTE, destination_MEMORY, hazard, WRITEBACK_EXECUTE, WRITEBACK_MEMORY, MEMORY_READ_EXECUTE,
 branch_command, forward);
    input  MEMORY_READ_EXECUTE, forward, immediate_check, store_check;
    input [1:0] WRITEBACK_EXECUTE, WRITEBACK_MEMORY, branch_command;
    input [4:0] source1_INSTRUCTION_DECODE, source2_INSTRUCTION_DECODE, destination_EXECUTE, destination_MEMORY;
    output hazard;

    wire source2_check, execute_hazard, memory_hazard, overall_hazard, branch_check, writeback_EXECUTE, writeback_MEMORY;

    assign source2_check = immediate_check || store_check;
    assign writeback_EXECUTE = (WRITEBACK_EXECUTE) ? 1 : 0;
    assign writeback_MEMORY = (WRITEBACK_MEMORY) ? 1 : 0;
    
    assign execute_hazard = writeback_EXECUTE && (source1_INSTRUCTION_DECODE == destination_EXECUTE || (source2_check && source2_INSTRUCTION_DECODE == destination_EXECUTE));
    assign memory_hazard = writeback_MEMORY && (source1_INSTRUCTION_DECODE == destination_MEMORY || (source2_check && source1_INSTRUCTION_DECODE == destination_MEMORY));

    assign overall_hazard = execute_hazard || memory_hazard;
    assign branch_check = (branch_command == 2'b10 || branch_command == 2'b11);

    assign hazard = forward ? overall_hazard : (branch_check && overall_hazard) || (memory_hazard && MEMORY_READ_EXECUTE); 
    // check if forwarding is active, if active check for memory/execute hazard,
    // if not check if its a branch and has any of the hazards or, if its a memory read and has a memory hazard to prevent RAW hazard 
endmodule
