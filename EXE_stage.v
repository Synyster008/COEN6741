module EXE_stage (clock2, input1_select, input2_select, store_select, input1, input2, result_forwarding_MEMORY, result_forwarding_WRITEBACK, result_ALU1, result_ALU2, store_input, store_output, EXECUTE_command);

    input clock2;
    input [1:0] input1_select, input2_select, store_select;
    input [3:0] EXECUTE_command;
    input [31:0] input1, input2, result_forwarding_MEMORY, result_forwarding_WRITEBACK, store_input;
    output [31:0] result_ALU1, result_ALU2, store_output;

    wire [31:0] ALU_input1, ALU_input2;

    mux #(.LENGTH(32)) mux_ALU_input1(
        .in1(input1),
        .in2(result_forwarding_MEMORY),
        .in3(result_forwarding_WRITEBACK),
        .select(input1_select),
        .out(ALU_input1)
    );

    mux #(.LENGTH(32)) mux_ALU_input2(
        .in1(input2),
        .in2(result_forwarding_MEMORY),
        .in3(result_forwarding_WRITEBACK),
        .select(input2_select),
        .out(ALU_input2)
    );

    mux #(.LENGTH(32)) mux_ALU_store(
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

endmodule
