module hazard_tb();

    reg  MEMORY_READ_EXECUTE, forward, immediate_check, store_check;
    reg [1:0] WRITEBACK_EXECUTE, WRITEBACK_MEMORY, branch_command;
    reg [4:0] source1_INSTRUCTION_DECODE, source2_INSTRUCTION_DECODE, destination_EXECUTE, destination_MEMORY;
    
    
    wire hazard;

    hazard_detector hazard_detector_tb(
        .immediate_check(immediate_check), 
        .store_check(store_check), 
        .source1_INSTRUCTION_DECODE(source1_INSTRUCTION_DECODE), 
        .source2_INSTRUCTION_DECODE(source2_INSTRUCTION_DECODE), 
        .destination_EXECUTE(destination_EXECUTE), 
        .destination_MEMORY(destination_MEMORY), 
        .hazard(hazard), 
        .WRITEBACK_EXECUTE(WRITEBACK_EXECUTE), 
        .WRITEBACK_MEMORY(WRITEBACK_MEMORY), 
        .MEMORY_READ_EXECUTE(MEMORY_READ_EXECUTE),
        .branch_command(branch_command), 
        .forward(forward)
        );

    initial begin
        source1_INSTRUCTION_DECODE = 5'd5; 
        source2_INSTRUCTION_DECODE = 5'd6;
        destination_EXECUTE = 5'd5; 
        destination_MEMORY = 5'd7;
        branch_command = 2'b0;
        WRITEBACK_EXECUTE = 2'b0;
        WRITEBACK_MEMORY = 2'b0;
        MEMORY_READ_EXECUTE = 1;
        forward = 0;
        immediate_check = 0;
        store_check = 0;
        #50;

        source1_INSTRUCTION_DECODE = 5'd5; 
        source2_INSTRUCTION_DECODE = 5'd6;
        destination_EXECUTE = 5'd9; 
        destination_MEMORY = 5'd7;
        branch_command = 2'b0;
        WRITEBACK_EXECUTE = 2'b0;
        WRITEBACK_MEMORY = 2'b0;
        MEMORY_READ_EXECUTE = 1;
        forward = 1;
        immediate_check = 0;
        store_check = 0;
        #50;

        source1_INSTRUCTION_DECODE = 5'd5; 
        source2_INSTRUCTION_DECODE = 5'd6;
        destination_EXECUTE = 5'd5; 
        destination_MEMORY = 5'd7;
        branch_command = 2'b10;
        WRITEBACK_EXECUTE = 2'b1;
        WRITEBACK_MEMORY = 2'b1;
        MEMORY_READ_EXECUTE = 1;
        forward = 0;
        immediate_check = 0;
        store_check = 0;
        #50;

    end


endmodule
