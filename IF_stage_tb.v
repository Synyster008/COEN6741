module IF_stage_tb();

    reg clk1, clk2, hazard, flush, branch_check;
    reg [31:0] branch_address;
    wire [31:0] PC_IF, PC_ID, instruction_IF, instruction_ID;

    IF_stage IF(
        .clock1(clk1),
        .clock2(clk2),
        .hazard(hazard),
        .branch_address(branch_address),
        .branch_check(branch_check),
        .PC_IF(PC_IF), 
        .PC_ID(PC_ID), 
        .instruction_IF(instruction_IF), 
        .instruction_ID(instruction_ID), 
        .flush(flush)
    );

    always begin
        clk1 = 0;
        clk2 = 0;
        repeat(50) begin
        #50 clk1 = ~clk1;
        #50 clk2 = ~clk2;
        end
    end 

    initial begin
        hazard = 0;
        branch_address = 0;
        branch_check = 0;
        flush = 0;
    end
endmodule
