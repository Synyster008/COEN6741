module IF_stage (clock1, clock2, branch_check, branch_address, PC, instruction);

    input clock1, clock2, branch_check;
    input branch_address;
    output reg [31:0] PC;
    output [31:0] instruction;

    wire [31:0] adder_input, adder_output, branch_offset;

    mux #(.LENGTH (32)) adder_pc (
        .in1(32'd4),
        .in2(branch_offset),
        .in3(32'd0),
        .select(branch_check),
        .out(adder_input)
    );

    adder PC_calc (
        .in1(adder_input),
        .in2(PC),
        .out(adder_output)
    );

    always @(posedge clock1) begin
        PC <= adder_output;
    end

    instruction_memory instr (
        .clock(clock2),
        .address(PC),
        .instruction(instruction)
    );

    assign branch_offset = branch_address << 2;

endmodule
