module IF_stage (clock1, clock2, hazard, branch_check, branch_address, PC_IF, PC_ID, instruction_IF, instruction_ID, flush);

    input clock1, clock2, hazard, branch_check, flush;
    input [31:0] branch_address;
    output reg [31:0] PC_IF;
    output [31:0] instruction_ID, instruction_IF, PC_ID;

    wire [31:0] adder_input, adder_output, branch_offset;
    reg [31:0] PC_IF_next;

    initial begin
        PC_IF_next = 0;
    end
    assign branch_offset = branch_address << 2;

    mux2_1 #(.LENGTH (32)) mux_adder_pc (
        .in1(32'd4),
        .in2(branch_offset),
        .select(branch_check),
        .out(adder_input)
    );

    adder PC_calc (
        .in1(adder_input),
        .in2(PC_IF),
        .out(adder_output)
    );

    instruction_memory instr (
        .clock(clock1),
        .address(PC_IF),
        .instruction(instruction_IF)
    );

    always @(posedge clock1) begin
        PC_IF <= PC_IF_next;
        if (~hazard) begin
            PC_IF_next <= adder_output;
        end
    end

    IF_ID IF_ID_buffer(
        .clock2(clock2),
        .stall(hazard), 
        .flush(flush), 
        .PC_input(PC_IF), 
        .PC_output(PC_ID), 
        .instruction_input(instruction_IF), 
        .instruction_output(instruction_ID)
    );

    
 


endmodule
