module  ID_stage_tb();

    reg clock1, hazard;
    reg[4:0] destination_WRITEBACK;
    reg [31:0] PC_ID, instruction_ID;
    wire branch, branch_EXECUTE, MEMORY_READ, MEMORY_READ_EXECUTE, MEMORY_WRITE, MEMORY_WRITE_EXECUTE, immediate_check, store_check;
    wire [1:0] WRITEBACK, WRITEBACK_EXECUTE, branch_command;
    wire [3:0] EXECUTE_command, EXECUTE_command_EXECUTE;
    wire [4:0] source1_address, source2_address1, source2_address2, source1_EXECUTE, source2_EXECUTE, destination_address, destination_EXECUTE;
    wire [31:0] value1_ID, value2_ID, value1_EXECUTE, value2_EXECUTE, PC_EXECUTE;

    integer i;

    ID_stage ID_tb(
        .clock1(clock1), 
        .hazard(hazard), 
        .immediate_check(immediate_check), 
        .store_check(store_check), 
        .instruction_ID(instruction_ID), 
        .value1_ID(value1_ID), 
        .value2_ID(value2_ID), 
        .value1_EXECUTE(value1_EXECUTE), 
        .value2_EXECUTE(value2_EXECUTE), 
        .source1_address(source1_address), 
        .source2_address1(source2_address1), 
        .source2_address2(source2_address2), 
        .source1_EXECUTE(source1_EXECUTE), 
        .source2_EXECUTE(source2_EXECUTE), 
        .destination_WRITEBACK(destination_WRITEBACK), 
        .destination_address(destination_address), 
        .destination_EXECUTE(destination_EXECUTE), 
        .MEMORY_READ(MEMORY_READ), 
        .MEMORY_READ_EXECUTE(MEMORY_READ_EXECUTE), 
        .MEMORY_WRITE(MEMORY_WRITE), 
        .MEMORY_WRITE_EXECUTE(MEMORY_WRITE_EXECUTE), 
        .WRITEBACK(WRITEBACK), 
        .WRITEBACK_EXECUTE(WRITEBACK_EXECUTE), 
        .EXECUTE_command(EXECUTE_command), 
        .EXECUTE_command_EXECUTE(EXECUTE_command_EXECUTE), 
        .branch_command(branch_command), 
        .branch(branch), 
        .branch_EXECUTE(branch_EXECUTE),  
        .PC_ID(PC_ID), 
        .PC_EXECUTE(PC_EXECUTE)
    );

    initial begin
        destination_WRITEBACK = 5'b0;
        hazard = 0;
        i=0;
        PC_ID = 0;
        clock1 = 0;
        repeat(50) begin
        #50 clock1 = ~clock1;
        end
    end

    always @(posedge clock1) begin
        case (i)
            0 : instruction_ID = 32'h0820000f;
            1 : instruction_ID = 32'h04440800;
            2 : instruction_ID = 32'h28a10004;
            3 : instruction_ID = 32'h0ca10007;
            4 : instruction_ID = 32'h2ca20000;
            5 : instruction_ID = 32'h14c0040c;
            6 : instruction_ID = 32'h18a10000;
            7 : instruction_ID = 32'h24a10000;
            8 : instruction_ID = 32'h10e20041;
            9 : instruction_ID = 32'h20200000;
            default: instruction_ID = 32'b0;
        endcase
        PC_ID = PC_ID + 4;
        i = i+1;
    end

endmodule
